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
    return new Column(
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
                    left: 120.0, right: 120.0, top: 26.0, bottom: 10.0),
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
                        fontFamily: 'Roboto'),
                  ),
                  new Text(
                    'FOOD',
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'),
                  ),
                ],
              )
            ],
          ),
        ),
        new Expanded(
          child: new Container(
            height: 150.0,
            width: double.infinity,
            child: new LoginForm()
          ),
        ),
        new Container(
          height: 70.0,
          width: double.infinity,
          decoration: new BoxDecoration(color: Colors.blue),
        ),
        new Container(
          height: 70.0,
          width: double.infinity,
          decoration: new BoxDecoration(color: Colors.orange),
        )
      ],
    );
  }
}
