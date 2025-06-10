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
      vin: fields[0] as String,
      model: fields[1] as String,
      price: fields[2] as double,
      uuid: fields[3] as String,
      positiveFeedback: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CarInfoBox obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.vin)
      ..writeByte(1)
      ..write(obj.model)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.uuid)
      ..writeByte(4)
      ..write(obj.positiveFeedback);
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
