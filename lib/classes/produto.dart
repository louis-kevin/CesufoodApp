import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class Produto {
  int id;
  String nome;
  double valor;
  String urlFoto;
  bool isFavoritado;
  bool isDestaque;
  MemoryImage memoryImageWidget;

  Produto(this.id, this.nome, this.valor, this.urlFoto, this.isDestaque,
      [this.isFavoritado = false]);

  static makeProdutoFromJson(data) {
    return new Produto(
      data['id'],
      data['nome'],
      data['valor'],
      data['urlFoto'],
      data['isDestaque'] == 1,
      data['isFavoritado'] == 1,
    );
  }

  get valorMask {
    return 'R\$ ' + this.valor.toString().replaceAll('.', ',');
  }

  get getImage {
    return http.readBytes(this.urlFoto);
  }

  get memoryImage {
    return new CachedNetworkImage(
      imageUrl: this.urlFoto,
      placeholder: new CircularProgressIndicator(),
      errorWidget: new Icon(Icons.error),
    );
  }

  get imageProvider {
    return new CachedNetworkImageProvider(this.urlFoto);
  }

  get image {
    return new Image(
      image: this.imageProvider,
    );
  }

  getTagWithPrefix(String prefix) {
    return prefix + this.id.toString();
  }
}
