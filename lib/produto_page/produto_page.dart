import 'package:cesufood_app/classes/produto.dart';
import 'package:flutter/material.dart';

class ProdutoPage extends StatefulWidget {
  final Produto produto;

  const ProdutoPage(
    this.produto, {
    Key key,
  }) : super(key: key);

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage>
    with TickerProviderStateMixin {
  AnimationController fotoAnimationController;

  void _rebuild() {
    setState(() => {});
  }

  @override
  void initState() {
    super.initState();

    fotoAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() => _rebuild());
  }

  @override
  void dispose() {
    fotoAnimationController.dispose();
    super.dispose();
  }

  Widget _getImage(url) {
    return new FutureBuilder(
      future: widget.produto.getImage,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          fotoAnimationController.forward();
          return new Opacity(
            opacity: fotoAnimationController.value,
            child: new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: new MemoryImage(snapshot.data),
                ),
              ),
            ),
          );
        } else {
          return new Center(
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
    return new Hero(
      tag: 'produto' + widget.produto.id.toString(),
      child: new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(widget.produto.isFavoritado
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () => setState(() {
                    widget.produto.isFavoritado = !widget.produto.isFavoritado;
                    //TODO mandar request favoritar
                  }),
            )
          ],
        ),
        body: new Container(
          transform: new Matrix4.translationValues(0.0, -80.0, 0.0),
          child: Column(
            children: [
              new Container(
                height: 264.0,
                width: double.infinity,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: widget.produto.imageProvider,
                  ),
                ),
              ),
              new Container(
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
                          new Matrix4.translationValues(-16.0, -41.0, 0.0),
                      child: new FloatingActionButton(
                        onPressed: () => {},
                        child: new Icon(Icons.add_shopping_cart),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
