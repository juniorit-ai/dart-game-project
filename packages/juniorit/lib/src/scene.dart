import 'dart:ui';
import 'types.dart';
import 'sprite.dart';

class Scene {
  List<Sprite> children = [];

  void addChild(Sprite sprite) {
    children.add(sprite);
  }

  void removeChild(Sprite sprite) {
    children.remove(sprite);
  }

  void onUpdate(int ticks) {
    for (var sprite in children) {
      sprite.onUpdate(ticks);
    }
  }

  void onDraw(Canvas canvas) {
    for (var sprite in children) {
      sprite.onDraw(canvas);
    }
  }

  void onKeyboard(Event event, int keyCode) {
    for (var sprite in children) {
      sprite.onKeyboard(event, keyCode); 
    }
  }

  void onMouse(Event event, Point point) {
    for (var sprite in children) {
      sprite.onMouse(event, point); 
    }
  }
}
