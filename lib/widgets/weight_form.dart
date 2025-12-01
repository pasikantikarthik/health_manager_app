import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/weight_record.dart';

class WeightForm extends StatefulWidget {
  const WeightForm({super.key});

  @override
  State<WeightForm> createState() => _WeightFormState();
}

class _WeightFormState extends State<WeightForm> {
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: weightController,
          decoration: const InputDecoration(
            labelText: "Weight (kg)",
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final weightBox = Hive.box<WeightRecord>("weightBox");

            weightBox.add(WeightRecord(
              weight: double.parse(weightController.text),
              timestamp: DateTime.now(),
            ));

            Navigator.pop(context);
          },
          child: const Text("Save"),
        )
      ],
    );
  }
}
