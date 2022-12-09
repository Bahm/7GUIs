import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '/services/temperature_service.dart';

class TemperatureManager {
  final _service = GetIt.I<TemperatureService>();
  final _celciusController = TextEditingController();
  final _fahrenheitController = TextEditingController();

  get celciusController => _celciusController;
  get fahrenheitController => _fahrenheitController;

  TemperatureManager() {
    final storedTemp = _service.getTemperature();

    if (storedTemp != null) {
      switch (storedTemp.unit) {
        case TemperatureUnit.celcius:
          _celciusController.text = '${storedTemp.value}';
          _fahrenheitController.text = '${_cToF(storedTemp.value).round()}';
          break;
        case TemperatureUnit.fahrenheit:
          _fahrenheitController.text = '${storedTemp.value}';
          _celciusController.text = '${_fToC(storedTemp.value).round()}';
          break;
      }
    }
  }

  int _cToF(int c) => (c.toDouble() * (9 / 5)).round() + 32;
  int _fToC(int f) => ((f - 32).toDouble() * (5 / 9)).round();

  void updateFahrenheit(String celcius) {
    int? c = int.tryParse(celcius);

    if (c != null) {
      _service.setTemperature(Temperature(
        unit: TemperatureUnit.celcius,
        value: c,
      ));
      _fahrenheitController.text = _cToF(c).toString();
    }
  }

  void updateCelcius(String fahrenheit) {
    int? f = int.tryParse(fahrenheit);

    if (f != null) {
      _service.setTemperature(Temperature(
        unit: TemperatureUnit.fahrenheit,
        value: f,
      ));
      _celciusController.text = _fToC(f).toString();
    }
  }
}
