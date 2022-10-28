import 'dart:collection';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Circle Drawer',
      home: MyHomePage(title: 'Circle Drawer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _circles = <Circle>[];
  final _defaultRadius = 8.0;
  final _actionsTaken = Queue<CircleAction>();
  final _actionsUndone = Queue<CircleAction>();

  void _onTapCanvas(tap) {
    Circle? clicked;
    double shortestDist = double.infinity;

    for (Circle circle in _circles) {
      double dist = (circle.position - tap.localPosition).distance;

      if (dist <= circle.radius && dist < shortestDist) {
        shortestDist = dist;
        clicked = circle;
      }
    }

    if (clicked == null) {
      setState(() {
        var circle = Circle(tap.localPosition, _defaultRadius);
        _circles.add(circle);
        _actionsTaken.add(CircleCreation(circle));
        _actionsUndone.clear();
      });
    } else {
      _adjustCircle(clicked);
    }
  }

  void _adjustCircle(Circle circle) {
    final double prevRadius = circle.radius;
    final String x = circle.position.dx.toStringAsFixed(0);
    final String y = circle.position.dy.toStringAsFixed(0);

    setState(() {
      circle.selected = true;
    });

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, dialogSetState) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Adjust diameter of circle at ($x, $y).'),
                Slider(
                  min: _defaultRadius / 2,
                  max: _defaultRadius * 10,
                  value: circle.radius,
                  onChanged: (value) => setState(() {
                    dialogSetState(() {
                      circle.radius = value;
                    });
                  }),
                ),
              ],
            ),
          );
        });
      },
    ).then(
      (_) {
        setState(() {
          circle.selected = false;
          if (prevRadius != circle.radius) {
            _actionsTaken.add(CircleAdjustment(circle, prevRadius));
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Wrap(
              spacing: 10.0,
              children: [
                ElevatedButton(
                  onPressed: _actionsTaken.isEmpty
                      ? null
                      : () => setState(() {
                            var action = _actionsTaken.removeLast();
                            switch (action.runtimeType) {
                              case CircleCreation:
                                _circles.remove(action.circle);
                                _actionsUndone.add(action);
                                break;
                              case CircleAdjustment:
                                var prevRadius =
                                    (action as CircleAdjustment).prevRadius;
                                action.prevRadius = action.circle.radius;
                                action.circle.radius = prevRadius;
                                _actionsUndone.add(action);
                                break;
                            }
                          }),
                  child: const Text('Undo'),
                ),
                ElevatedButton(
                  onPressed: _actionsUndone.isEmpty
                      ? null
                      : () => setState(() {
                            var action = _actionsUndone.removeLast();
                            switch (action.runtimeType) {
                              case CircleCreation:
                                _circles.add(action.circle);
                                _actionsTaken.add(action);
                                break;
                              case CircleAdjustment:
                                var prevRadius =
                                    (action as CircleAdjustment).prevRadius;
                                action.prevRadius = action.circle.radius;
                                action.circle.radius = prevRadius;
                                _actionsTaken.add(action);
                                break;
                            }
                          }),
                  child: const Text('Redo'),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: GestureDetector(
                  onTapUp: _onTapCanvas,
                  child: ClipRect(
                    child: CustomPaint(
                      painter: CirclePainter(_circles),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class CirclePainter extends CustomPainter {
  final _stroke = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  final _fill = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.fill
    ..strokeWidth = 0;
  final List<Circle> _circles;

  CirclePainter(this._circles);

  @override
  void paint(Canvas canvas, Size size) {
    Circle? selectedCircle;

    for (Circle circle in _circles) {
      canvas.drawCircle(circle.position, circle.radius, _stroke);

      if (circle.selected) {
        selectedCircle = circle;
      }
    }

    if (selectedCircle != null) {
      canvas.drawCircle(selectedCircle.position, selectedCircle.radius, _fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
