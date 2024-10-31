import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/ball.dart';
import 'components/paddle.dart';
import 'components/score_text.dart';
import 'components/pause_menu.dart';
import 'screens/start_screen.dart';
import 'screens/settings_screen.dart';

enum GameScreen {
  start,
  game,
  settings,
}

class PingPongGame extends StatefulWidget {
  const PingPongGame({super.key});

  @override
  State<PingPongGame> createState() => _PingPongGameState();
}

class _PingPongGameState extends State<PingPongGame> {
  GameScreen currentScreen = GameScreen.start;
  double ballX = 0;
  double ballY = 0;
  double ballXSpeed = 0.02;
  double ballYSpeed = 0.02;
  double player1Y = 0;
  double player2Y = 0;
  int player1Score = 0;
  int player2Score = 0;
  bool gameStarted = false;
  bool isPaused = false;
  bool bgmEnabled = true;
  bool sfxEnabled = true;
  Timer? gameTimer;

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void startGame() {
    setState(() {
      currentScreen = GameScreen.game;
      gameStarted = true;
      isPaused = false;
      resetBall();
      player1Score = 0;
      player2Score = 0;
    });

    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!isPaused) {
        setState(() {
          ballX += ballXSpeed;
          ballY += ballYSpeed;

          if (ballY >= 1 || ballY <= -1) {
            ballYSpeed *= -1;
          }

          if (ballX <= -0.85 &&
              ballY >= player1Y - 0.3 &&
              ballY <= player1Y + 0.3) {
            ballXSpeed *= -1;
          }
          if (ballX >= 0.85 &&
              ballY >= player2Y - 0.3 &&
              ballY <= player2Y + 0.3) {
            ballXSpeed *= -1;
          }

          if (ballX <= -1) {
            player2Score++;
            resetBall();
          }
          if (ballX >= 1) {
            player1Score++;
            resetBall();
          }
        });
      }
    });
  }

  void resetBall() {
    ballX = 0;
    ballY = 0;
    ballXSpeed = 0.02;
    ballYSpeed = 0.02;
  }

  void movePlayer1(DragUpdateDetails details) {
    if (!isPaused) {
      setState(() {
        player1Y += (details.delta.dy / context.size!.height * 2);
        player1Y = player1Y.clamp(-0.7, 0.7);
      });
    }
  }

  void movePlayer2(DragUpdateDetails details) {
    if (!isPaused) {
      setState(() {
        player2Y += (details.delta.dy / context.size!.height * 2);
        player2Y = player2Y.clamp(-0.7, 0.7);
      });
    }
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void quitGame() {
    gameTimer?.cancel();
    setState(() {
      currentScreen = GameScreen.start;
      gameStarted = false;
      isPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape &&
            currentScreen == GameScreen.game) {
          togglePause();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          children: [
            if (currentScreen == GameScreen.start)
              StartScreen(
                onStartGame: startGame,
                onSettings: () =>
                    setState(() => currentScreen = GameScreen.settings),
              ),
            if (currentScreen == GameScreen.settings)
              SettingsScreen(
                bgmEnabled: bgmEnabled,
                sfxEnabled: sfxEnabled,
                onBgmToggle: (value) => setState(() => bgmEnabled = value),
                onSfxToggle: (value) => setState(() => sfxEnabled = value),
                onBack: () => setState(() => currentScreen = GameScreen.start),
              ),
            if (currentScreen == GameScreen.game) ...[
              Center(
                child: Stack(
                  children: [
                    Ball(ballX: ballX, ballY: ballY),
                    GestureDetector(
                      onVerticalDragUpdate: movePlayer1,
                      child: Paddle(x: -0.9, y: player1Y),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: movePlayer2,
                      child: Paddle(x: 0.9, y: player2Y),
                    ),
                    ScoreText(
                        player1Score: player1Score, player2Score: player2Score),
                  ],
                ),
              ),
              if (isPaused)
                PauseMenu(
                  onResume: togglePause,
                  onRestart: startGame,
                  onSettings: () =>
                      setState(() => currentScreen = GameScreen.settings),
                  onQuit: quitGame,
                ),
            ],
          ],
        ),
      ),
    );
  }
}
