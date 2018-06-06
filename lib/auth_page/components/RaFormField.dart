import 'package:cesufood_app/components/ensure_visible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RaFormField extends StatefulWidget {
  final color;
  final TextEditingController controller;

  const RaFormField({Key key, this.color = 0xFFC0C4CC, this.controller}) : super(key: key);

  @override
  _RaFormFieldState createState() => new _RaFormFieldState();
}

class _RaFormFieldState extends State<RaFormField> {
  var fieldRaError = false;
  FocusNode focusNode = new FocusNode();



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
          if(value.toString().length != 8) {
            fieldRaError = true;
            return 'RA Inválido';
          }
          fieldRaError = false;
        },
        style: new TextStyle(
          color: Color(widget.color),
        ),
        maxLength: 8,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          icon: new Icon(
            Icons.person,
            color: Color(fieldRaError ? 0xFFFF4444 : widget.color),
          ),
          labelText: 'RA',
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
