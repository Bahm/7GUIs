import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/app.dart';
import '/services/flight_booker_service.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

void setupGetIt() {
  GetIt.I.registerLazySingleton<FlightBookerService>(
    () => InMemoryFlightBookerService(),
  );
}
