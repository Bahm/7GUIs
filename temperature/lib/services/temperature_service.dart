import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnit {
  celcius,
  fahrenheit,
}

abstract class TemperatureService {
  Temperature? getTemperature();

  void setTemperature(Temperature newTemp);
}

class InMemoryTemperatureService extends TemperatureService {
  Temperature? _temperature;

  @override
  Temperature? getTemperature() => _temperature;

  @override
  void setTemperature(Temperature newTemp) => _temperature = newTemp;
}

class LocalTemperatureService extends TemperatureService {
  final SharedPreferences _prefs;
  final String _prefsKey = 'temperature';
  late final String _valueKey = '${_prefsKey}_value';
  late final String _unitKey = '${_prefsKey}_unit';

  LocalTemperatureService(this._prefs);

  @override
  Temperature? getTemperature() {
    return _prefs.containsKey(_valueKey) && _prefs.containsKey(_unitKey)
        ? Temperature(
            value: _prefs.getInt(_valueKey)!,
            unit: TemperatureUnit.values.byName(_prefs.getString(_unitKey)!),
          )
        : null;
  }

  @override
  void setTemperature(Temperature newTemp) {
    _prefs.setInt(_valueKey, newTemp.value);
    _prefs.setString(_unitKey, newTemp.unit.name);
  }
}

class Temperature {
  final int value;
  final TemperatureUnit unit;

  const Temperature({
    this.value = 0,
    this.unit = TemperatureUnit.celcius,
  });
}
