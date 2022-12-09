import 'package:flutter/material.dart';

import './ui/screens/temperature/manager.dart';
import './ui/screens/temperature/screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      home: TemperatureScreen(manager: TemperatureManager()),
    );
  }
}
