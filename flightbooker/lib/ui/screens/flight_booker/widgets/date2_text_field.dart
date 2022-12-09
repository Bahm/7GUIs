part of '../screen.dart';

class _Date2TextField extends StatelessWidget {
  const _Date2TextField({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final FlightBookerManager manager;

  @override
  Widget build(BuildContext context) {
    return EventSubscriber(
      event: AggregateEvent([
        manager.date1ChangedEvent,
        manager.date2ChangedEvent,
        manager.flightTypeChangedEvent,
      ]),
      builder: (_, __) {
        return TextFormField(
          initialValue: manager.date2,
          decoration: InputDecoration(
            errorText: manager.isOneWayFlight
                ? null
                : manager.isDate2Valid
                    ? manager.isDate1BeforeDate2
                        ? null
                        : 'Return flight cannot be earlier than first flight'
                    : 'Invalid date',
            enabled: manager.isReturnFlight,
          ),
          onChanged: manager.updateDate2,
          style: TextStyle(
            color: manager.isReturnFlight ? Colors.black : Colors.grey,
          ),
        );
      },
    );
  }
}
