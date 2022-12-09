import 'package:shared_preferences/shared_preferences.dart';

const _defaultDuration = 15.0;
const _defaultElapsed = 0.0;

abstract class TimerService {
  double getDuration();
  double getElapsed();

  void setDuration(double value);
  void setElapsed(double value);
}

class InMemoryTimerService extends TimerService {
  double _duration;
  double _elapsed = _defaultElapsed;

  InMemoryTimerService({double duration = _defaultDuration})
      : _duration = duration;

  @override
  double getDuration() => _duration;
  @override
  double getElapsed() => _elapsed;

  @override
  void setDuration(double value) => _duration = value;
  @override
  void setElapsed(double value) => _elapsed = value;
}

class LocalTimerService extends TimerService {
  final SharedPreferences _prefs;
  final String _prefsKey = 'timer';
  late final String _durationKey = '${_prefsKey}_duration';
  late final String _elapsedKey = '${_prefsKey}_elapsed';

  LocalTimerService(this._prefs);

  @override
  double getDuration() => _prefs.getDouble(_durationKey) ?? _defaultDuration;
  @override
  double getElapsed() => _prefs.getDouble(_elapsedKey) ?? _defaultElapsed;

  @override
  void setDuration(double value) => _prefs.setDouble(_durationKey, value);
  @override
  void setElapsed(double value) => _prefs.setDouble(_elapsedKey, value);
}
