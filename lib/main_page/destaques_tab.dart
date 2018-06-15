import 'package:cesufood_app/main_page/components/CardProduto.dart';
import 'package:cesufood_app/main_page/service.dart';
import 'package:flutter/material.dart';

final Service service = new Service();

class DestaquesTab extends StatefulWidget {
  @override
  _DestaquesTabState createState() => _DestaquesTabState();
}

class _DestaquesTabState extends State<DestaquesTab> {

  Widget buildGridView(produtos){
    return  GridView.count(
      childAspectRatio: 0.8,
      crossAxisCount: 2,
      padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
      children: new List.generate(
        produtos.length,
            (index) {
          return CardProduto(
            produtos[index],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return service.buildProdutos(service.getProdutosDestaques(), buildGridView);
  }
}
