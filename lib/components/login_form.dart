import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var fieldRaError = false;
  var fieldSenhaError = false;

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      child: new Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  fieldRaError = true;
                  return 'Este campo é obrigatorio';
                }
                fieldRaError = false;
              },
              style: new TextStyle(color: Color(0xFFC0C4CC)),
              maxLength: 8,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                icon: new Icon(
                  Icons.people,
                  color: Color(fieldRaError ? 0xFFFF4444 : 0xFFC0C4CC),
                ),
                labelText: 'RA',
                labelStyle: new TextStyle(
                    color: Color(fieldRaError ? 0xFFFF4444 : 0xFFC0C4CC)),
                errorStyle: new TextStyle(color: Color(0xFFFF4444)),
                counterStyle: new TextStyle(
                    color: Color(fieldRaError ? 0xFFFF4444 : 0xFFC0C4CC)),
              ),
            ),
            new TextFormField(
              validator: (value) {
                if (value.length < 6) {
                  fieldSenhaError = true;
                  return 'A senha precisa ter pelo menos 6 caracteries';
                }
                fieldSenhaError = false;
              },
              style: new TextStyle(color: Color(0xFFC0C4CC)),
              decoration: new InputDecoration(
                icon: new Icon(
                  Icons.lock,
                  color: Color(fieldSenhaError ? 0xFFFF4444 : 0xFFC0C4CC),
                ),
                labelText: 'Senha',
                labelStyle: new TextStyle(
                    color: Color(fieldSenhaError ? 0xFFFF4444 : 0xFFC0C4CC)),
                errorStyle: new TextStyle(color: Color(0xFFFF4444)),
                counterStyle: new TextStyle(
                    color: Color(fieldSenhaError ? 0xFFFF4444 : 0xFFC0C4CC)),
              ),
            ),
            new Center(
              child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new InkWell(
                  child: new Container(
                    decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            begin: Alignment.centerLeft, // new
                            end: Alignment.centerRight,
                            colors: [
                          new Color(0xFF39517D),
                          new Color(0xFF39517D),
                        ])),
                    width: 287.4,
                    height: 47.7,
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Center(child: new Text('LOGIN', style: new TextStyle(color: Colors.white))),
                    ),
                  ),
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
              ),
            ),
          ],
        ),
      ), // We'll build this out in the next steps!
    );
  }
}
