part of '../screen.dart';

class _DurationSlider extends StatelessWidget {
  const _DurationSlider({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final TimerManager manager;

  @override
  Widget build(BuildContext context) {
    return EventSubscriber(
      event: manager.durationChangedEvent,
      builder: (_, __) {
        return Row(
          children: [
            const Text('Duration: '),
            Expanded(
              child: Slider(
                min: 0.0001,
                max: 30.0,
                value: manager.duration,
                onChanged: manager.setDuration,
              ),
            ),
          ],
        );
      },
    );
  }
}
