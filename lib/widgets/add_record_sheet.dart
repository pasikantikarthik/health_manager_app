import 'package:flutter/material.dart';
import '../screens/bp_form_screen.dart';
import '../screens/sugar_form_screen.dart';
import '../screens/weight_form_screen.dart';

class AddRecordSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.monitor_heart),
              title: const Text("Add BP Record"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BPFormScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype),
              title: const Text("Add Sugar Record"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SugarFormScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.monitor_weight),
              title: const Text("Add Weight Record"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => WeightFormScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
