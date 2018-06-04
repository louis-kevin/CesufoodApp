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
      padding: const EdgeInsets.symmetric(vertical: 36.0),
      child: new InkWell(
        child: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  begin: Alignment.centerLeft, // new
                  end: Alignment.centerRight,
                  colors: [
                    new Color(0xFF39517D),
                    new Color(0xFF4F689C),
                  ]),
              borderRadius: new BorderRadius.all(new Radius.circular(5.0))
          ),
          width: double.infinity,
          height: 47.7,
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Center(
                child: new Text(widget.text,
                    style: new TextStyle(color: Colors.white))),
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
