import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/common/flight_type.dart';

final dateFormat = DateFormat('dd.MM.y');
final _defaultDate = DateTime(2022, 10, 31);
const _defaultFlightType = FlightType.oneWay;

abstract class FlightBookerService {
  DateTime getDate1();
  DateTime getDate2();
  FlightType getFlightType();

  void setDate1(DateTime date);
  void setDate2(DateTime date);
  void setFlightType(FlightType type);
}

class InMemoryFlightBookerService extends FlightBookerService {
  DateTime _date1 = _defaultDate;
  DateTime _date2 = _defaultDate;
  FlightType _flightType = _defaultFlightType;

  @override
  DateTime getDate1() => _date1;
  @override
  DateTime getDate2() => _date2;
  @override
  FlightType getFlightType() => _flightType;

  @override
  void setDate1(DateTime date) => _date1 = date;
  @override
  void setDate2(DateTime date) => _date2 = date;
  @override
  void setFlightType(FlightType type) => _flightType = type;
}

class LocalFlightBookerService extends FlightBookerService {
  final SharedPreferences _prefs;
  final String _prefsKey = 'flight_booker';
  late final String _date1Key = '${_prefsKey}_date1';
  late final String _date2Key = '${_prefsKey}_date2';
  late final String _flightTypeKey = '${_prefsKey}_flightType';

  LocalFlightBookerService(this._prefs);

  DateTime _getDate(String key) {
    DateTime? date;

    if (_prefs.containsKey(key)) {
      date = parseDate(_prefs.getString(key)!);
    }

    return date ?? _defaultDate;
  }

  @override
  DateTime getDate1() => _getDate(_date1Key);

  @override
  DateTime getDate2() => _getDate(_date2Key);

  @override
  FlightType getFlightType() {
    FlightType? type;

    if (_prefs.containsKey(_flightTypeKey)) {
      type = FlightType.values.byName(_prefs.getString(_flightTypeKey)!);
    }

    return type ?? _defaultFlightType;
  }

  @override
  void setDate1(DateTime date) {
    _prefs.setString(_date1Key, dateFormat.format(date));
  }

  @override
  void setDate2(DateTime date) {
    _prefs.setString(_date2Key, dateFormat.format(date));
  }

  @override
  void setFlightType(FlightType type) {
    _prefs.setString(_flightTypeKey, type.name);
  }
}

DateTime? parseDate(String date) {
  DateTime? result;

  try {
    result = dateFormat.parseStrict(date);
  } on FormatException {
    // Invalid date format
  } on ArgumentError {
    // Milliseconds since epoch overflows int, e.g., year 302022
  }

  return result;
}
