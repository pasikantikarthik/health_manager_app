// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sugar_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SugarRecordAdapter extends TypeAdapter<SugarRecord> {
  @override
  final int typeId = 2;

  @override
  SugarRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SugarRecord(
      level: fields[0] as int,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SugarRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SugarRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
