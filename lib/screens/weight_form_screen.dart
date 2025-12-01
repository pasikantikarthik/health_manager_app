import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/weight_record.dart';

class WeightFormScreen extends StatelessWidget {
  const WeightFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final box = Hive.box<WeightRecord>("weightBox");

    return Scaffold(
      appBar: AppBar(title: const Text("Add Weight")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                final value = double.tryParse(controller.text);
                if (value == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter valid weight")),
                  );
                  return;
                }

                box.add(
                  WeightRecord(
                    weight: value,
                    timestamp: DateTime.now(),
                  ),
                );

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
