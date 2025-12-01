import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/bp_record.dart';
import 'edit_bp_screen.dart';
import 'bp_form_screen.dart';
import 'charts/bp_chart_screen.dart';

class BPScreen extends StatelessWidget {
  const BPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<BPRecord>("bpBox");

    return Scaffold(
      appBar: AppBar(
        title: const Text("BP Records"),
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BPChartScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: box.watch(),
        builder: (_, snapshot) {
          if (box.isEmpty) {
            return const Center(child: Text("No BP records yet"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (_, index) {
              final record = box.getAt(index)!;

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.monitor_heart, color: Colors.red),
                  title: Text(
                    "Sys: ${record.systolic}, Dia: ${record.diastolic}, Pulse: ${record.pulse}",
                  ),
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
                              builder: (_) => EditBPScreen(
                                index: index,
                                record: record,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BPFormScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
