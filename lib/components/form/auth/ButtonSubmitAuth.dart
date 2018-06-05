import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtomSubmitAuth extends StatefulWidget {
  final Function onTap;
  final String text;

  const ButtomSubmitAuth({Key key, this.onTap, this.text}) : super(key: key);

  @override
  _ButtomSubmitAuthState createState() => new _ButtomSubmitAuthState();
}

class _ButtomSubmitAuthState extends State<ButtomSubmitAuth> {
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
