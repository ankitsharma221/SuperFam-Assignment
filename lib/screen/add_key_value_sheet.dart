import 'package:flutter/material.dart';
import 'package:superfamtask/models/key_value.dart';
import 'package:superfamtask/utils/db_helper.dart';

class AddKeyValueSheet extends StatelessWidget {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final Function onSaved;

  AddKeyValueSheet({required this.onSaved});

  int _generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _keyController,
            decoration: InputDecoration(labelText: 'Key'),
          ),
          TextField(
            controller: _valueController,
            decoration: InputDecoration(labelText: 'Value'),
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  final key = _keyController.text;
                  final value = _valueController.text;
                  if (key.isNotEmpty && value.isNotEmpty) {
                    final keyValue = KeyValue(
                      id: _generateUniqueId(), // Provide the unique ID here
                      key: key,
                      value: value,
                    );
                    final dbHelper = DBHelper();
                    dbHelper.insertKeyValue(keyValue).then((_) {
                      onSaved();
                      Navigator.pop(context);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
