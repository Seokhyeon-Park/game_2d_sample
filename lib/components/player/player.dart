import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

class Player extends SpriteAnimationComponent with KeyboardHandler, HasGameRef {
  Player() : super(size: Vector2.all(50));

  // for Character
  final double _animationSpeed = 0.15;

  // Speed
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 300;

  // 방향
  int horizontalDirection = 0;
  int verticalDirection = 0;

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations();

    animation = _standingAnimation;
  }

  @override
  void update(double dt) {
    velocity.x = horizontalDirection * moveSpeed;
    velocity.y = verticalDirection * moveSpeed;

    // 플레이어 이동 (dt는 마지막 프레임으로 부터 경가된 시간[초])
    position += velocity * dt;

    super.update(dt);
  }

  // 에니메이션 로드
  Future<void> _loadAnimations() async {
    final game = FlameGame();
    final spriteSheet = SpriteSheet(
      image: await game.images.load('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0),
    );

    _runDownAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runLeftAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runUpAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runRightAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: _animationSpeed,
      to: 4,
    );

    _standingAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 1,
    );
  }

  // 키보드 이벤트 처리
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    verticalDirection = 0;
    bool keyPressed = false;

    // 상 화살표가 눌린 경우 verticalDirection +1
    if(keysPressed.contains(LogicalKeyboardKey.arrowUp)){
      verticalDirection -= 1;
      animation = _runUpAnimation;
      keyPressed = true;
    }

    // 하 화살표가 눌린 경우 verticalDirection -1
    if(keysPressed.contains(LogicalKeyboardKey.arrowDown)){
      verticalDirection += 1;
      animation = _runDownAnimation;
      keyPressed = true;
    }

    // 좌 화살표가 눌린 경우 horizontalDirection -1
    if(keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
      horizontalDirection -= 1;
      animation = _runLeftAnimation;
      keyPressed = true;
    }

    // 우 화살표가 눌린 경우 horizontalDirection +1
    if(keysPressed.contains(LogicalKeyboardKey.arrowRight)){
      horizontalDirection += 1;
      animation = _runRightAnimation;
      keyPressed = true;
    }

    // 키가 눌리지 않았을 때
    if (!keyPressed) {
      animation = _standingAnimation;
    }

    return true;
  }
}