import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RaFormField extends StatefulWidget {
  final color;

  const RaFormField({Key key, this.color = 0xFFC0C4CC}) : super(key: key);

  @override
  _RaFormFieldState createState() => new _RaFormFieldState();
}

class _RaFormFieldState extends State<RaFormField> {
  var fieldRaError = false;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          fieldRaError = true;
          return 'Este campo é obrigatorio';
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
          Icons.people,
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
    );
  }

}
