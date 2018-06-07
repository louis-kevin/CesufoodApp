import 'package:cesufood_app/classes/produto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CardProduto extends StatelessWidget {
  final Produto produto;

  const CardProduto({Key key, this.produto}) : super(key: key);
  
  Widget _getImage(url){
    return new FutureBuilder(
        future: http.readBytes(url),
        builder: (BuildContext context, snapshot) {
          if(snapshot.hasData){
            return new Image.memory(
              snapshot.data,
              fit: BoxFit.fill,
            );
          }else{
            return  new Center(
              child: new CircularProgressIndicator(
                backgroundColor: Theme.of(context).accentColor,
              ),
            );
          }
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.all(8.0),
      elevation: 2.0,
      child: new Column(
        children: <Widget>[
          new Container(
            height: 107.0,
            child: _getImage(produto.urlFoto)
          ),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Icon(
                    Icons.favorite_border,
                    color: Color(0xFFFF4444),
                  ),
                  onPressed: () {
                    /* ... */
                  },
                ),
                new FlatButton(
                  child: new Icon(
                    Icons.add_shopping_cart,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    /* ... */
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
