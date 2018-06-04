import 'dart:math' as math;

import 'package:flutter/material.dart';

class PosseDemo extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: [
          new SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            title: new Text('AppBar example'),
            flexibleSpace: new FlexibleSpaceBar(
              background: new Image.network(
                'http://i.telegraph.co.uk/multimedia/archive/02830/cat_2830677b.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          new SliverToBoxAdapter(
            child: new Container(
              height: 600.0,
              child: new FlutterLogo(),
            ),
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(home: new PosseDemo()));
}