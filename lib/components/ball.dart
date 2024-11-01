import 'package:flame_forge2d/flame_forge2d.dart';
import 'dart:ui';

class Ball extends BodyComponent {
  final int stage;
  final Vector2 position;
  
  Ball({
    required this.stage,
    required this.position,
  });
  
  @override
  Body createBody() {
    final shape = CircleShape()..radius = 0.5;
    
    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      density: 1.0,
      friction: 0.4,
    );
    
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: position,
    );
    
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  
  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.fill;
    
    switch (stage) {
      case 0: // White
        paint.shader = RadialGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.5)],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: 0.5));
        break;
      case 1: // Red
        paint.shader = RadialGradient(
          colors: [Colors.red.shade700, Colors.red.shade300],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: 0.5));
        break;
      // ... Similar cases for blue, green, and yellow
    }
    
    canvas.drawCircle(Offset.zero, 0.5, paint);
  }
}