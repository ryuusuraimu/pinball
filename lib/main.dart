import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart'; // ユーザー入力対応
import 'package:flame/palette.dart'; // 色のパレット
import 'package:flame_forge2d/flame_forge2d.dart'; // Forge2D（物理エンジン）
import 'package:flutter/material.dart';

class RetroPinballGame extends FlameGame with HasDraggables, HasTappables {
  late SpriteComponent background; // 背景
  late SpriteComponent flipperLeft; // 左フリッパー
  late SpriteComponent flipperRight; // 右フリッパー
  late SpriteComponent ball; // ボール

  @override
  Future<void> onLoad() async {
    // 背景を設定
    background = SpriteComponent()
      ..sprite = await loadSprite('background.png')
      ..size = Vector2(160, 144) // ゲームボーイ風解像度
      ..position = Vector2.zero();
    add(background);

    // 左フリッパー
    flipperLeft = SpriteComponent()
      ..sprite = await loadSprite('flipper_left.png')
      ..size = Vector2(20, 5) // フリッパーの大きさ
      ..position = Vector2(30, 120); // フリッパーの初期位置
    add(flipperLeft);

    // 右フリッパー
    flipperRight = SpriteComponent()
      ..sprite = await loadSprite('flipper_right.png')
      ..size = Vector2(20, 5)
      ..position = Vector2(110, 120);
    add(flipperRight);

    // ボールの追加
    ball = SpriteComponent()
      ..sprite = await loadSprite('ball.png')
      ..size = Vector2(5, 5) // ボールの大きさ
      ..position = Vector2(80, 80); // ボールの初期位置
    add(ball);
  }

  @override
  void onTapDown(TapDownInfo info) {
    // タップした場所に応じてフリッパーを動かす処理
    if (info.eventPosition.game.x < size.x / 2) {
      // 左半分のタップで左フリッパー
      flipperLeft.angle += 0.1; // フリッパーを少しだけ上に動かす
    } else {
      // 右半分のタップで右フリッパー
      flipperRight.angle -= 0.1;
    }
  }
}

void main() {
  runApp(GameWidget(game: RetroPinballGame()));
}
