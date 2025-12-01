import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/weight_record.dart';
import 'charts/weight_chart_screen.dart';
import 'edit_weight_screen.dart';
import 'weight_form_screen.dart';

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<WeightRecord>("weightBox");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weight Records"),
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WeightChartScreen()),
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
            MaterialPageRoute(builder: (_) => WeightFormScreen()),
          );
        },
      ),
      body: StreamBuilder(
        stream: box.watch(),
        builder: (context, snapshot) {
          if (box.isEmpty) {
            return const Center(child: Text("No weight records yet"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (_, index) {
              final record = box.getAt(index)!;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.scale, color: Colors.green),
                  title: Text("${record.weight} kg"),
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
                              builder: (_) => EditWeightScreen(
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
