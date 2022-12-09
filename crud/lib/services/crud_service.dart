import '/common/name.dart';

abstract class NameService {
  List<Name> getNames();
  void addName({
    required String first,
    required String last,
  });
  void updateName({
    required int id,
    required String first,
    required String last,
  });
  void removeName({required int id});
}

class InMemoryNameService extends NameService {
  final List<Name> _names;
  int _nextId;

  InMemoryNameService({List<Name>? prefilledNames})
      : _names = prefilledNames ?? [],
        _nextId = prefilledNames?.length ?? 0;

  @override
  List<Name> getNames() => _names;

  @override
  void addName({required String first, required String last}) {
    _names.add(Name(
      id: _nextId,
      first: first,
      last: last,
    ));
    _nextId += 1;
  }

  @override
  void updateName({
    required int id,
    required String first,
    required String last,
  }) {
    int i = _names.indexWhere((n) => n.id == id);
    _names[i] = Name(id: id, first: first, last: last);
  }

  @override
  void removeName({required int id}) {
    int i = _names.indexWhere((n) => n.id == id);
    _names.removeAt(i);
  }
}
