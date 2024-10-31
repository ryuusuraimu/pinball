import 'package:flutter/material.dart';

class ScoreText extends StatelessWidget {
  final int player1Score;
  final int player2Score;

  const ScoreText({
    super.key,
    required this.player1Score,
    required this.player2Score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.8),
      child: Text(
        '$player1Score - $player2Score',
        style: const TextStyle(color: Colors.white, fontSize: 32),
      ),
    );
  }
}
