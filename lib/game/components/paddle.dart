import 'package:flutter/material.dart';

class Paddle extends StatelessWidget {
  final double x;
  final double y;

  const Paddle({
    super.key,
    required this.x,
    required this.y,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: Container(
        width: 10,
        height: 80,
        color: Colors.white,
      ),
    );
  }
}
