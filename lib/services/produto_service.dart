import 'dart:async';
import 'package:cesufood_app/classes/produto.dart';
import 'package:cesufood_app/services/service.dart';
import 'package:flutter/material.dart';

class ProdutoService extends Service {
  ProdutoService([BuildContext context]) : super(context);

  Future listProdutos([page = 1])async {
    ParsedResponse response = await this.get('produto', {'page': page, 'search': 'Dr'});
    var produtos = [];
    for(var produtoDb in response.getData()){
      produtos.add(Produto.fromMap(produtoDb));
    }

    return {'produtos': produtos, 'page': response.getPage(), 'lastPage': response.getLastPage()};
  }

}