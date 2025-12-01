import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/bp_record.dart';
import 'models/sugar_record.dart';
import 'models/weight_record.dart';
import 'models/medicine_record.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(BPRecordAdapter());
  Hive.registerAdapter(SugarRecordAdapter());
  Hive.registerAdapter(WeightRecordAdapter());
  Hive.registerAdapter(MedicineRecordAdapter());

  // Open all boxes
  await Hive.openBox<BPRecord>("bpBox");
  await Hive.openBox<SugarRecord>("sugarBox");
  await Hive.openBox<WeightRecord>("weightBox");
  await Hive.openBox<MedicineRecord>("medicineBox");


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Health Manager",
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
