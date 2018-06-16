import 'dart:async';

import 'package:cesufood_app/auth_page/components/ButtonSubmitAuth.dart';
import 'package:cesufood_app/auth_page/components/RaFormField.dart';
import 'package:cesufood_app/auth_page/components/SenhaFormField.dart';
import 'package:cesufood_app/auth_page/components/TextButtonAuth.dart';
import 'package:cesufood_app/services/auth_service.dart';
import 'package:cesufood_app/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

const PAGE_CADASTRO = 2;
const PAGE_ESQUECI_SENHA = 3;

class LoginForm extends StatefulWidget {
  final Function onChangePage;

  const LoginForm({Key key, this.onChangePage}) : super(key: key);

  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController inputRAController =
      new MaskedTextController(mask: '00000000');
  final TextEditingController inputSenhaController =
      new TextEditingController();

  String errorInputRa = '';
  String errorInputSenha = '';
  bool loading = false;

  AuthService authService;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    inputRAController.dispose();
    inputSenhaController.dispose();
    super.dispose();
  }

  sendLoginForm(context) async {
    Object data = {
      'ra': inputRAController.text,
      'senha': inputSenhaController.text
    };
    ParsedResponse response = await this.authService.login(data);

    if (response.isOk()) {
      errorInputRa = '';
      errorInputSenha = '';
      //Navigator.of(context).pushNamed('/main');
      await this.authService.login(data);
    }

    if (response.isBadRequest()) {
      errorInputRa = response.getFirstErrorInput('ra');
      errorInputSenha = response.getFirstErrorInput('senha');
    }
    setState(() { loading = false; });
  }

  getButtom(context){
    if(loading){
      return new Container(
        padding: new EdgeInsets.symmetric(vertical: 34.6),
        width: double.infinity,
        child: Center(
          child: new CircularProgressIndicator(),// TODO alinhar loading
        ),
      );
    }

    return new ButtonSubmitAuth(
      text: 'LOGIN',
      onTap: () async {
        if (!_formKey.currentState.validate()) {
          setState(() {});
          return false;
        }
        setState(() { loading = true; });
        sendLoginForm(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    this.authService = new AuthService(context);
    return new Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          new RaFormField(
            color: 0xFFC0C4CC,
            controller: inputRAController,
            errorText: errorInputRa,
          ),
          new SenhaFormField(
            color: 0xFFC0C4CC,
            controller: inputSenhaController,
            errorText: errorInputSenha,
          ),
          getButtom(context),
          new TextButtonAuth(
            onPressed: () => widget.onChangePage(PAGE_ESQUECI_SENHA),
            firstText: 'Esqueceu a senha?',
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.5),
            child: new Divider(
              height: 10.0,
              color: Color(0xFFC0C4CC),
            ),
          ),
          new TextButtonAuth(
            onPressed: () => widget.onChangePage(PAGE_CADASTRO),
            firstText: 'Não tem conta?',
            secondText: 'Cadastre-se',
          ),
        ],
      ), // We'll build this out in the next steps!
    );
  }
}
