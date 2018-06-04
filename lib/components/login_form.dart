import 'package:cesufood_app/components/form/auth/ButtonSubmitAuth.dart';
import 'package:cesufood_app/components/form/auth/RaFormField.dart';
import 'package:cesufood_app/components/form/auth/SenhaFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      child: new Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new RaFormField(
              color: 0xFFC0C4CC,
            ),
            new SenhaFormField(
              color: 0xFFC0C4CC,
            ),
            new ButtomSubmitAuth(
              text: 'LOGIN',
              onTap: () {
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context).showSnackBar(
                      new SnackBar(content: new Text('Processing Data')));
                } else {
                  setState(() {});
                }
              },
            ),
           new Center(
             child: new Text('Esqueceu a senha?', style: new TextStyle(color:Color(0xFFC0C4CC) ),),
           ),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 28.5),
              child: new Divider(height: 10.0,color: Color(0xFFC0C4CC),),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: new Text('Não tem conta?', style: new TextStyle(color:Color(0xFFC0C4CC) ),),
                ),
                new Text('Cadastre-se')
              ],
            ),
          ],
        ),
      ), // We'll build this out in the next steps!
    );
  }
}
