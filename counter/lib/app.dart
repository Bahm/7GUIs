import 'package:flutter/material.dart';

import '/ui/screens/counter/manager.dart';
import '/ui/screens/counter/screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      home: CounterScreen(manager: CounterManager()),
    );
  }
}
