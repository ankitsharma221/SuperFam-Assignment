import 'package:flutter/material.dart';
import '../widgets/key_value_card.dart';
import '../utils/db_helper.dart';
import 'add_key_value_sheet.dart';
import '../models/key_value.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<KeyValue> _keyValuePairs = [];

  @override
  void initState() {
    super.initState();
    _loadKeyValuePairs();
  }

  Future<void> _loadKeyValuePairs() async {
    final keyValuePairs = await _dbHelper.getKeyValues();
    setState(() {
      _keyValuePairs = keyValuePairs;
    });
  }

  void _showAddKeyValueSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddKeyValueSheet(onSaved: _loadKeyValuePairs),
    );
  }

  Future<void> _deleteKeyValue(KeyValue item) async {
    await _dbHelper.deleteKeyValue(item.id);
    _loadKeyValuePairs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Key-Value Pairs',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _keyValuePairs.isEmpty
            ? const Center(
                child: Text(
                  'No key-value pairs available',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.separated(
                itemCount: _keyValuePairs.length,
                itemBuilder: (context, index) {
                  final item = _keyValuePairs[index];
                  return Dismissible(
                    key: Key(item.id.toString()),
                    onDismissed: (direction) {
                      _deleteKeyValue(item);
                    },
                    child: KeyValueCard(
                      keyText: item.key,
                      valueText: item.value,
                      elevation: 4.0,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      onDelete: () => _deleteKeyValue(item),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 12.0),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: FloatingActionButton(
          onPressed: _showAddKeyValueSheet,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}