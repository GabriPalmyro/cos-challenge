// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_info_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarInfoBoxAdapter extends TypeAdapter<CarInfoBox> {
  @override
  final int typeId = 1;

  @override
  CarInfoBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarInfoBox(
      make: fields[0] as String,
      model: fields[1] as String,
      containerName: fields[2] as String,
      similarity: fields[3] as int,
      externalId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CarInfoBox obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.make)
      ..writeByte(1)
      ..write(obj.model)
      ..writeByte(2)
      ..write(obj.containerName)
      ..writeByte(3)
      ..write(obj.similarity)
      ..writeByte(4)
      ..write(obj.externalId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarInfoBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
