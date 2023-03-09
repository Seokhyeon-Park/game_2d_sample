import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_2d_sample/main_game.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            MainGamePage(),
          ],
        ),
      ),
    )
  );
}

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  State<MainGamePage> createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> {
  late final MainGame _mainGame;

  @override
  void initState() {
    super.initState();
    _mainGame = MainGame();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: _mainGame);
  }
}