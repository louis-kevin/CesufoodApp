import 'package:cesufood_app/components/form/auth/ButtonSubmitAuth.dart';
import 'package:cesufood_app/components/form/auth/RaFormField.dart';
import 'package:cesufood_app/components/form/auth/SenhaFormField.dart';
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    inputRAController.dispose();
    inputSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          new RaFormField(
            color: 0xFFC0C4CC,
            controller: inputRAController,
          ),
          new SenhaFormField(
              color: 0xFFC0C4CC, controller: inputSenhaController),
          new ButtomSubmitAuth(
            text: 'LOGIN',
            onTap: () {
              if (_formKey.currentState.validate()) {
                // TODO Enviar Request
                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: new Text(inputRAController.text)));
              }
              setState(() {});
            },
          ),
          new FlatButton(
            color: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.grey.withOpacity(0.1),
            textColor: Color(0xFFC0C4CC),
            onPressed: () => widget.onChangePage(PAGE_ESQUECI_SENHA),
            child: new Text(
              'Esqueceu a senha?',
            ),
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.5),
            child: new Divider(
              height: 10.0,
              color: Color(0xFFC0C4CC),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: new FlatButton(
                color: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.grey.withOpacity(0.1),
                textColor: Color(0xFFC0C4CC),
                onPressed: () => widget.onChangePage(PAGE_CADASTRO),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: new Text(
                        'Não tem conta?',
                      ),
                    ),
                    new Text('Cadastre-se',
                      style: new TextStyle(color: Colors.white),
                    ),
                  ],
                ),
            ),
          ),
        ],
      ), // We'll build this out in the next steps!
    );
  }
}
