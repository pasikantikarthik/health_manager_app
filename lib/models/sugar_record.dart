import 'package:hive/hive.dart';

part 'sugar_record.g.dart';

@HiveType(typeId: 2)
class SugarRecord extends HiveObject {
  @HiveField(0)
  int level;

  @HiveField(1)
  DateTime timestamp;

  SugarRecord({
    required this.level,
    required this.timestamp,
  });
}
