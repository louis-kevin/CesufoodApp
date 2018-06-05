import 'package:cesufood_app/components/progress_button/progress_button.dart';
import 'package:cesufood_app/components/progress_button/reveal_progress_button_painter.dart';
import 'package:flutter/material.dart';

class RevealProgressButton extends StatefulWidget {
  final Function callback;
  final Function onPressed;
  final String text;
  final Color firstColor;
  final Color secondColor;
  final BorderRadius borderRadius;

  RevealProgressButton(
      {@required this.callback,
      @required this.text,
      @required this.firstColor,
      this.secondColor,
      this.borderRadius,
      @required this.onPressed});

  @override
  State<StatefulWidget> createState() => _RevealProgressButtonState();
}

class _RevealProgressButtonState extends State<RevealProgressButton>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _fraction = 0.0;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: new RevealProgressButtonPainter(
          _fraction, MediaQuery.of(context).size),
      child: new ProgressButton(
          callback: widget.callback,
          text: widget.text,
          firstColor: widget.firstColor,
          secondColor: widget.secondColor,
          borderRadius: widget.borderRadius,
          onPressed: widget.onPressed,
      ),
    );
  }

  @override
  void deactivate() {
    reset();
    super.deactivate();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void reveal() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      })
      ..addStatusListener((AnimationStatus state) {
        if (state == AnimationStatus.completed) {}
      });
    _controller.forward();
  }

  void reset() {
    _fraction = 0.0;
  }
}
