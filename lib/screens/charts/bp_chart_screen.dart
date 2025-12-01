import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/bp_record.dart';

class BPChartScreen extends StatelessWidget {
  const BPChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<BPRecord>('bpBox');

    final List<FlSpot> sys = [];
    final List<FlSpot> dia = [];
    final List<FlSpot> pulse = [];

    for (int i = 0; i < box.length; i++) {
      final r = box.getAt(i)!;
      sys.add(FlSpot(i.toDouble(), r.systolic.toDouble()));
      dia.add(FlSpot(i.toDouble(), r.diastolic.toDouble()));
      pulse.add(FlSpot(i.toDouble(), r.pulse.toDouble()));
    }

    if (sys.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("BP Trend")),
        body: const Center(
          child: Text("No BP data added yet"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("BP Trend")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            minY: 40,
            maxY: 200,
            titlesData: const FlTitlesData(show: true),
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.shade300,
                strokeWidth: 0.8,
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: sys,
                isCurved: true,
                color: Colors.red,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.red.withOpacity(0.2),
                ),
              ),
              LineChartBarData(
                spots: dia,
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.2),
                ),
              ),
              LineChartBarData(
                spots: pulse,
                isCurved: true,
                color: Colors.green,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.green.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
