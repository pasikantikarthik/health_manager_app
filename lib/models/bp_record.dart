import 'package:hive/hive.dart';

part 'bp_record.g.dart';

@HiveType(typeId: 1)
class BPRecord {
  @HiveField(0)
  int systolic;

  @HiveField(1)
  int diastolic;

  @HiveField(2)
  int pulse;

  @HiveField(3)
  DateTime timestamp;

  BPRecord({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.timestamp,
  });
}
