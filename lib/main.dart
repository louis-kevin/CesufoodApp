import 'package:cesufood_app/auth_page/auth_page.dart';
import 'package:cesufood_app/main_page/tabs_page.dart';
import 'package:cesufood_app/services/auth_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(new CesufoodApp());

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

class CesufoodApp extends StatelessWidget {
  isAthenticated(context){
    var authService = new AuthService(context);
    return new FutureBuilder(
      future: authService.checkAuthentication(),
      builder: (_, snapshot){
        print(snapshot.error);
        print(snapshot.data);
        if(snapshot.hasData && snapshot.data){
          return MainPage();
        }else{
          return AuthPage();
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CesufoodApp',
      debugShowCheckedModeBanner: false,
      theme: buildAuthTheme(),
      home: isAthenticated(context),
      routes: <String, WidgetBuilder> { //5
        '/main': (BuildContext context) => new MainPage(), //6
      },
    );
  }
}
