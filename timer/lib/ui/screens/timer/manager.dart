import 'package:event/event.dart';
import 'package:get_it/get_it.dart';

import '/services/timer_service.dart';

class TimerManager {
  final _service = GetIt.I<TimerService>();

  final int stepMs;
  final durationChangedEvent = Event();

  double get elapsed => _service.getElapsed();
  double get duration => _service.getDuration();

  TimerManager({this.stepMs = 16});

  void resetTimer() {
    _service.setElapsed(0.0);
  }

  void addElapsed(double value) {
    _service.setElapsed(_service.getElapsed() + value);
  }

  void setDuration(double value) {
    _service.setDuration(value);
    durationChangedEvent.broadcast();
  }
}
