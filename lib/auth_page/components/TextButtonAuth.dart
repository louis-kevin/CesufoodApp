import 'package:flutter/material.dart';

class TextButtonAuth extends StatelessWidget {
  final String firstText;
  final String secondText;

  final Function onPressed;

  const TextButtonAuth({
    Key key,
    @required this.onPressed,
    @required this.firstText,
    this.secondText,
  }) : super(key: key);

  _getTexts() {
    var texts = <Widget>[];
    texts.add(
      new Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: new Text(
          this.firstText,
        ),
      ),
    );

    if (this.secondText != null) {
      texts.add(
        new Text(
          this.secondText,
          style: new TextStyle(color: Colors.white),
        ),
      );
    }
    return texts;
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: new FlatButton(
        color: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Theme.of(context).accentColor.withOpacity(0.1),
        textColor: Color(0xFFC0C4CC),
        onPressed: this.onPressed,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getTexts(),
        ),
      ),
    );
  }
}
