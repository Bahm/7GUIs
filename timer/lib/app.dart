import 'package:flutter/material.dart';
import 'package:timer/ui/screens/timer/manager.dart';

import '/ui/screens/timer/screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      home: TimerScreen(
        manager: TimerManager(),
      ),
    );
  }
}
