import 'package:cesufood_app/classes/produto.dart';
import 'package:flutter/material.dart';

class CardProduto extends StatelessWidget {

  final Produto produto;

  const CardProduto({Key key, this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.all(8.0),
      elevation: 2.0,
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Image.network(produto.urlFoto),
          ),
          new ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Icon(Icons.favorite_border, color: Color(0xFFFF4444),) ,
                  onPressed: () { /* ... */ },
                ),
                new FlatButton(
                  child: new Icon(Icons.add_shopping_cart, color: Theme.of(context).accentColor,) ,
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

