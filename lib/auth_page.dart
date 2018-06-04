import 'package:cesufood_app/components/login_form.dart';
import 'package:cesufood_app/components/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomRight,
          colors: [
            new Color(0xFF283B60),
            new Color(0xFF4F689C),
          ],
        ),
      ),
      child: new SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: new Column(
          children: <Widget>[
            new Container(
              height: 24.0,
              width: double.infinity,
              decoration: new BoxDecoration(color: new Color(0xFF335087)),
            ),
            new Container(
              height: 250.0,
              width: double.infinity,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(
                      left: 90.0,
                      right: 90.0,
                      top: 26.0,
                      bottom: 10.0,
                    ),
                    child: new Logo(),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'CESU',
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      new Text(
                        'FOOD',
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            new LoginForm(),
          ],
        ),
      ),
    );
  }
}
