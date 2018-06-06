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
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      itemCount: produtos.length,
      itemBuilder: (BuildContext context, int index) {
        return CardProduto(
         produto: produtos[index],
        );
      },
    );
  }
}
