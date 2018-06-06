import 'package:cesufood_app/main_page/components/CardProduto.dart';
import 'package:cesufood_app/service.dart';
import 'package:flutter/material.dart';

final Service service = new Service();

class DestaquesTab extends StatefulWidget {
  @override
  _DestaquesTabState createState() => _DestaquesTabState();
}

class _DestaquesTabState extends State<DestaquesTab> {
  var produtos = service.getProdutosDestaques();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 36.0, left: 16.0, right: 16.0),
      itemCount: produtos.length,
      itemBuilder: (BuildContext context, int index) {
        return CardProduto(
         produto: produtos[index],
        );
      },
    );
  }
}
