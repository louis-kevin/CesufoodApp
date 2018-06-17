import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:cesufood_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Service {
  Service([this.context]);

  BuildContext context;

  _updateToken(tokenFromHeader, tokenFromBody) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tokenFromBody != null) {
      await prefs.setString(JWT_TOKEN_NAME, tokenFromBody);
    } else if (tokenFromHeader != null) {
      await prefs.setString(JWT_TOKEN_NAME, tokenFromHeader);
    }
  }

  Future<Object> _makeHeaders() async {
    var token = await getToken();
    return {
      HttpHeaders.AUTHORIZATION: 'Bearer ' + token,
      HttpHeaders.ACCEPT: 'application/json',
      HttpHeaders.CONTENT_TYPE: 'application/json'
    };
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(JWT_TOKEN_NAME);
  }

  String _makeUrl(String url, [Map<String, dynamic> params]) {
    url = url.trim();
    if (url[0] == '/') {
      url = url.substring(1);
    }

    if(params != null && params.length > 0){
      params.forEach((key, value) {
        if(!url.contains('?')){
          url += '?';
        }

        if(url.substring(url.length - 1) != '?'){
          url += '&';
        }

        url += key + '=' + value.toString();

      });
    }
    return URL_BASE + '/' + url;
  }

  _makeBody([Object data]){
    if(data == null){
      return null;
    }
    return json.encode(data);
  }

  _makeResponse(http.Response response) {
    var body = json.decode(response.body);
    _updateToken(response.headers['new_token'], body['token']);
    return ParsedResponse(this.context, response.statusCode, body);
  }

  post(url, [Object data]) async {
    var response = await http.post(
      _makeUrl(url),
      headers: await _makeHeaders(),
      body: _makeBody(data),
    );
    return _makeResponse(response);
  }

  get(url, [Map<String, dynamic> params]) async {
    var response = await http.get(
      _makeUrl(url, params),
      headers: await _makeHeaders(),
    );
    return _makeResponse(response);
  }
}

class ParsedResponse {
  int code;
  String message;
  Map<String, dynamic> response;
  var data;
  bool success;
  int type;
  int page;
  int lastPage;

  static const OK = 200;
  static const BAD_REQUEST = 400;
  static const UNAUTHORIZED = 401;

  static const INTERNAL = 401;

  BuildContext context;

  ParsedResponse(this.context, this.code, this.response) {
    this.message = this.response.containsKey('message') ? this.response['message'] : '';
    this.data = this.response['data'];
    this.success = this.response['success'];
    this.page = this.response['meta'] != null ? this.response['meta']['current_page'] : 1;
    this.lastPage = this.response['meta'] != null ? this.response['meta']['last_page'] : 1;
    if (this.isOk()) {
      this.type = ParsedResponse.OK;
    } else if (this.isBadRequest()) {
      this.type = ParsedResponse.BAD_REQUEST;
    } else if (this.isUnauthorized()) {
      this.type = ParsedResponse.UNAUTHORIZED;
    } else {
      this.type = ParsedResponse.INTERNAL;
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(this.message)));
    }
  }


  bool isOk() => this.code >= 200 && this.code <= 300;

  bool isBadRequest() => this.code == ParsedResponse.BAD_REQUEST;

  bool isUnauthorized() => this.code == ParsedResponse.UNAUTHORIZED;

  getData() => this.data;
  getPage() => this.page;
  getLastPage() => this.lastPage;

  String getMessage() => this.message;

  bool hasInputError(String input) {
    if (!this.isBadRequest()) {
      return false;
    }
    return this.data.containsKey(input);
  }

  List<dynamic> getErrorsInput(String input) {
    if (!this.hasInputError(input)) {
      return new List();
    }

    if (this.data[input].length <= 0) {
      return new List();
    }

    return this.data[input];
  }

  String getFirstErrorInput(String input) {
    if (this.getErrorsInput(input).length <= 0) {
      return '';
    }
    return this.getErrorsInput(input)[0];
  }

}
