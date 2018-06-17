import 'package:cesufood_app/classes/produto.dart';
import 'package:flutter/material.dart';

class FavoritarProdutoButton extends StatefulWidget {
  final Color color;

  const FavoritarProdutoButton(
    this.produto, {
    Key key,
    this.color = Colors.white,
  }) : super(key: key);

  final Produto produto;

  @override
  _FavoritarProdutoButtonState createState() =>
      new _FavoritarProdutoButtonState();
}

class _FavoritarProdutoButtonState extends State<FavoritarProdutoButton> {
  _toogleFavorito(context, [showSnackBar = true]) {
    setState(() {
      widget.produto.isFavoritado = !widget.produto.isFavoritado;
    });
    widget.produto.toogleFavorito().then((data) {
      var message = widget.produto.nome + (data ? ' favoritado' : ' desfavortiado');
      if (showSnackBar) {
        Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Produto $message'),
                action: SnackBarAction(
                  label: 'Desfazer',
                  onPressed: () => _toogleFavorito(context, false),
                ),
              ),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      icon: new Icon(
        widget.produto.isFavoritado ? Icons.favorite : Icons.favorite_border,
        color: widget.color,
      ),
      onPressed: () => _toogleFavorito(context),
    );
  }
}
