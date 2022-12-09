import 'package:event/event.dart';
import 'package:get_it/get_it.dart';

import '/common/name.dart';
import '/services/crud_service.dart';

class CrudManager {
  final _service = GetIt.I<NameService>();
  int _selectedIndex = -1;
  String _prefixFilter = '';
  String _firstName = '';
  String _lastName = '';

  final filterUpdatedEvent = Event();
  final namesChangedEvent = Event();
  final selectionChangedEvent = Event();

  int get selectedIndex => _selectedIndex;
  List<Name> get filteredNames {
    return _service
        .getNames()
        .where((name) =>
            name.last.toLowerCase().startsWith(_prefixFilter.toLowerCase()))
        .toList();
  }

  void setSelectedIndex(int value) {
    _selectedIndex = value;
    selectionChangedEvent.broadcast();
  }

  void setFirstName(String value) => _firstName = value;
  void setLastName(String value) => _lastName = value;

  void setPrefixFilter(String value) {
    _prefixFilter = value;
    filterUpdatedEvent.broadcast();
    setSelectedIndex(-1);
  }

  void addName() {
    _service.addName(
      first: _firstName,
      last: _lastName,
    );
    namesChangedEvent.broadcast();
  }

  void updateSelectedName() {
    _service.updateName(
      id: filteredNames[selectedIndex].id,
      first: _firstName,
      last: _lastName,
    );
    namesChangedEvent.broadcast();
  }

  void deleteSelectedName() {
    _service.removeName(id: filteredNames[selectedIndex].id);
    namesChangedEvent.broadcast();
    setSelectedIndex(selectedIndex - 1);
  }
}
