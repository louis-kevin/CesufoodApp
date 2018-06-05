import 'package:cesufood_app/components/ensure_visible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SenhaFormField extends StatefulWidget {
  final color;
  final TextEditingController controller;

  const SenhaFormField({Key key, this.color = 0xFFC0C4CC, this.controller}) : super(key: key);

  @override
  _SenhaFormFieldState createState() => new _SenhaFormFieldState();
}

class _SenhaFormFieldState extends State<SenhaFormField> {
  var fieldSenhaError = false;
  FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return new EnsureVisibleWhenFocused(
      duration: new Duration(milliseconds: 100),
      focusNode: focusNode,
      child: new TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value.length < 6) {
            fieldSenhaError = true;
            return 'A senha precisa ter pelo menos 6 caracteries';
          }
          fieldSenhaError = false;
        },
        focusNode: focusNode,
        obscureText: true,
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
      ),
    );
  }
}
