import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/medicine_record.dart';
import 'medicine_form_screen.dart';

class MedicineListScreen extends StatelessWidget {
  const MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<MedicineRecord>("medicineBox");

    return Scaffold(
      appBar: AppBar(title: const Text("Medicine Reminders")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MedicineFormScreen()),
          );
        },
      ),
      body: StreamBuilder(
        stream: box.watch(),
        builder: (context, snapshot) {
          if (box.isEmpty) {
            return const Center(child: Text("No medicine reminders"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final medicine = box.getAt(index)!;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.medication, color: Colors.purple),
                  title: Text(medicine.name),
                  subtitle: Text(
                    "${medicine.dosage} - ${medicine.time.hour}:${medicine.time.minute.toString().padLeft(2, '0')}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

