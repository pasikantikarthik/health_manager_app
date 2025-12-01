import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/weight_record.dart';

class WeightChartScreen extends StatelessWidget {
  const WeightChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<WeightRecord>("weightBox");

    List<FlSpot> points = [];

    for (int i = 0; i < box.length; i++) {
      final r = box.getAt(i)!;
      points.add(
        FlSpot(i.toDouble(), r.weight),
      );
    }

    if (points.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Weight Chart")),
        body: const Center(
          child: Text("No weight data yet. Add records to see chart."),
        ),
      );
    }

    double minWeight = points.map((p) => p.y).reduce((a, b) => a < b ? a : b);
    double maxWeight = points.map((p) => p.y).reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(title: const Text("Weight Chart")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            minY: minWeight - 5,
            maxY: maxWeight + 5,
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            titlesData: const FlTitlesData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: points,
                isCurved: true,
                barWidth: 3,
                dotData: FlDotData(show: true),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
