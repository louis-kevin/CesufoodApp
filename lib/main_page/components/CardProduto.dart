import 'package:cesufood_app/classes/produto.dart';
import 'package:cesufood_app/components/FavoritarButton.dart';
import 'package:cesufood_app/produto_page/produto_page.dart';
import 'package:flutter/material.dart';

class CardProduto extends StatefulWidget {
  final Produto produto;
  static String heroTag = 'produto-card-';

  const CardProduto(this.produto, {Key key}) : super(key: key);

  @override
  CardProdutoState createState() {
    return new CardProdutoState();
  }
}

class CardProdutoState extends State<CardProduto> {
  void viewProduto(context) {
    Navigator.of(context).push(
      new MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new ProdutoPage(widget.produto,
            widget.produto.getTagWithPrefix(CardProduto.heroTag));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 2.0,
      child: new Material(
        child: new InkWell(
          onTap: () => viewProduto(context),
          onLongPress: () => {},
          child: new Column(
            children: <Widget>[
              new Hero(
                tag: widget.produto.getTagWithPrefix(CardProduto.heroTag),
                child: new Container(
                  height: 150.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: widget.produto.imageProvider,
                    ),
                  ),
                ),
              ),
              new ListTile(
                title: new Text(widget.produto.nome),
                subtitle: new Row(
                  children: <Widget>[
                    new Text(widget.produto.valorMask),
                    new Expanded(child: Container()),
                    new FavoritarProdutoButton(
                      widget.produto,
                      color: Color(0xFFFF4444),
                    ),
                    new IconButton(
                      icon: new Icon(
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
        ),
      ),
    );
  }
}
