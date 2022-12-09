import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '/services/counter_service.dart';

class CounterManager {
  final _service = GetIt.I<CounterService>();
  final counter = ValueNotifier<int>(0);

  CounterManager() {
    counter.value = _service.getCount();
  }

  void increment() {
    counter.value++;
    _service.increment();
  }
}
