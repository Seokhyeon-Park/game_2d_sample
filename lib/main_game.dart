import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'components/player/player.dart';

class MainGame extends FlameGame with HasKeyboardHandlerComponents {
  final Player _player = Player();

  @override
  Future<void> onLoad() async {
    add(_player);
  }
}
