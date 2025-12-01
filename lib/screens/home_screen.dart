import 'package:flutter/material.dart';
import 'bp_screen.dart';
import 'sugar_screen.dart';
import 'weight_screen.dart';
import 'charts/bp_chart_screen.dart';
import 'charts/sugar_chart_screen.dart';
import 'charts/weight_chart_screen.dart';
import 'medicine_list_screen.dart'; // <-- Added

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _homeCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.blue,
  }) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, size: 32, color: color),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Manager"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _homeCard(
            title: "Blood Pressure Records",
            icon: Icons.monitor_heart,
            color: Colors.red,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BPScreen()),
            ),
          ),
          _homeCard(
            title: "Sugar Records",
            icon: Icons.bloodtype,
            color: Colors.orange,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SugarScreen()),
            ),
          ),
          _homeCard(
            title: "Weight Records",
            icon: Icons.scale,
            color: Colors.green,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WeightScreen()),
            ),
          ),
          _homeCard(
            title: "Medicine Reminders",   // <-- NEW FEATURE
            icon: Icons.medication,
            color: Colors.purple,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MedicineListScreen()),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Charts",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _homeCard(
            title: "BP Chart",
            icon: Icons.show_chart,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BPChartScreen()),
            ),
          ),
          _homeCard(
            title: "Sugar Chart",
            icon: Icons.insights,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SugarChartScreen()),
            ),
          ),
          _homeCard(
            title: "Weight Chart",
            icon: Icons.bar_chart,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WeightChartScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
