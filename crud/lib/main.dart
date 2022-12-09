import 'package:crud/services/crud_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/app.dart';
import '/common/name.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

void setupGetIt() {
  GetIt.I.registerLazySingleton<NameService>(
    () => InMemoryNameService(prefilledNames: [
      const Name(id: 0, last: 'Hans', first: 'Emil'),
      const Name(id: 1, last: 'Mustermann', first: 'Max'),
      const Name(id: 2, last: 'Tisch', first: 'Roman'),
    ]),
  );
}
