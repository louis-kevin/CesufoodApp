import 'package:cesufood_app/auth_page/auth_page.dart';
import 'package:cesufood_app/main_page/tabs_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

ThemeData buildAuthTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    primaryColor: Color(0xFF4F689C),
    accentColor: Color(0xFFFFA500),
    buttonColor: Color(0xFFFFA500),
    hintColor: Color(0xFFC0C4CC),
    textTheme: buildTextTheme(base.textTheme, Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: new TextStyle(color: Color(0xFFC0C4CC)),
      errorStyle: new TextStyle(color: Color(0xFFFF4444)),
      counterStyle: new TextStyle(color: Color(0xFFC0C4CC)),
    ),
  );
}

TextTheme buildTextTheme(TextTheme base, Color color) {
  return base.copyWith(
    body1: base.headline.copyWith(color: color, fontSize: 16.0),
    caption: base.headline.copyWith(color: Colors.grey),
    display1: base.headline.copyWith(color: color),
    button: base.headline.copyWith(color: color),
    headline: base.headline.copyWith(color: color),
    title: base.title.copyWith(color: color),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CesufoodApp',
      debugShowCheckedModeBanner: false,
      theme: buildAuthTheme(),
      home: new AuthPage(),
      routes: <String, WidgetBuilder> { //5
        '/main': (BuildContext context) => new MainPage(), //6
      },
    );
  }
}
