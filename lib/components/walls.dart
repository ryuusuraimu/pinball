import 'package:flame_forge2d/flame_forge2d.dart';

class Walls extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.static,
    );
    
    final body = world.createBody(bodyDef);
    
    // Left wall
    final leftWall = EdgeShape()
      ..set(Vector2(-20, -40), Vector2(-20, 40));
    body.createFixture(FixtureDef(leftWall));
    
    // Right wall
    final rightWall = EdgeShape()
      ..set(Vector2(20, -40), Vector2(20, 40));
    body.createFixture(FixtureDef(rightWall));
    
    // Top wall
    final topWall = EdgeShape()
      ..set(Vector2(-20, -40), Vector2(20, -40));
    body.createFixture(FixtureDef(topWall));
    
    return body;
  }
}