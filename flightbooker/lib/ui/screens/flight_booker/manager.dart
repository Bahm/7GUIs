import 'package:event/event.dart';
import 'package:get_it/get_it.dart';

import '/common/flight_type.dart';
import '/services/flight_booker_service.dart';

class FlightBookerManager {
  final _service = GetIt.I<FlightBookerService>();
  var _isDate1Valid = true;
  var _isDate2Valid = true;

  final flightTypeChangedEvent = Event();
  final date1ChangedEvent = Event();
  final date2ChangedEvent = Event();

  DateTime get _date1 => _service.getDate1();
  DateTime get _date2 => _service.getDate2();

  FlightType get flightType => _service.getFlightType();
  bool get isOneWayFlight => flightType == FlightType.oneWay;
  bool get isReturnFlight => flightType == FlightType.returning;
  bool get isDate1Valid => _isDate1Valid;
  bool get isDate2Valid => _isDate2Valid;
  bool get isDate1BeforeDate2 => !_date2.isBefore(_date1);
  bool get isBookingValid =>
      isDate1Valid && (isOneWayFlight || isDate2Valid && isDate1BeforeDate2);
  String get date1 => dateFormat.format(_date1);
  String get date2 => dateFormat.format(_date2);
  String get dialogMsg {
    return isOneWayFlight
        ? "You have booked a one-way flight for $date1"
        : "You have booked a return flight from $date1 to $date2";
  }

  void updateDate1(String newDate) {
    DateTime? date = parseDate(newDate);
    _isDate1Valid = date != null;

    if (_isDate1Valid) {
      _service.setDate1(date!);
    }

    date1ChangedEvent.broadcast();
  }

  void updateDate2(String newDate) {
    DateTime? date = parseDate(newDate);
    _isDate2Valid = date != null;

    if (_isDate2Valid) {
      _service.setDate2(date!);
    }

    date2ChangedEvent.broadcast();
  }

  void updateFlightType(FlightType? newType) {
    if (newType != null) {
      _service.setFlightType(newType);
    }

    flightTypeChangedEvent.broadcast();
  }
}
