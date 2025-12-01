import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/bp_record.dart';

class EditBPScreen extends StatefulWidget {
  final int index;
  final BPRecord record;

  const EditBPScreen({super.key, required this.index, required this.record});

  @override
  State<EditBPScreen> createState() => _EditBPScreenState();
}

class _EditBPScreenState extends State<EditBPScreen> {
  late TextEditingController systolicCtrl;
  late TextEditingController diastolicCtrl;
  late TextEditingController pulseCtrl;

  @override
  void initState() {
    super.initState();
    systolicCtrl = TextEditingController(text: widget.record.systolic.toString());
    diastolicCtrl = TextEditingController(text: widget.record.diastolic.toString());
    pulseCtrl = TextEditingController(text: widget.record.pulse.toString());
  }

  @override
  void dispose() {
    systolicCtrl.dispose();
    diastolicCtrl.dispose();
    pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<BPRecord>("bpBox");

    return Scaffold(
      appBar: AppBar(title: const Text("Edit BP Record")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: systolicCtrl,
              decoration: const InputDecoration(labelText: "Systolic"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: diastolicCtrl,
              decoration: const InputDecoration(labelText: "Diastolic"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pulseCtrl,
              decoration: const InputDecoration(labelText: "Pulse"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                final updated = BPRecord(
                  systolic: int.parse(systolicCtrl.text),
                  diastolic: int.parse(diastolicCtrl.text),
                  pulse: int.parse(pulseCtrl.text),
                  timestamp: widget.record.timestamp, // keep old time
                );

                box.putAt(widget.index, updated);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
