import 'package:cesufood_app/main_page/components/ListItem.dart';
import 'package:cesufood_app/service.dart';
import 'package:flutter/material.dart';

final Service service = new Service();

class ProdutosTab extends StatefulWidget {
  var produtos = service.getProdutos();

  @override
  _ProdutosTabState createState() => _ProdutosTabState();
}

class _ProdutosTabState extends State<ProdutosTab> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.produtos.length,
      itemBuilder: (BuildContext context, int index) =>
      new ListItemProduto(widget.produtos[index]),
    );
  }
}
