import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/sugar_record.dart';

class EditSugarScreen extends StatefulWidget {
  final int index;
  final SugarRecord record;

  const EditSugarScreen({super.key, required this.index, required this.record});

  @override
  State<EditSugarScreen> createState() => _EditSugarScreenState();
}

class _EditSugarScreenState extends State<EditSugarScreen> {
  late TextEditingController levelCtrl;

  @override
  void initState() {
    super.initState();
    levelCtrl = TextEditingController(text: widget.record.level.toString());
  }

  @override
  Widget build(BuildContext context) {
    final sugarBox = Hive.box<SugarRecord>('sugarBox');

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Sugar Record")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: levelCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Sugar Level (mg/dL)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sugarBox.putAt(
                  widget.index,
                  SugarRecord(
                    level: int.parse(levelCtrl.text),
                    timestamp: DateTime.now(),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
