import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/sugar_record.dart';

class SugarFormScreen extends StatelessWidget {
  const SugarFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levelController = TextEditingController();
    final box = Hive.box<SugarRecord>("sugarBox");

    return Scaffold(
      appBar: AppBar(title: const Text("Add Sugar Record")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: levelController,
              decoration: const InputDecoration(
                labelText: "Sugar Level (mg/dL)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                final level = int.tryParse(levelController.text.trim());
                if (level == null) return;

                final record = SugarRecord(
                  level: level,
                  timestamp: DateTime.now(),
                );

                box.add(record);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
