import 'package:cesufood_app/classes/produto.dart';
import 'package:cesufood_app/components/FavoritarButton.dart';
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
            child: new ListTile(
              leading: new CircleAvatar(
                backgroundImage: widget.produto.imageProvider,
              ),
              title: new Text(
                widget.produto.nome,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              subtitle: new Text(
                widget.produto.valorMask,
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              trailing: new Row(
                children: <Widget>[
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
          ),
        ),
      ),
    );
  }
}
