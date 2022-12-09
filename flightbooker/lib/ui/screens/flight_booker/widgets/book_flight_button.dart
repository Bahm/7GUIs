part of '../screen.dart';

class _BookFlightButton extends StatelessWidget {
  const _BookFlightButton({
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
        return ElevatedButton(
          onPressed: manager.isBookingValid
              ? () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(manager.dialogMsg),
                    ),
                  )
              : null,
          child: const Text("Book"),
        );
      },
    );
  }
}
