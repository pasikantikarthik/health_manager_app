import 'package:hive/hive.dart';

part 'medicine_record.g.dart';

@HiveType(typeId: 4)
class MedicineRecord extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String dosage;  // Changed from 'dose' for consistency

  @HiveField(2)
  DateTime time;

  @HiveField(3)
  bool repeatDaily;

  MedicineRecord({
    required this.name,
    required this.dosage,
    required this.time,
    required this.repeatDaily,
  });
}
