import 'package:cesufood_app/classes/produto.dart';
import 'package:cesufood_app/produto_page/produto_page.dart';
import 'package:flutter/material.dart';

class ListItemProduto extends StatefulWidget {
  final Produto produto;
  static String heroTag = 'produto-list-item-';

  const ListItemProduto(this.produto, {Key key}) : super(key: key);

  @override
  ListItemProdutoState createState() {
    return new ListItemProdutoState();
  }
}

class ListItemProdutoState extends State<ListItemProduto> {
  void viewProduto(context) {
    Navigator.of(context).push(
      new MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new ProdutoPage(widget.produto,
            widget.produto.getTagWithPrefix(ListItemProduto.heroTag));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Hero(
      tag: widget.produto.getTagWithPrefix(ListItemProduto.heroTag),
      child: new Material(
        child: new InkWell(
          onTap: () => viewProduto(context),
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              children: <Widget>[
                new CircleAvatar(
                  backgroundImage: widget.produto.imageProvider,
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        widget.produto.nome,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                            transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                            child: new Text(
                              widget.produto.valorMask,
                              style:
                                  TextStyle(color: Colors.black.withOpacity(0.5)),
                            )),
                      ),
                    ],
                  ),
                ),
                new Expanded(child: Container()),
                new IconButton(
                  icon: new Icon(
                    widget.produto.isFavoritado
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Color(0xFFFF4444),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.produto.isFavoritado =
                          !widget.produto.isFavoritado;
                      //TODO mandar request favoritar
                    });
                  },
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
        ),
      ),
    );
  }
}
