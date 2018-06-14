import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cesufood_app/classes/produto.dart';

class Service {
  List<String> imagens = [
    'http://www.dicasonline.tv/wp-content/uploads/coxinhas-758x396.jpg',
    'https://guiadacozinha.com.br/wp-content/uploads/2017/12/pastel-carne.jpg',
    'http://sucodetox.eco.br/wp-content/uploads/2016/11/suco-desintoxicante-com-gengibre-para-perder-barriga.jpg',
    'https://www.receiteria.com.br/wp-content/uploads/receitas-de-risoles-1.jpg?x17678',
    'https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0RG000000mUK9zMAG/56aa29bde4b09f2a778cd5b6.jpg&w=620&h=400'
  ];

  Database db;

  List<Produto> produtos = [];

  getProdutosDestaques() async {
    List<Produto> produtos = [];

    if (this.produtos.length <= 0) {
      await this.loadProdutos();
    }

    for (Produto produto in this.produtos) {
      if (produto.isDestaque) {
        produtos.add(produto);
      }
    }

    return produtos;
  }

  Future _loadDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "app2.db");

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE produtos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, urlFoto TEXT, valor REAL, isFavoritado INTEGER, isDestaque INTEGER)");
    });



    this.db = database;
  }

  insertProdutos() async {
    await _loadDb();

    var rng = new Random();
    await this.db.transaction((txn) async {
      print('Begin transaction');
      for (int i = 0; i < 50; i++) {
        await txn.rawInsert(
            'INSERT INTO produtos(nome, urlFoto, valor, isFavoritado, isDestaque) VALUES( ?, ?, ?, ?, ?)',
            [
              'Teste $i',
              imagens[rng.nextInt(4)],
              i * rng.nextInt(4).toDouble(),
              rng.nextInt(2) == 1 ? 1 : 0,
              rng.nextInt(2) == 1 ? 1 : 0
            ]);
      }
      print('End transaction');
    });

    this.db.close();
  }

  Future loadProdutos() async {
    await _loadDb();

    List<Map> produtosDb = await this.db.rawQuery('SELECT * FROM produtos');
    print(produtosDb);
    produtosDb.forEach((produtoDb){
      this.produtos.add(Produto.makeProdutoFromJson(produtoDb));
    });
    this.db.close();
  }

  getProdutos() async {
    if (produtos.length <= 0) {
      await this.loadProdutos();
    }
    return this.produtos;
  }

  Widget buildProdutos(future, callback) {
    return new FutureBuilder(
      future: future,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return callback(snapshot.data);
        } else {
          return Container(
            height: double.infinity,
          );
        }
      },
    );
  }
}
