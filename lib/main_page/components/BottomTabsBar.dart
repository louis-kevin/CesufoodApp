import 'package:cesufood_app/main_page/components/NavigationIconView.dart';
import 'package:flutter/material.dart';

class BottomTabsBar extends StatelessWidget {
  const BottomTabsBar({
    Key key,
    @required this.currentIndex,
    @required this.onChange,
    @required this.items
  }) : super(key: key);

  final int currentIndex;
  final Function onChange;
  final List<NavigationIconView> items;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: new BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onChange,
        items: items.map((NavigationIconView navigationView) => navigationView.item)
            .toList(),
      ),
    );
  }
}