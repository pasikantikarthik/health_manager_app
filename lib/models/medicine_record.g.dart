// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineRecordAdapter extends TypeAdapter<MedicineRecord> {
  @override
  final int typeId = 4;

  @override
  MedicineRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineRecord(
      name: fields[0] as String,
      dosage: fields[1] as String,
      time: fields[2] as DateTime,
      repeatDaily: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineRecord obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dosage)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.repeatDaily);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
