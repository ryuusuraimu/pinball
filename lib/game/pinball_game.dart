import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:fantasy_pinball/components/ball.dart';
import 'package:fantasy_pinball/components/flipper.dart';
import 'package:fantasy_pinball/components/walls.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class PinballGame extends Forge2DGame {
  PinballGame() : super(gravity: Vector2(0, 9.8));
  
  late Ball ball;
  late Flipper leftFlipper;
  late Flipper rightFlipper;
  final audioPlayer = AudioPlayer();
  int score = 0;
  int currentStage = 0;
  
  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(Vector2(360, 640));
    
    // Add walls
    add(Walls());
    
    // Add flippers
    leftFlipper = Flipper(
      position: Vector2(-15, 30),
      isLeft: true,
    );
    rightFlipper = Flipper(
      position: Vector2(15, 30),
      isLeft: false,
    );
    add(leftFlipper);
    add(rightFlipper);
    
    // Add initial ball
    resetBall();
    
    overlays.add('score');
  }
  
  void resetBall() {
    ball = Ball(
      stage: currentStage,
      position: Vector2(0, -20),
    );
    add(ball);
  }
  
  void handleCollision(double intensity) {
    // Play piano sound
    audioPlayer.play(AssetSource('audio/piano_${(intensity * 5).round()}.mp3'));
    
    // Trigger vibration
    if (intensity > 0.5) {
      Vibration.vibrate(duration: (intensity * 100).round());
    }
    
    // Update score
    score += (intensity * 100).round();
  }
  
  void nextStage() {
    currentStage = (currentStage + 1) % 5;
    resetBall();
  }
}