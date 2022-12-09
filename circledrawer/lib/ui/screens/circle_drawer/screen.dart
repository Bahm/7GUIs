import 'package:circledrawer/common/aggregate_event.dart';
import 'package:eventsubscriber/eventsubscriber.dart';
import 'package:flutter/material.dart';

import '/common/circle.dart';
import './manager.dart';

class CircleDrawerScreen extends StatelessWidget {
  final CircleDrawerManager manager;

  const CircleDrawerScreen({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circle Drawer'),
      ),
      body: EventSubscriber(
        event: manager.actionTakenEvent,
        builder: (context, args) {
          return Column(
            children: [
              _ActionButtons(manager: manager),
              _CircleCanvas(manager: manager),
            ],
          );
        },
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final CircleDrawerManager manager;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: [
        ElevatedButton(
          onPressed: manager.actionsTaken.isEmpty ? null : manager.undoAction,
          child: const Text('Undo'),
        ),
        ElevatedButton(
          onPressed: manager.actionsUndone.isEmpty ? null : manager.redoAction,
          child: const Text('Redo'),
        ),
      ],
    );
  }
}

class _CircleCanvas extends StatelessWidget {
  const _CircleCanvas({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final CircleDrawerManager manager;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: GestureDetector(
          onTapUp: (tap) => manager.onTapCanvas(
            context,
            tap.localPosition,
          ),
          child: ClipRect(
            child: EventSubscriber(
              event: AggregateEvent([
                manager.circleSelectionChangedEvent,
                manager.circleRadiusChangedEvent,
              ]),
              builder: (context, args) {
                return CustomPaint(
                  painter: _CirclePainter(manager.circles),
                  size: Size.infinite,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final _stroke = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  final _fill = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.fill
    ..strokeWidth = 0;
  final List<Circle> _circles;

  _CirclePainter(this._circles);

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
