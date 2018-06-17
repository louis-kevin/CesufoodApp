import 'dart:async';
import 'package:cesufood_app/classes/categoria.dart';
import 'package:cesufood_app/classes/produto.dart';
import 'package:cesufood_app/services/service.dart';
import 'package:flutter/material.dart';

class ProdutoService extends Service {
  ProdutoService([BuildContext context]) : super(context);

  Future listProdutos(page,
      {categoria = 2, destaque = false, search = '', sort = 'nome'}) async {
    ParsedResponse response = await this.get('produto', {
      'page': page,
      'search': search,
      'sort': sort,
      'destaque': destaque,
      'categoria': categoria
    });
    var produtos = [];
    for (var produtoDb in response.getData()) {
      produtos.add(Produto.fromMap(produtoDb));
    }

    return {
      'produtos': produtos,
      'page': response.getPage(),
      'lastPage': response.getLastPage()
    };
  }

  Future<List<Categoria>> listCategorias() async {
    ParsedResponse response = await this.get('categoria', {'limit': 0, 'sort': 'id'});

    List<Categoria> categorias = [];

    for (var categoriasDb in response.getData()) {
      categorias.add(Categoria.fromMap(categoriasDb));
    }

    return categorias;
  }
}
