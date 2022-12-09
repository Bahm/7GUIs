import 'package:shared_preferences/shared_preferences.dart';

abstract class CounterService {
  int getCount();

  void increment();
}

class InMemoryCounterService extends CounterService {
  int _count = 0;

  @override
  int getCount() => _count;

  @override
  void increment() => _count++;
}

class LocalCounterService extends CounterService {
  final SharedPreferences _prefs;
  final String _prefsKey = 'counter';

  LocalCounterService(this._prefs) {
    if (!_prefs.containsKey(_prefsKey)) {
      _prefs.setInt(_prefsKey, 0);
    }
  }

  @override
  int getCount() => _prefs.getInt(_prefsKey)!;

  @override
  void increment() => _prefs.setInt(_prefsKey, getCount() + 1);
}
