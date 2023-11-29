enum Event {
  keyDown,
  keyUp,
  mouseWheel,
  mouseButtonDown,
  mouseButtonUp,
  mouseMotion,
  unknown
}

class Point {
  double x;
  double y;

  Point(this.x, this.y);
}

enum FlipMode {
  flipNone,
  flipHorizontal,
  flipVertical,
  flipDiagonal
}

class Rect {
  double x;
  double y;
  double w;
  double h;

  Rect(this.x, this.y, this.w, this.h);
}
