import 'package:flutter/material.dart';

import '/ui/screens/flight_booker/manager.dart';
import '/ui/screens/flight_booker/screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Booker',
      home: FlightBookerScreen(
        manager: FlightBookerManager(),
      ),
    );
  }
}
