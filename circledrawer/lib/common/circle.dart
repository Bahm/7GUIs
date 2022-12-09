import 'dart:ui';

class Circle {
  final Offset position;
  double radius;
  bool selected = false;

  Circle(this.position, this.radius);
}

abstract class CircleAction {
  final Circle circle;

  CircleAction(this.circle);
}

class CircleCreation extends CircleAction {
  CircleCreation(super.circle);
}

class CircleAdjustment extends CircleAction {
  double prevRadius;

  CircleAdjustment(super.circle, this.prevRadius);
}
