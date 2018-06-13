import 'package:cesufood_app/classes/produto.dart';
import 'package:flutter/material.dart';

class ProdutoPage extends StatefulWidget {
  final Produto produto;
  final String prevTag;

  const ProdutoPage(
    this.produto, this.prevTag, {
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
              pinned: false,
              expandedHeight: 264.0,
              actions: [
                new IconButton(
                  icon: new Icon(widget.produto.isFavoritado
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () => setState(
                        () {
                          widget.produto.isFavoritado =
                              !widget.produto.isFavoritado;
                          //TODO mandar request favoritar
                        },
                      ),
                ),
              ],
              flexibleSpace: new FlexibleSpaceBar(
                background: new Image(
                  image: widget.produto.imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new SliverToBoxAdapter(
              child: new Container(
                height: 82.0,
                width: double.infinity,
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: new Text(
                              widget.produto.nome,
                              style: new TextStyle(fontSize: 30.0),
                            ),
                          ),
                          new Container(
                            transform:
                                new Matrix4.translationValues(-28.0, 0.0, 0.0),
                            child: new Text(
                              widget.produto.valorMask,
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.white.withOpacity(0.72),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Expanded(child: Container()),
                    new Container(
                      transform:
                          new Matrix4.translationValues(-16.0, 41.0, 0.0),
                      child: new FloatingActionButton(
                        onPressed: () => {},
                        child: new Icon(Icons.add_shopping_cart),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new SliverToBoxAdapter(
              child: new Container(
                height: 545.0,
                decoration: BoxDecoration(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
