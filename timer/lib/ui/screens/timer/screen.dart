import 'dart:async';
import 'dart:math';

import 'package:eventsubscriber/eventsubscriber.dart';
import 'package:flutter/material.dart';

import '/ui/screens/timer/manager.dart';

part './widgets/elapsed_time_indicator.dart';
part './widgets/reset_button.dart';
part './widgets/duration_slider.dart';

class TimerScreen extends StatelessWidget {
  final TimerManager manager;

  const TimerScreen({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ElapsedTimeIndicator(manager: manager),
            _DurationSlider(manager: manager),
            _ResetButton(manager: manager),
          ],
        ),
      ),
    );
  }
}
