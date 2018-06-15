import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:cesufood_app/config.dart';
import 'package:flutter/material.dart';
import 'package:quiver/cache.dart';
import 'package:http/http.dart' as http;

class Service {
  Service(this.context);

  BuildContext context;
  final cache = new MapCache();

  _updateToken(tokenFromHeader, tokenFromBody) {
    if (tokenFromBody != null) {
      this.cache.set(JWT_TOKEN_NAME, tokenFromBody);
    } else if (tokenFromHeader != null) {
      this.cache.set(JWT_TOKEN_NAME, tokenFromHeader);
    }
  }

  Future<Object> _getHeaders() async {
    var token = await _getToken();
    return {
      HttpHeaders.AUTHORIZATION: token,
      HttpHeaders.ACCEPT: 'application/json',
      HttpHeaders.CONTENT_TYPE: 'application/json'
    };
  }

  Future<String> _getToken() async {
    return await this.cache.get(JWT_TOKEN_NAME).catchError(() => '');
  }

  String _getUrl(String url, [Map<String, String> params]) {
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

        url += key + '=' + value;

      });
    }
    return URL_BASE + '/' + url;
  }

  _makeResponse(http.Response response) {
    var body = json.decode(response.body);
    _updateToken(response.headers['new_token'], body['token']);

    return ParsedResponse(this.context, response.statusCode, body);
  }

  post(url, Object data) async {
    var response = await http.post(
      _getUrl(url),
      headers: await _getHeaders(),
      body: json.encode(data),
    );
    return _makeResponse(response);
  }

  get(url, [Map<String, String> params]) async {
    var response = await http.get(
      _getUrl(url, params),
      headers: await _getHeaders(),
    );
    return _makeResponse(response);
  }
}

class ParsedResponse {
  int code;
  String message;
  Map<String, dynamic> response;
  Map<String, dynamic> data;
  bool success;
  int type;

  static const OK = 200;
  static const BAD_REQUEST = 400;
  static const UNAUTHORIZED = 401;
  static const INTERNAL = 401;

  BuildContext context;

  ParsedResponse(this.context, this.code, this.response) {
    this.message = this.response.containsKey('message') ? this.response['message'] : '';
    this.data = this.response['data'];
    this.success = this.response['success'];
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

  Map<String, dynamic> getData() => this.data;

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
