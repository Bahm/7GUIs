import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Timer',
      home: MyHomePage(title: 'Timer'),
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
  double _elapsed = 0.0;
  double _duration = 15.0;

  @override
  void initState() {
    super.initState();
    const stepMs = 20;

    final _ = Timer.periodic(
      const Duration(milliseconds: stepMs),
      (_) => setState(() {
        _elapsed += stepMs / 1000;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text('Elapsed Time: '),
                Expanded(
                  child: LinearProgressIndicator(value: _elapsed / _duration),
                ),
              ],
            ),
            Text(
              min(_elapsed, _duration).toStringAsFixed(1),
            ),
            Row(
              children: [
                const Text('Duration: '),
                Expanded(
                  child: Slider(
                    min: 0.0001,
                    max: 30.0,
                    value: _duration,
                    onChanged: (value) => setState(() {
                      _duration = value;
                    }),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Reset Timer'),
                    onPressed: () => setState(() {
                      _elapsed = 0.0;
                    }),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
