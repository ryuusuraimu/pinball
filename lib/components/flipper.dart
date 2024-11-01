import 'package:flame_forge2d/flame_forge2d.dart';

class Flipper extends BodyComponent {
  final bool isLeft;
  final Vector2 position;
  
  Flipper({
    required this.isLeft,
    required this.position,
  });
  
  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(2.0, 0.3);
    
    final fixtureDef = FixtureDef(
      shape,
      density: 1.0,
      friction: 0.3,
    );
    
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: position,
      angle: isLeft ? -0.6 : 0.6,
    );
    
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  
  void flip() {
    body.applyAngularImpulse(
      isLeft ? -20.0 : 20.0,
    );
  }
}