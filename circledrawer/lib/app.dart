import 'package:circledrawer/ui/screens/circle_drawer/manager.dart';
import 'package:flutter/material.dart';

import '/ui/screens/circle_drawer/screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circle Drawer',
      home: CircleDrawerScreen(
        manager: CircleDrawerManager(),
      ),
    );
  }
}
