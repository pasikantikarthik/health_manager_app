import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/medicine_record.dart';

class MedicineFormScreen extends StatefulWidget {
  const MedicineFormScreen({super.key});

  @override
  State<MedicineFormScreen> createState() => _MedicineFormScreenState();
}

class _MedicineFormScreenState extends State<MedicineFormScreen> {
  final nameController = TextEditingController();
  final dosageController = TextEditingController();
  TimeOfDay? selectedTime;
  bool repeatDaily = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Medicine Reminder")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Medicine Name"),
            ),
            TextField(
              controller: dosageController,
              decoration: const InputDecoration(labelText: "Dosage (e.g. 1 tablet)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() => selectedTime = time);
                }
              },
              child: Text(
                selectedTime == null
                    ? "Select Reminder Time"
                    : "Time: ${selectedTime!.format(context)}",
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: repeatDaily,
                  onChanged: (v) => setState(() => repeatDaily = v!),
                ),
                const Text("Repeat Daily")
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (selectedTime == null) return;

                final now = DateTime.now();
                final time = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );

                final box = Hive.box<MedicineRecord>("medicineBox");

                await box.add(MedicineRecord(
                  name: nameController.text,
                  dosage: dosageController.text,
                  time: time,
                  repeatDaily: repeatDaily,
                ));

                Navigator.pop(context);
              },
              child: const Text("Save Reminder"),
            )
          ],
        ),
      ),
    );
  }
}
