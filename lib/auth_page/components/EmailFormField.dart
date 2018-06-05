import 'package:cesufood_app/components/ensure_visible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmailFormField extends StatefulWidget {
  final color;
  final TextEditingController controller;

  const EmailFormField({Key key, this.color = 0xFFC0C4CC, this.controller}) : super(key: key);

  @override
  _EmailFormFieldState createState() => new _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  var fieldRaError = false;
  FocusNode focusNode = new FocusNode();

  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return new EnsureVisibleWhenFocused(
      focusNode: focusNode,
      child: new TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value.isEmpty) {
            fieldRaError = true;
            return 'Este campo é obrigatorio';
          }

          if(!isEmail(value)){
            fieldRaError = true;
            return 'Email inválido';
          }
          fieldRaError = false;
        },
        style: new TextStyle(
          color: Color(widget.color),
        ),
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
          icon: new Icon(
            Icons.email,
            color: Color(fieldRaError ? 0xFFFF4444 : widget.color),
          ),
          labelText: 'Email',
          labelStyle: new TextStyle(
            color: Color(fieldRaError ? 0xFFFF4444 : widget.color),
          ),
          counterStyle: new TextStyle(
            color: Color(fieldRaError ? 0xFFFF4444 : widget.color),
          ),
        ),
      ),
    );
  }
}
