import 'package:cesufood_app/main_page/components/CardProduto.dart';
import 'package:flutter/material.dart';

class DestaquesTab extends StatefulWidget {
  @override
  _DestaquesTabState createState() => _DestaquesTabState();
}

class _DestaquesTabState extends State<DestaquesTab> {
  var produtos = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 36.0, left: 16.0, right: 16.0),
      itemCount: produtos.length,
      itemBuilder: (BuildContext context, int index) {
        return CardProduto(
          nome: 'teste',
          urlFoto: 'teste',
          id: 1,
          preco: 10.5,
        );
      },
    );
  }
}
