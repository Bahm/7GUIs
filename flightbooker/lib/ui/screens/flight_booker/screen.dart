import 'package:eventsubscriber/eventsubscriber.dart';
import 'package:flutter/material.dart';

import '/common/aggregate_event.dart';
import '/common/flight_type.dart';
import '/ui/screens/flight_booker/manager.dart';

part './widgets/book_flight_button.dart';
part './widgets/date1_text_field.dart';
part './widgets/date2_text_field.dart';
part './widgets/flight_type_dropdown.dart';

class FlightBookerScreen extends StatelessWidget {
  final FlightBookerManager manager;

  const FlightBookerScreen({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Booker'),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _FlightTypeDropdown(manager: manager),
            _Date1TextField(manager: manager),
            _Date2TextField(manager: manager),
            _BookFlightButton(manager: manager),
          ],
        ),
      ),
    );
  }
}
