import 'package:cesufood_app/classes/produto.dart';

class Service {

  List<String> imagens = [
    'http://www.dicasonline.tv/wp-content/uploads/coxinhas-758x396.jpg',
    'https://guiadacozinha.com.br/wp-content/uploads/2017/12/pastel-carne.jpg',
    'http://sucodetox.eco.br/wp-content/uploads/2016/11/suco-desintoxicante-com-gengibre-para-perder-barriga.jpg',
    'https://www.receiteria.com.br/wp-content/uploads/receitas-de-risoles-1.jpg?x17678',
    'https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0RG000000mUK9zMAG/56aa29bde4b09f2a778cd5b6.jpg&w=620&h=400'

  ];

  List<Produto> getProdutosDestaques(){
    List<Produto> produtos = [];

    for(int i = 0; i < 5; i++){
      produtos.add(new Produto(
        i,
        'Teste $i',
        i * 1.5,
        imagens[i]
      ));
    }

    return produtos;
  }
}