part of '../screen.dart';

class _FlightTypeDropdown extends StatelessWidget {
  const _FlightTypeDropdown({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final FlightBookerManager manager;

  @override
  Widget build(BuildContext context) {
    return EventSubscriber(
      event: manager.flightTypeChangedEvent,
      builder: (_, __) {
        return DropdownButton(
          value: manager.flightType,
          items: const [
            DropdownMenuItem(
              value: FlightType.oneWay,
              child: Text("One-way flight"),
            ),
            DropdownMenuItem(
              value: FlightType.returning,
              child: Text("Return flight"),
            ),
          ],
          onChanged: manager.updateFlightType,
        );
      },
    );
  }
}
