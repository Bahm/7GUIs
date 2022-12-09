import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/app.dart';
import '/services/counter_service.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

void setupGetIt() {
  GetIt.I.registerLazySingleton<CounterService>(() => InMemoryCounterService());
}
