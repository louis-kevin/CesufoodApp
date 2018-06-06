import 'package:flutter/material.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
    Widget tabContent,
    TickerProvider vsync,
  }) : _icon = icon,
        _title = title,
        _tabContent = tabContent,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: new Text(title),
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _icon;
  final Widget _tabContent;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(BuildContext context) {

    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),
        child:_tabContent
      ),
    );
  }
}