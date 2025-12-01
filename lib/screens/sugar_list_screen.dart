import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/sugar_record.dart';
import 'edit_sugar_screen.dart';
import 'charts/sugar_chart_screen.dart';

class SugarListScreen extends StatelessWidget {
  const SugarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<SugarRecord>("sugarBox");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sugar Records"),
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SugarChartScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SugarFormScreen()),
          );
        },
      ),
      body: StreamBuilder(
        stream: box.watch(),
        builder: (context, snapshot) {
          if (box.isEmpty) {
            return const Center(child: Text("No sugar records yet"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (_, index) {
              final record = box.getAt(index)!;
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.bloodtype, color: Colors.red),
                  title: Text("${record.level} mg/dL"),
                  subtitle: Text(record.timestamp.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditSugarScreen(
                                index: index,
                                record: record,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => box.deleteAt(index),
                      ),
                    ],
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

class SugarFormScreen extends StatelessWidget {
  const SugarFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final box = Hive.box<SugarRecord>("sugarBox");

    return Scaffold(
      appBar: AppBar(title: const Text("Add Sugar")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
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
                final value = int.tryParse(controller.text);
                if (value == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter valid sugar level")),
                  );
                  return;
                }

                box.add(
                  SugarRecord(
                    level: value,
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
