import 'dart:async';

import 'package:cesufood_app/main_page/components/CardProduto.dart';
import 'package:cesufood_app/main_page/service.dart';
import 'package:cesufood_app/services/produto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final Service service = new Service();

class DestaquesTab extends StatefulWidget {
  List<dynamic> produtosDestaques = [];
  int page = 0;
  int lastPage = -1;

  @override
  _DestaquesTabState createState() => _DestaquesTabState();
}

class _DestaquesTabState extends State<DestaquesTab> {
  ProdutoService produtoService;
  ScrollController controller;

  Future<Null> loadProdutosDestaques() async {
    print('carregando produtos');
    var response =
        await produtoService.listProdutos(widget.page + 1, destaque: true);

    widget.page == 0
        ? widget.produtosDestaques = response['produtos']
        : widget.produtosDestaques.addAll(response['produtos']);
    widget.page = response['page'];
    widget.lastPage = response['page'];

    if (this.mounted) setState(() {});
  }

  @override
  initState() {
    controller = new ScrollController()
      ..addListener(() {
        if (controller.position.maxScrollExtent > 100 &&
            controller.offset >= controller.position.maxScrollExtent &&
            (widget.lastPage > widget.page || widget.lastPage == -1)) {
          loadProdutosDestaques();
        }
      });

    setState(() {
      loadProdutosDestaques();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    produtoService = new ProdutoService(context);
    return Scaffold(
      body: new RefreshIndicator(
        onRefresh: () async {
          widget.page = 0;
          return await loadProdutosDestaques();
        },
        child: StaggeredGridView.countBuilder(
          controller: controller,
          itemCount: widget.produtosDestaques.length,
          itemBuilder: (BuildContext context, int index) =>
              CardProduto(widget.produtosDestaques[index]),
          staggeredTileBuilder: (int index) =>
          new StaggeredTile.fit(2),
          crossAxisCount: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}
