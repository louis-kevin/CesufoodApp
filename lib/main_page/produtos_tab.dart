import 'package:cesufood_app/main_page/components/ListItem.dart';
import 'package:cesufood_app/service.dart';
import 'package:flutter/material.dart';

final Service service = new Service();

class ProdutosTab extends StatefulWidget {
  @override
  _ProdutosTabState createState() => _ProdutosTabState();
}

class _ProdutosTabState extends State<ProdutosTab> {

  buildListView(produtos){
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (BuildContext context, int index) =>
      new ListItemProduto(produtos[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return service.buildProdutos(service.getProdutos(), buildListView);
  }
}
