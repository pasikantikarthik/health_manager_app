import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/sugar_record.dart';

class SugarForm extends StatefulWidget {
  const SugarForm({super.key});

  @override
  State<SugarForm> createState() => _SugarFormState();
}

class _SugarFormState extends State<SugarForm> {
  final levelCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sugarBox = Hive.box<SugarRecord>('sugarBox');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: levelCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Sugar Level (mg/dL)"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              sugarBox.add(
                SugarRecord(
                  level: int.parse(levelCtrl.text),
                  timestamp: DateTime.now(),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
