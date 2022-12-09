import 'package:flutter/material.dart';

import '/ui/widgets/temperature_text_field.dart';
import './manager.dart';

class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({super.key, required this.manager});

  final TemperatureManager manager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TemperatureTextField(
            controller: manager.celciusController,
            onChanged: manager.updateFahrenheit,
          ),
          const Text('Celcius = '),
          TemperatureTextField(
            controller: manager.fahrenheitController,
            onChanged: manager.updateCelcius,
          ),
          const Text('Fahrenheit'),
        ],
      ),
    );
  }
}
