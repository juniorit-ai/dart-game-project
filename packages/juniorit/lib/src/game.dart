import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'scene.dart';
import 'types.dart';

class Game extends FlameGame
    with KeyboardEvents, TapDetector, MouseMovementDetector, ScrollDetector {
  static Game? _instance;

  late int screenWidth;
  late int screenheight;

  List<Scene> scenes = [];
  Scene? currentScene;

  late final CameraComponent cameraComponent;

  Game._privateConstructor();

  static Game get instance {
    _instance ??= Game._privateConstructor();
    return _instance!;
  }

  @override
  Color backgroundColor() => const Color(0xFF000000);

  void init(int width, int height, {String caption = 'JuniorIT.AI Game Craft' }) {
    screenWidth = width;
    screenheight = height;

    cameraComponent = CameraComponent.withFixedResolution(
      world: world,
      width: 1.0 * screenWidth,
      height: 1.0 * screenheight,
    );

    camera = cameraComponent;

  }

  void addScene(Scene scene) {
    scenes.add(scene);
  }

  void removeScene(Scene scene) {
    scenes.remove(scene);
  }

  void setCurrentScene(Scene scene) {
    if (currentScene != null) {
      scenes.remove(currentScene!);
    }
    currentScene = scene;
  }

  @override
  void update(double dt) {
    super.update(dt);
    currentScene?.onUpdate((dt * 1000).round());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    currentScene?.onDraw(canvas);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    Event customEvent = _mapToCustomEvent(event);
    int keyCode = event.logicalKey.keyId;
    onKeyboard(customEvent, keyCode);

    return KeyEventResult.handled;
  }

  Event _mapToCustomEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      return Event.keyDown;
    } else if (event is RawKeyUpEvent) {
      return Event.keyUp;
    } else {
      return Event.unknown;
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    onMouse(Event.mouseButtonDown,
        Point(info.eventPosition.global.x, info.eventPosition.global.y));
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    onMouse(Event.mouseButtonUp,
        Point(info.eventPosition.global.x, info.eventPosition.global.y));
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    super.onMouseMove(info);
    onMouse(Event.mouseMotion,
        Point(info.eventPosition.global.x, info.eventPosition.global.y));
  }

  @override
  void onScroll(PointerScrollInfo info) {
    super.onScroll(info);
    onMouse(Event.mouseWheel,
        Point(info.eventPosition.global.x, info.eventPosition.global.y));
  }

  void onKeyboard(Event event, int keyCode) {
    for (var scene in scenes) {
      scene.onKeyboard(event, keyCode);
    }
  }

  void onMouse(Event event, Point point) {
    for (var scene in scenes) {
      scene.onMouse(event, point);
    }
  }

  void run() {
    runApp(GameWidget(
      game: this,
    ));
  }
}
