import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Temperature Converter',
      home: MyHomePage(title: 'Temperature Converter'),
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
  final _celciusController = TextEditingController();
  final _fahrenheitController = TextEditingController();

  int _cToF(int c) => (c.toDouble() * (9 / 5)).round() + 32;
  int _fToC(int f) => ((f - 32).toDouble() * (5 / 9)).round();

  void _updateFahrenheit(String celcius) {
    int? c = int.tryParse(celcius);

    if (c != null) {
      _fahrenheitController.text = _cToF(c).toString();
    }
  }

  void _updateCelcius(String fahrenheit) {
    int? f = int.tryParse(fahrenheit);

    if (f != null) {
      _celciusController.text = _fToC(f).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50.0,
            child: TextField(
              controller: _celciusController,
              onChanged: _updateFahrenheit,
            ),
          ),
          const Text('Celcius = '),
          SizedBox(
            width: 50.0,
            child: TextField(
              controller: _fahrenheitController,
              onChanged: _updateCelcius,
            ),
          ),
          const Text('Fahrenheit'),
        ],
      ),
    );
  }
}
