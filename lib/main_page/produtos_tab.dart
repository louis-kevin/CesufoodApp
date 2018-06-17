import 'dart:async';

import 'package:cesufood_app/classes/categoria.dart';
import 'package:cesufood_app/classes/produto.dart';
import 'package:cesufood_app/main_page/components/CategoriaChip.dart';
import 'package:cesufood_app/main_page/components/ListItem.dart';
import 'package:cesufood_app/main_page/service.dart';
import 'package:cesufood_app/services/produto_service.dart';
import 'package:flutter/material.dart';

final Service service = new Service();

class ProdutosTab extends StatefulWidget {
  List<dynamic> produtos = [];
  List<Categoria> categorias = [];
  int page = 0;
  int lastPage = -1;
  bool loading = false;
  int categoriaId = 1;
  String search = '';

  @override
  _ProdutosTabState createState() => _ProdutosTabState();
}

class _ProdutosTabState extends State<ProdutosTab> {
  ProdutoService produtoService;
  ScrollController controller;
  Timer debouncingSearch;

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

    setState(() {
      loadProdutos();
      loadCategorias();
    });

    super.initState();
  }

  Future<Null> loadCategorias() async {
    List<Categoria> categorias = await produtoService.listCategorias();
    widget.categorias = categorias;

    if (this.mounted) setState(() {});

    return null;
  }

  Future<Null> loadProdutos() async {
    setState(() => widget.loading = true);

    var data = await produtoService.listProdutos(
      widget.page + 1,
      categoria: widget.categoriaId,
      search: widget.search,
    );

    widget.page == 0
        ? widget.produtos = data['produtos']
        : widget.produtos.addAll(data['produtos']);
    widget.page = data['page'];
    widget.lastPage = data['lastPage'];
    widget.loading = false;

    if (this.mounted) setState(() {});
    return null;
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

  _selectCategoria(Categoria categoria) {
    if (widget.loading) {
      return;
    }
    setState(() {
      widget.categoriaId = categoria.id;
      widget.page = 0;
      widget.produtos = [];
    });

    loadProdutos();
  }

  List<Widget> makeProdutoItens() {
    List<Widget> produtos = [];
    for (var i = 0; i < widget.produtos.length + 1; i++) {
      if (widget.produtos.length > i) {
        produtos.add(new ListItemProduto(widget.produtos[i]));
      } else {
        produtos.add(getLoadingProdutos());
      }
    }
    return produtos;
  }

  List<CategoriaChip> makeCategoriaChips() {
    List<CategoriaChip> categoriasChips = [];
    for (Categoria categoria in widget.categorias) {
      categoriasChips.add(
        new CategoriaChip(
          categoria,
          _selectCategoria,
          widget.categoriaId,
        ),
      );
    }
    return categoriasChips;
  }

  @override
  Widget build(BuildContext context) {
    produtoService = new ProdutoService(context);

    return new Scaffold(
      body: new RefreshIndicator(
        onRefresh: () async {
          widget.page = 0;
          return await loadProdutos();
        },
        child: new Stack(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 125.0),
              child: ListView(
                controller: controller,
                children: makeProdutoItens(),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(
                  top: 34.0, right: 32.0, left: 32.0, bottom: 5.0),
              height: 100.0,
              width: double.infinity - 50,
              child: new TextField(
                onChanged: (data) {
                  if (debouncingSearch != null) {
                    debouncingSearch.cancel();
                  }
                  widget.search = data;
                  widget.page = 0;
                  debouncingSearch = new Timer(
                      const Duration(milliseconds: 300), loadProdutos);
                },
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: new Icon(Icons.search),
                  hintText: 'Procurar',
                  hintStyle: TextStyle(fontSize: 20.0)
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 105.0),
              child: new Container(
                height: 50.0,
                child: new Material(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: makeCategoriaChips(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
