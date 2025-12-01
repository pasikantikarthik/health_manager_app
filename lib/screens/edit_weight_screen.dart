import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/weight_record.dart';

class EditWeightScreen extends StatefulWidget {
  final int index;
  final WeightRecord record;

  const EditWeightScreen({
    super.key,
    required this.index,
    required this.record,
  });

  @override
  State<EditWeightScreen> createState() => _EditWeightScreenState();
}

class _EditWeightScreenState extends State<EditWeightScreen> {
  late TextEditingController weightCtrl;

  @override
  void initState() {
    super.initState();
    weightCtrl = TextEditingController(
      text: widget.record.weight.toString(),
    );
  }

  @override
  void dispose() {
    weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weightBox = Hive.box<WeightRecord>('weightBox');

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Weight")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: weightCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Weight in kg"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                final parsed = double.tryParse(weightCtrl.text);
                if (parsed == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invalid weight")),
                  );
                  return;
                }

                weightBox.putAt(
                  widget.index,
                  WeightRecord(
                    weight: parsed,
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
