import 'package:cesufood_app/services/service.dart';

class AuthService extends Service {
  AuthService(context) : super(context);

  login(Object params) async {
    ParsedResponse response = await super.post('login', params);

    return response;
  }

  cadastro(Object params) async {
    ParsedResponse response = await super.post('cadastro', params);

    return response;
  }
}
