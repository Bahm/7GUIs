import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:timer/services/timer_service.dart';

import '/app.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

void setupGetIt() {
  GetIt.I.registerLazySingleton<TimerService>(
    () => InMemoryTimerService(),
  );
}
