part of '../screen.dart';

class _Date1TextField extends StatelessWidget {
  const _Date1TextField({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final FlightBookerManager manager;

  @override
  Widget build(BuildContext context) {
    return EventSubscriber(
      event: manager.date1ChangedEvent,
      builder: (_, __) {
        return TextFormField(
          initialValue: manager.date1,
          decoration: InputDecoration(
            errorText: manager.isDate1Valid ? null : 'Invalid date',
          ),
          onChanged: manager.updateDate1,
        );
      },
    );
  }
}
