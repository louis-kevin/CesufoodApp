import 'dart:async';

import 'package:cesufood_app/config.dart';
import 'package:cesufood_app/services/service.dart';
import 'package:quiver/cache.dart';

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

  Future checkAuthentication() async {
    var cache = new MapCache();
    var token = await cache.get(JWT_TOKEN_NAME);

    return token;


  }
}
