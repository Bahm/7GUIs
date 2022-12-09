import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/services/temperature_service.dart';
import '/app.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

void setupGetIt() {
  GetIt.I.registerLazySingleton<TemperatureService>(
      () => InMemoryTemperatureService());
}
