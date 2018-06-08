import 'package:cesufood_app/main_page/components/BottomTabsBar.dart';
import 'package:cesufood_app/main_page/components/NavigationIconView.dart';
import 'package:cesufood_app/main_page/destaques_tab.dart';
import 'package:cesufood_app/main_page/perfil_tab.dart';
import 'package:cesufood_app/main_page/produtos_tab.dart';
import 'package:flutter/material.dart';

const TAB_DESTAQUES = 0;
const TAB_PRODUTOS = 1;
const TAB_PERFIL = 2;

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int currentIndex = 0;

  List<NavigationIconView> barNavigationItems;

  @override
  initState() {
    super.initState();
    barNavigationItems = <NavigationIconView>[
      new NavigationIconView(
          icon: new Icon(Icons.dashboard),
          title: 'Destaques',
          vsync: this,
          tabContent: DestaquesTab()
      ),
      new NavigationIconView(
          icon: new Icon(Icons.list),
          title: 'Produtos',
          vsync: this,
          tabContent: ProdutosTab()
      ),
      new NavigationIconView(
          icon: new Icon(Icons.person),
          title: 'Perfil',
          vsync: this,
          tabContent: PerfilTab()
      )
    ];
    for (NavigationIconView view in barNavigationItems)
      view.controller.addListener(_rebuild);

    barNavigationItems[currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    super.dispose();

    for (NavigationIconView view in barNavigationItems)
      view.controller.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  setCurrentIndex(index) {
    setState(() {
      barNavigationItems[currentIndex].controller.reverse();
      currentIndex = index;
      barNavigationItems[currentIndex].controller.forward();
    });
  }

  Widget getTab() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in barNavigationItems)
      transitions.add(view.transition(context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new Container(
            decoration: new BoxDecoration(color: Colors.red),
            child: getTab(),
          ),
        ),
        new BottomTabsBar(
          currentIndex: currentIndex,
          onChange: setCurrentIndex,
          items: barNavigationItems,
        ),
      ],
    );
  }
}


