import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/bp_record.dart';

class BPFormScreen extends StatelessWidget {
  BPFormScreen({super.key});

  final systolicController = TextEditingController();
  final diastolicController = TextEditingController();
  final pulseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<BPRecord>("bpBox");

    return Scaffold(
      appBar: AppBar(title: const Text("Add BP Record")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: systolicController,
              decoration: const InputDecoration(labelText: "Systolic"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: diastolicController,
              decoration: const InputDecoration(labelText: "Diastolic"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: pulseController,
              decoration: const InputDecoration(labelText: "Pulse"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                box.add(
                  BPRecord(
                    systolic: int.parse(systolicController.text),
                    diastolic: int.parse(diastolicController.text),
                    pulse: int.parse(pulseController.text),
                    timestamp: DateTime.now(),
                  ),
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
