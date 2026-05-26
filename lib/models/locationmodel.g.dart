// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationAdapter extends TypeAdapter<Locationsofuser> {
  @override
  final int typeId = 3;

  @override
  Locationsofuser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Locationsofuser(
        nameoflocation: fields[0] as String,
        poslang: fields[1] as double,
        poslat: fields[2] as double);
  }

  @override
  void write(BinaryWriter writer, Locationsofuser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nameoflocation)
      ..writeByte(1)
      ..write(obj.poslat)
      ..writeByte(2)
      ..write(obj.poslang);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
