import 'dart:async';

import 'package:event/event.dart';

export 'package:event/event.dart';

class AggregateEvent extends Event {
  List<Event> events;

  AggregateEvent(this.events);

  @override
  void subscribe(EventHandler handler) {
    for (Event event in events) {
      event.subscribe(handler);
    }
  }

  @override
  bool unsubscribe(EventHandler handler) {
    bool wasFound = false;

    for (Event event in events) {
      wasFound = event.unsubscribe(handler) || wasFound;
    }

    return wasFound;
  }

  @override
  void unsubscribeAll() {
    for (Event event in events) {
      event.unsubscribeAll();
    }
  }

  @override
  int get subscriberCount => events.isNotEmpty ? events[0].subscriberCount : 0;

  @override
  void broadcast([EventArgs? args]) {
    for (Event event in events) {
      event.broadcast();
    }
  }

  @override
  void subscribeStream(StreamSink sink) {
    for (Event event in events) {
      event.subscribeStream(sink);
    }
  }
}
