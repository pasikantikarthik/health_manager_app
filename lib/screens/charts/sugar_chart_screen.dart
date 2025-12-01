import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/sugar_record.dart';

class SugarChartScreen extends StatelessWidget {
  const SugarChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<SugarRecord>('sugarBox');

    final List<FlSpot> points = [];

    for (int i = 0; i < box.length; i++) {
      final r = box.getAt(i)!;
      points.add(FlSpot(i.toDouble(), r.level.toDouble()));
    }

    if (points.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Sugar Trend")),
        body: const Center(
          child: Text("No sugar data added yet"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Sugar Trend")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            minY: 50,
            maxY: 300,
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.shade300,
                strokeWidth: 0.8,
              ),
            ),
            titlesData: const FlTitlesData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: points,
                isCurved: true,
                color: Colors.purple,
                barWidth: 4,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.purple.withOpacity(0.25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
