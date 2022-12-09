import 'package:eventsubscriber/eventsubscriber.dart';
import 'package:flutter/material.dart';

import '/common/aggregate_event.dart';
import '/common/name.dart';
import '/ui/screens/crud/manager.dart';

class CrudScreen extends StatelessWidget {
  final CrudManager manager;

  const CrudScreen({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD'),
      ),
      body: Column(
        children: [
          _PrefixFilterTextField(manager: manager),
          Expanded(
            child: Row(
              children: [
                _NameListBox(manager: manager),
                _NameForm(manager: manager),
              ],
            ),
          ),
          _CrudButtons(manager: manager),
        ],
      ),
    );
  }
}

class _CrudButtons extends StatelessWidget {
  const _CrudButtons({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final CrudManager manager;

  @override
  Widget build(BuildContext context) {
    return EventSubscriber(
      event: manager.selectionChangedEvent,
      builder: (_, __) {
        return Wrap(
          spacing: 5.0,
          children: [
            ElevatedButton(
              onPressed: manager.addName,
              child: const Text('Create'),
            ),
            ElevatedButton(
              onPressed:
                  manager.selectedIndex < 0 ? null : manager.updateSelectedName,
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed:
                  manager.selectedIndex < 0 ? null : manager.deleteSelectedName,
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

class _NameListBox extends StatelessWidget {
  const _NameListBox({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final CrudManager manager;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: EventSubscriber(
        event: AggregateEvent([
          manager.selectionChangedEvent,
          manager.filterUpdatedEvent,
          manager.namesChangedEvent,
        ]),
        builder: (_, __) {
          return _NameList(
            names: manager.filteredNames,
            onTapItem: manager.setSelectedIndex,
            selectedIndex: manager.selectedIndex,
          );
        },
      ),
    );
  }
}

class _NameForm extends StatelessWidget {
  const _NameForm({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final CrudManager manager;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Wrap(
            children: [
              const Text('Name: '),
              TextField(
                onChanged: manager.setFirstName,
              ),
            ],
          ),
          Wrap(
            children: [
              const Text('Surname: '),
              TextField(
                onChanged: manager.setLastName,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrefixFilterTextField extends StatelessWidget {
  const _PrefixFilterTextField({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final CrudManager manager;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const Text('Filter prefix: '),
        TextField(
          onChanged: manager.setPrefixFilter,
        ),
      ],
    );
  }
}

class _NameList extends StatelessWidget {
  final List<Name> names;
  final void Function(int)? onTapItem;
  final int selectedIndex;

  const _NameList({
    required this.names,
    this.onTapItem,
    this.selectedIndex = -1,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: names.length,
      itemBuilder: (context, i) {
        Name name = names[i];

        return ListTile(
          title: Text('${name.last}, ${name.first}'),
          onTap: () {
            if (onTapItem != null) {
              onTapItem!(i);
            }
          },
          selected: i == selectedIndex,
        );
      },
      prototypeItem: const ListTile(
        dense: true,
      ),
    );
  }
}
