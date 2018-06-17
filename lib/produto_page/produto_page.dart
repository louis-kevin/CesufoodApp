import 'package:cesufood_app/classes/produto.dart';
import 'package:cesufood_app/components/FavoritarButton.dart';
import 'package:flutter/material.dart';

class ProdutoPage extends StatefulWidget {
  final Produto produto;
  final String prevTag;

  const ProdutoPage(
    this.produto,
    this.prevTag, {
    Key key,
  }) : super(key: key);

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  @override
  Widget build(BuildContext context) {
    return new Hero(
      tag: widget.prevTag,
      child: new Scaffold(
        body: new CustomScrollView(
          slivers: [
            new SliverAppBar(
              pinned: true,
              expandedHeight: 264.0,
              leading: new BackButton(),
              title: new Text(
                widget.produto.nome,
              ),
              actions: [
                new FavoritarProdutoButton(widget.produto),
              ],
              flexibleSpace: new Stack(
                children: <Widget>[
                  new FlexibleSpaceBar(
                    background: new Image(
                      image: widget.produto.imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  new Container(
                    height: 80.0,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
                  ),
                ],
              ),
            ),
            new SliverToBoxAdapter(
              child: new Container(
                padding: new EdgeInsets.symmetric(vertical: 5.0),
                width: double.infinity,
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: new ListTile(
                  title: new Text(
                    widget.produto.nome,
                    style: new TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      new Text(
                        widget.produto.valorMask,
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.white.withOpacity(0.72),
                        ),
                      ),
                    ],
                  ),
                  trailing: new Container(
                    transform: new Matrix4.translationValues(-16.0, 41.0, 0.0),
                    child: new FloatingActionButton(
                      onPressed: () => {},
                      child: new Icon(Icons.add_shopping_cart),
                    ),
                  ),
                ),
              ),
            ),
            new SliverToBoxAdapter(
              child: new Container(
                height: 800.0,
                decoration: BoxDecoration(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}


