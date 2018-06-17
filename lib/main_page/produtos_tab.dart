import 'package:cesufood_app/main_page/components/ListItem.dart';
import 'package:cesufood_app/main_page/service.dart';
import 'package:cesufood_app/services/produto_service.dart';
import 'package:flutter/material.dart';

final Service service = new Service();

class ProdutosTab extends StatefulWidget {
  @override
  _ProdutosTabState createState() => _ProdutosTabState();
}

class _ProdutosTabState extends State<ProdutosTab> {
  ProdutoService produtoService;

  getProdutos() {
    return new FutureBuilder(
      future: produtoService.listProdutos(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return buildListView(snapshot.data);
        } else {
          return Center(
            child: new CircularProgressIndicator(),
          );
        }
      },
    );
  }

  buildListView(produtos) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (BuildContext context, int index) =>
          new ListItemProduto(produtos[index]),
    );
  }



  @override
  Widget build(BuildContext context) {
    produtoService = new ProdutoService(context);
    return new Scaffold(
      body: getProdutos(),
    );
  }
}
