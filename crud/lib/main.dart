import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CRUD',
      home: MyHomePage(title: 'CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _names = [
    ['Hans', 'Emil'],
    ['Mustermann', 'Max'],
    ['Tisch', 'Roman'],
  ];
  var _selectedNameIndex = -1;
  var _nameField = '';
  var _surnameField = '';
  var _prefixFilter = '';

  List<List<String>> get _filteredNames {
    return _names
        .where((name) =>
            name[0].toLowerCase().startsWith(_prefixFilter.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Wrap(
            children: [
              const Text('Filter prefix: '),
              TextField(
                onChanged: (value) => setState(() {
                  _prefixFilter = value;
                  _selectedNameIndex = -1;
                }),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 200.0,
                  child: ListView.builder(
                    itemCount: _filteredNames.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(_filteredNames[i].join(', ')),
                        onTap: () => setState(() {
                          _selectedNameIndex = i;
                        }),
                        selected: i == _selectedNameIndex,
                      );
                    },
                    prototypeItem: const ListTile(
                      dense: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          const Text('Name: '),
                          TextField(
                            onChanged: (value) => setState(() {
                              _nameField = value;
                            }),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          const Text('Surname: '),
                          TextField(
                            onChanged: (value) => setState(() {
                              _surnameField = value;
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 5.0,
            children: [
              ElevatedButton(
                child: const Text('Create'),
                onPressed: () => setState(() {
                  _names.add([_surnameField, _nameField]);
                }),
              ),
              ElevatedButton(
                onPressed: _selectedNameIndex < 0
                    ? null
                    : () => setState(() {
                          _names[_selectedNameIndex] = [
                            _surnameField,
                            _nameField
                          ];
                        }),
                child: const Text('Update'),
              ),
              ElevatedButton(
                onPressed: _selectedNameIndex < 0
                    ? null
                    : () => setState(() {
                          _names.removeAt(_selectedNameIndex);
                          _selectedNameIndex -= 1;
                        }),
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
