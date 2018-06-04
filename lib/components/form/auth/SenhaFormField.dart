import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SenhaFormField extends StatefulWidget {
  final color;

  const SenhaFormField({Key key, this.color = 0xFFC0C4CC}) : super(key: key);

  @override
  _SenhaFormFieldState createState() => new _SenhaFormFieldState();
}

class _SenhaFormFieldState extends State<SenhaFormField> {
  var fieldSenhaError = false;
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      validator: (value) {
        if (value.length < 6) {
          fieldSenhaError = true;
          return 'A senha precisa ter pelo menos 6 caracteries';
        }
        fieldSenhaError = false;
      },
      style: new TextStyle(color: Color(widget.color)),
      decoration: new InputDecoration(
        icon: new Icon(
          Icons.lock,
          color: Color(fieldSenhaError ? 0xFFFF4444 : widget.color),
        ),
        labelText: 'Senha',
        labelStyle: new TextStyle(
            color: Color(fieldSenhaError ? 0xFFFF4444 : widget.color)),
        counterStyle: new TextStyle(
            color: Color(fieldSenhaError ? 0xFFFF4444 : widget.color)),
      ),
    );
  }
}
