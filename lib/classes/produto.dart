import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Produto {
  int id;
  String nome;
  double valor;
  String urlFoto;
  bool isFavoritado;
  var bytes;

  Produto(this.id, this.nome, this.valor, this.urlFoto, [this.isFavoritado = false]);

  get valorMask {
    return 'R\$ ' + this.valor.toString().replaceAll('.', ',');
  }

  get getImage {
    return http.readBytes(this.urlFoto);
  }

  get memoryImage async {
    if(bytes == null){
      bytes = await this.getImage();
    }
    return new MemoryImage(bytes);
  }

  get image async {
    if(bytes == null){
      bytes = await this.getImage();
    }
    return new Image.memory(bytes);
  }
}
