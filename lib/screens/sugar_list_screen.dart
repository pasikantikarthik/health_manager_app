import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/sugar_record.dart';

class SugarListScreen extends StatefulWidget {
  const SugarListScreen({super.key});

  @override
  State<SugarListScreen> createState() => _SugarListScreenState();
}

class _SugarListScreenState extends State<SugarListScreen> {
  late Box<SugarRecord> sugarBox;

  @override
  void initState() {
    super.initState();
    sugarBox = Hive.box<SugarRecord>("sugarBox");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sugar Records")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSugarEntryDialog(),
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: sugarBox.listenable(),
        builder: (context, Box<SugarRecord> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No sugar records yet."));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final record = box.get(index)!;

              return Card(
                child: ListTile(
                  title: Text("${record.value} mg/dL (${record.type})"),
                  subtitle: Text(record.timestamp.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => sugarBox.delete(index),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Add Sugar Entry
  void _showSugarEntryDialog() {
    final valueController = TextEditingController();
    String selectedType = "FBS"; // default

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Sugar Record"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: valueController,
                decoration: const InputDecoration(labelText: "Sugar Value"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedType,
                items: const [
                  DropdownMenuItem(value: "FBS", child: Text("FBS (Fasting)")),
                  DropdownMenuItem(value: "PPBS", child: Text("PPBS (Post Meal)")),
                  DropdownMenuItem(value: "RBS", child: Text("Random)")),
                ],
                onChanged: (value) {
                  selectedType = value!;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final value = int.tryParse(valueController.text);
                if (value == null) return;

                sugarBox.add(
                  SugarRecord(
                    value: value,
                    type: selectedType,
                    timestamp: DateTime.now(),
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
