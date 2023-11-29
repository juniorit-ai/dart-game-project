import 'package:flame/components.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/sprite.dart' as fls;
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'types.dart';

class Sprite {
  late fls.Sprite flSprite;
  late Image image;

  late int width;
  late int height;

  bool isReady = false;

  List<Rect> frames;
  FlipMode flipMode = FlipMode.flipNone;

  Point position = Point(0, 0);
  double scale = 1.0;
  double angle = 0.0;
  Point anchor = Point(0, 0);

  Sprite(String imagePath, {this.frames = const []}) {
    Flame.images.load(imagePath).then((img) {
      image = img;
      if (frames.isEmpty) {
        flSprite = fls.Sprite(image);
        width = image.width;
        height = image.height;
      } else {
        fls.Sprite(image,
            srcPosition: Vector2(frames[0].x, frames[0].y),
            srcSize: Vector2(frames[0].w, frames[0].h));
        width = frames[0].w.round();
        height = frames[9].h.round();
      }
      isReady = true;
    });
  }

  void setPosition(double left, double top) {
    position = Point(left, top);
  }

  void setScale(double scale) {
    this.scale = scale;
  }

  void setAngle(double angle) {
    this.angle = angle;
  }

  void setCenter(Point center) {
    anchor = center;
  }

  void setFlip(FlipMode mode) {
    flipMode = mode;
  }

  void setFrame(int frameIndex) {
    if (frameIndex >= 0 && frameIndex < frames.length) {
      Rect frame = frames[frameIndex];
      fls.Sprite(image,
          srcPosition: Vector2(frame.x, frame.y),
          srcSize: Vector2(frame.w, frame.h));
      width = frame.w.round();
      height = frame.h.round();
    }
  }

  void onUpdate(int ticks) {
 
  }

  void onDraw(Canvas canvas) {
    if (!isReady) return;

    // Save the current canvas state
    canvas.save();

    // Translate to the sprite's position
    canvas.translate(
        position.x + width * anchor.x, position.y + height * anchor.y);

    // Apply flipping
    double scaleX = 1, scaleY = 1;
    if (flipMode == FlipMode.flipHorizontal ||
        flipMode == FlipMode.flipDiagonal) {
      scaleX = -1;
    }
    if (flipMode == FlipMode.flipVertical ||
        flipMode == FlipMode.flipDiagonal) {
      scaleY = -1;
    }
    canvas.scale(scaleX, scaleY);

    // Apply rotation
    if (angle != 0) {
      canvas.rotate(angle * (math.pi / 180)); // Convert angle to radians
    }

    // Draw the sprite
    flSprite.render(
      canvas,
      position: Vector2(-width * anchor.x,
          -height * anchor.y), // Adjust for anchor after transformations
      size: Vector2(width.toDouble(), height.toDouble()) * scale,
      anchor:
          Anchor.topLeft, // Use topLeft since we've manually handled the anchor
    );

    // Restore the canvas to its original state
    canvas.restore();
  }

  void onKeyboard(Event event, int keyCode) {}

  void onMouse(Event event, Point point) {}
}
