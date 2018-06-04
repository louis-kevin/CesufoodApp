import 'package:cesufood_app/auth_page.dart';
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
      labelStyle:new TextStyle(
          color: Color(0xFFC0C4CC)
      ),
      errorStyle: new TextStyle(color: Color(0xFFFF4444)),
      counterStyle: new TextStyle(
          color: Color(0xFFC0C4CC)),
    ),
  );
}

TextTheme buildTextTheme(TextTheme base, Color color) {
  return base.copyWith(
    body1: base.headline.copyWith(color: color, fontSize: 16.0),
    caption: base.headline.copyWith(color: color),
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
        theme: buildAuthTheme(),
        home: new Scaffold(
          body: new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      begin: Alignment.center, // new
                      end: Alignment.bottomRight,
                      colors: [
                    new Color(0xFF283B60),
                    new Color(0xFF4F689C),
                  ])),
              child: new AuthPage()),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
