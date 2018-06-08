import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Produto {
  int id;
  String nome;
  double valor;
  String urlFoto;
  bool isFavoritado;

  Produto(this.id, this.nome, this.valor, this.urlFoto, [this.isFavoritado = false]);

  get valorMask {
    return 'R\$ ' + this.valor.toString().replaceAll('.', ',');
  }

  get getImage {
    return http.readBytes(this.urlFoto);
  }

  get memoryImage async {
    return new MemoryImage(await this.getImage);
  }

  get image async {
    return new Image.memory(await this.getImage);
  }
}
