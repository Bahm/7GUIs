import 'dart:collection';

import 'package:event/event.dart';
import 'package:flutter/material.dart';

import '/common/circle.dart';

class CircleDrawerManager {
  final _defaultRadius = 8.0;
  final _circles = <Circle>[];
  final _actionsTaken = Queue<CircleAction>();
  final _actionsUndone = Queue<CircleAction>();

  List<Circle> get circles => _circles;
  Queue<CircleAction> get actionsTaken => _actionsTaken;
  Queue<CircleAction> get actionsUndone => _actionsUndone;

  final actionTakenEvent = Event();
  final circleSelectionChangedEvent = Event();
  final circleRadiusChangedEvent = Event();

  void redoAction() {
    var action = _actionsUndone.removeLast();
    switch (action.runtimeType) {
      case CircleCreation:
        _circles.add(action.circle);
        _actionsTaken.add(action);
        break;
      case CircleAdjustment:
        var prevRadius = (action as CircleAdjustment).prevRadius;
        action.prevRadius = action.circle.radius;
        action.circle.radius = prevRadius;
        _actionsTaken.add(action);
        break;
    }
    actionTakenEvent.broadcast();
  }

  void undoAction() {
    var action = _actionsTaken.removeLast();
    switch (action.runtimeType) {
      case CircleCreation:
        _circles.remove(action.circle);
        _actionsUndone.add(action);
        break;
      case CircleAdjustment:
        var prevRadius = (action as CircleAdjustment).prevRadius;
        action.prevRadius = action.circle.radius;
        action.circle.radius = prevRadius;
        _actionsUndone.add(action);
        break;
    }
    actionTakenEvent.broadcast();
  }

  void onTapCanvas(BuildContext context, Offset tapPosition) {
    Circle? clicked = _getCircleAt(tapPosition);

    if (clicked == null) {
      _createCircleAt(tapPosition);
    } else {
      _adjustCircle(context, clicked);
    }
  }

  void _createCircleAt(Offset position) {
    var circle = Circle(position, _defaultRadius);
    _circles.add(circle);
    _actionsTaken.add(CircleCreation(circle));
    _actionsUndone.clear();
    actionTakenEvent.broadcast();
  }

  Circle? _getCircleAt(Offset position) {
    Circle? result;
    double shortestDist = double.infinity;

    for (Circle circle in _circles) {
      double dist = (circle.position - position).distance;

      if (dist <= circle.radius && dist < shortestDist) {
        shortestDist = dist;
        result = circle;
      }
    }

    return result;
  }

  void _adjustCircle(BuildContext context, Circle circle) {
    final double prevRadius = circle.radius;
    final String x = circle.position.dx.toStringAsFixed(0);
    final String y = circle.position.dy.toStringAsFixed(0);

    circle.selected = true;
    circleSelectionChangedEvent.broadcast();

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
                  onChanged: (value) => dialogSetState(() {
                    circle.radius = value;
                    circleRadiusChangedEvent.broadcast();
                  }),
                ),
              ],
            ),
          );
        });
      },
    ).then(
      (_) {
        circle.selected = false;
        circleSelectionChangedEvent.broadcast();
        if (prevRadius != circle.radius) {
          _actionsTaken.add(CircleAdjustment(circle, prevRadius));
          actionTakenEvent.broadcast();
        }
      },
    );
  }
}
