import 'package:cesufood_app/classes/categoria.dart';
import 'package:flutter/material.dart';

class CategoriaChip extends StatefulWidget {
  final Categoria categoria;
  final Function onPress;
  final int selectedId;

  CategoriaChip(this.categoria, this.onPress, [this.selectedId = 0]);

  @override
  _CategoriaChipState createState() => new _CategoriaChipState();
}

class _CategoriaChipState extends State<CategoriaChip> {
  _isSelected() => widget.categoria.id == widget.selectedId;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Container(
        decoration: BoxDecoration(
          color: _isSelected() ? Theme.of(context).accentColor : Colors.white,
          borderRadius: BorderRadius.circular(5.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              spreadRadius: 0.1,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: new InkWell(
          onTap: () => widget.onPress(widget.categoria),
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              widget.categoria.nome,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
