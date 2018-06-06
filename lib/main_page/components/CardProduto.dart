import 'package:flutter/material.dart';

class CardProduto extends StatefulWidget {

  final int id;
  final String nome;
  final String urlFoto;
  final double preco;

  const CardProduto({Key key, this.id, this.nome, this.urlFoto, this.preco}) : super(key: key);

  @override
  _CardProdutoState createState() => _CardProdutoState();
}

class _CardProdutoState extends State<CardProduto> {
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: const Icon(Icons.album),
            title: const Text('The Enchanted Nightingale'),
            subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          new ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () { /* ... */ },
                ),
                new FlatButton(
                  child: const Text('LISTEN'),
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
