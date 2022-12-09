import 'package:flutter/material.dart';

import './manager.dart';
import '../../widgets/counter_text.dart';

class CounterScreen extends StatelessWidget {
  final CounterManager manager;

  const CounterScreen({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CounterText(counter: manager.counter),
          TextButton(
            onPressed: manager.increment,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
