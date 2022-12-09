import 'package:flutter/material.dart';

class CounterText extends StatelessWidget {
  final ValueNotifier<int> counter;
  final String prefix;
  final String suffix;

  const CounterText({
    Key? key,
    required this.counter,
    this.suffix = '',
    this.prefix = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: counter,
      builder: (_, value, __) => Text('$prefix$value$suffix'),
    );
  }
}
