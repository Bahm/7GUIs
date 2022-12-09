import 'package:flutter/material.dart';

import '/ui/screens/crud/manager.dart';
import '/ui/screens/crud/screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD',
      home: CrudScreen(
        manager: CrudManager(),
      ),
    );
  }
}
