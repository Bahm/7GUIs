part of '../screen.dart';

class _ElapsedTimeIndicator extends StatefulWidget {
  const _ElapsedTimeIndicator({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final TimerManager manager;

  @override
  State<_ElapsedTimeIndicator> createState() => _ElapsedTimeIndicatorState();
}

class _ElapsedTimeIndicatorState extends State<_ElapsedTimeIndicator> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      Duration(milliseconds: widget.manager.stepMs),
      (timer) {
        setState(() {
          widget.manager.addElapsed(widget.manager.stepMs / 1000);
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Elapsed Time: '),
            Expanded(
              child: LinearProgressIndicator(
                value: widget.manager.elapsed / widget.manager.duration,
              ),
            ),
          ],
        ),
        Text(
          min(widget.manager.elapsed, widget.manager.duration)
              .toStringAsFixed(1),
        ),
      ],
    );
  }
}
