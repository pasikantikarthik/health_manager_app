import 'package:flutter/material.dart';

class BPForm extends StatefulWidget {
  const BPForm({super.key});

  @override
  State<BPForm> createState() => _BPFormState();
}

class _BPFormState extends State<BPForm> {
  final sysController = TextEditingController();
  final diaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Add Blood Pressure",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        TextField(
          controller: sysController,
          decoration: const InputDecoration(
            label: Text("Systolic (SYS)"),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 12),

        TextField(
          controller: diaController,
          decoration: const InputDecoration(
            label: Text("Diastolic (DIA)"),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Save"),
        )
      ],
    );
  }
}

