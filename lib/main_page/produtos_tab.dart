import 'dart:async';

import 'package:cesufood_app/main_page/components/ListItem.dart';
import 'package:cesufood_app/main_page/service.dart';
import 'package:cesufood_app/services/produto_service.dart';
import 'package:flutter/material.dart';

final Service service = new Service();

class ProdutosTab extends StatefulWidget {
  var produtos = [];
  int page = 0;
  int lastPage = -1;
  bool loading = false;

  @override
  _ProdutosTabState createState() => _ProdutosTabState();
}

class _ProdutosTabState extends State<ProdutosTab> {
  ProdutoService produtoService;
  ScrollController controller;

  Future<Null> loadProdutos() async {
    widget.loading = true;
    setState(() {});
    print('carregando os produtos');
    var data = await produtoService.listProdutos(widget.page + 1);
    setState(() {
      widget.page == 0
          ? widget.produtos = data['produtos']
          : widget.produtos.addAll(data['produtos']);
      widget.page = data['page'];
      widget.lastPage = data['lastPage'];
      print(widget.page);
      print(widget.lastPage);
      widget.loading = false;
    });

    return null;
  }

  getProdutos() {
    if (widget.produtos.length > 0) {
      return buildListView(widget.produtos);
    } else {
      if (!widget.loading) {
        loadProdutos();
      }
      return Container();
    }
  }

  getLoadingProdutos() {
    return widget.lastPage > widget.page || widget.lastPage == -1
        ? new Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: new CircularProgressIndicator(),
            ),
        )
        : Container();
  }

  @override
  initState() {
    controller = new ScrollController()
      ..addListener(() {
        if (controller.position.maxScrollExtent > 100 &&
            controller.offset >= controller.position.maxScrollExtent &&
            (widget.lastPage > widget.page || widget.lastPage == -1)) {
          loadProdutos();
        }
      });
    super.initState();
  }

  List<Widget> makeProdutoItens() {
    List<Widget> produtos = [];
    for(var i = 0; i < widget.produtos.length; i++){
      if(widget.produtos.length > i + 1){
        produtos.add(new ListItemProduto(widget.produtos[i]));
      }else{
        produtos.add(getLoadingProdutos());
      }
    }
    return produtos;

  }

  buildListView(List produtos) {
    return new RefreshIndicator(
      onRefresh: () async {
        widget.page = 0;
        return await loadProdutos();
      },
      child: ListView(
        controller: controller,
        children: makeProdutoItens(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    produtoService = new ProdutoService(context);
    return Scaffold(body: getProdutos());
  }
}
