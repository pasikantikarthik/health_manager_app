import 'package:hive/hive.dart';

part 'weight_record.g.dart';

@HiveType(typeId: 3)
class WeightRecord extends HiveObject {
  @HiveField(0)
  double weight; // Changed from 'kg' to 'weight' for consistency

  @HiveField(1)
  DateTime timestamp;

  WeightRecord({
    required this.weight,
    required this.timestamp,
  });
}
