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
      id: fields[0] as int,
      feedback: fields[1] as String,
      valuatedAt: fields[2] as String,
      requestedAt: fields[3] as String,
      createdAt: fields[4] as String,
      updatedAt: fields[5] as String,
      make: fields[6] as String,
      model: fields[7] as String,
      externalId: fields[8] as String,
      sellerUser: fields[9] as String,
      price: fields[10] as int,
      positiveCustomerFeedback: fields[11] as bool,
      uuidAuction: fields[12] as String,
      inspectorRequestedAt: fields[13] as String,
      origin: fields[14] as String,
      estimationRequestId: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CarInfoBox obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.feedback)
      ..writeByte(2)
      ..write(obj.valuatedAt)
      ..writeByte(3)
      ..write(obj.requestedAt)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.make)
      ..writeByte(7)
      ..write(obj.model)
      ..writeByte(8)
      ..write(obj.externalId)
      ..writeByte(9)
      ..write(obj.sellerUser)
      ..writeByte(10)
      ..write(obj.price)
      ..writeByte(11)
      ..write(obj.positiveCustomerFeedback)
      ..writeByte(12)
      ..write(obj.uuidAuction)
      ..writeByte(13)
      ..write(obj.inspectorRequestedAt)
      ..writeByte(14)
      ..write(obj.origin)
      ..writeByte(15)
      ..write(obj.estimationRequestId);
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
