import 'package:cesufood_app/services/produto_service.dart';
import 'package:cesufood_app/services/service.dart';
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

  static fromMap(data) {
    return new Produto(
      data['id'],
      data['nome'],
      data['valor'].toDouble(),
      data['fotos'][0],
      data['is_destaque'],
      data['is_favoritado'],
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

  toogleFavorito()async {
    ProdutoService service = new ProdutoService();

    ParsedResponse response = await service.post('produto/$id');
    this.isFavoritado = response.getData()['is_favoritado'];

    return response.getData()['is_favoritado'];

  }
}
