import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum FlightType {
  oneWay,
  returning,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flight Booker',
      home: MyHomePage(title: 'Flight Booker'),
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
  final _dateFormat = DateFormat('dd.MM.y');
  var _flightType = FlightType.oneWay;
  var _date1 = DateTime.now();
  var _date2 = DateTime.now();
  var _isDate1Valid = true;
  var _isDate2Valid = true;

  get _isBookingValid =>
      _isDate1Valid && (_flightType == FlightType.oneWay || _isDate2Valid);

  DateTime? _parseDate(String date) {
    try {
      return _dateFormat.parseStrict(date);
    } on FormatException {
      // Invalid date format
    } on ArgumentError {
      // Milliseconds since epoch overflows int, e.g., year 302022
    }

    return null;
  }

  void _bookFlight() {
    String date1 = _dateFormat.format(_date1);
    late String date2 = _dateFormat.format(_date2);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(_flightType == FlightType.oneWay
            ? "You have booked a one-way flight for $date1"
            : "You have booked a return flight from $date1 to $date2"),
      ),
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
            DropdownButton(
              value: _flightType,
              items: const [
                DropdownMenuItem(
                  value: FlightType.oneWay,
                  child: Text("One-way flight"),
                ),
                DropdownMenuItem(
                  value: FlightType.returning,
                  child: Text("Return flight"),
                ),
              ],
              onChanged: (FlightType? newType) {
                if (newType != null) {
                  setState(() {
                    _flightType = newType;
                  });
                }
              },
            ),
            TextFormField(
              initialValue: _dateFormat.format(_date1),
              decoration: InputDecoration(
                errorText: _isDate1Valid ? null : 'Invalid date',
              ),
              onChanged: (String newDate) {
                setState(() {
                  DateTime? date = _parseDate(newDate);
                  _isDate1Valid = date != null;

                  if (_isDate1Valid) {
                    _date1 = date!;
                  }
                });
              },
            ),
            TextFormField(
              // TODO: Decorate disabled state to make it clearer
              initialValue: _dateFormat.format(_date2),
              decoration: InputDecoration(
                errorText: _isDate2Valid
                    ? !_date2.isBefore(_date1)
                        ? null
                        : 'Return flight cannot be earlier than first flight'
                    : 'Invalid date',
                enabled: _flightType == FlightType.returning,
              ),
              onChanged: (String newDate) {
                setState(() {
                  DateTime? date = _parseDate(newDate);
                  _isDate2Valid = date != null;

                  if (_isDate2Valid) {
                    _date2 = date!;
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: _isBookingValid ? _bookFlight : null,
              child: const Text("Book"),
            ),
          ],
        ),
      ),
    );
  }
}
