import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class Produto {
  int id;
  String nome;
  double valor;
  String urlFoto;
  bool isFavoritado;
  MemoryImage memoryImageWidget;

  Produto(this.id, this.nome, this.valor, this.urlFoto,
      [this.isFavoritado = false]);

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

  getTagWithPrefix(String prefix){
    return prefix + this.id.toString();
  }
}
