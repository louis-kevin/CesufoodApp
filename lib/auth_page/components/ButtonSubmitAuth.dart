import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonSubmitAuth extends StatefulWidget {
  final Function onTap;
  final String text;

  const ButtonSubmitAuth({Key key, this.onTap, this.text}) : super(key: key);

  @override
  _ButtonSubmitAuthState createState() => new _ButtonSubmitAuthState();
}

class _ButtonSubmitAuthState extends State<ButtonSubmitAuth> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(vertical: 28.6),
      child: new MaterialButton(
        color: new Color(0xFF39517D),
        textColor: Colors.white,
        onPressed: widget.onTap,
        minWidth: double.infinity,
        height: 47.7,
        child:new Text(
          widget.text,
        ),
      ),
    );
  }
}
