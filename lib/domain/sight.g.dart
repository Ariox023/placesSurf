// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SightAdapter extends TypeAdapter<Sight> {
  @override
  final int typeId = 0;

  @override
  Sight read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sight(
      name: fields[0] as String,
      lat: fields[1] as double,
      lon: fields[2] as double,
      url: (fields[3] as List).cast<String>(),
      details: fields[4] as String,
      type: fields[5] as String,
      liked: fields[6] as bool,
      visited: fields[7] as bool,
      workingHours: fields[8] as String,
      timeVisit: fields[9] as String,
      addedImages: (fields[10] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Sight obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lon)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.details)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.liked)
      ..writeByte(7)
      ..write(obj.visited)
      ..writeByte(8)
      ..write(obj.workingHours)
      ..writeByte(9)
      ..write(obj.timeVisit)
      ..writeByte(10)
      ..write(obj.addedImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SightAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
