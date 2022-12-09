part of '../screen.dart';

class _ResetButton extends StatelessWidget {
  const _ResetButton({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final TimerManager manager;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: manager.resetTimer,
            child: const Text('Reset Timer'),
          ),
        )
      ],
    );
  }
}
