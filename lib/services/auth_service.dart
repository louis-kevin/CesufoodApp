import 'dart:async';
import 'package:cesufood_app/config.dart';
import 'package:cesufood_app/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends Service {
  AuthService(context) : super(context);

  Future<ParsedResponse> login(Object params) async {
    ParsedResponse response = await super.post('login', params);

    return response;
  }

  Future<ParsedResponse> cadastro(Object params) async {
    ParsedResponse response = await super.post('cadastro', params);

    return response;
  }

  Future<ParsedResponse> getMe() async {
    ParsedResponse response = await super.get('me');

    return response;
  }

  Future logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove(JWT_TOKEN_NAME);

    return true;
  }

  Future<bool> checkAuthentication() async {
    return await super.getToken() != null;
  }
}
