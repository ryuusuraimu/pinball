import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game/ping_pong_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Ping Pong',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PingPongGame(),
    );
  }
}
