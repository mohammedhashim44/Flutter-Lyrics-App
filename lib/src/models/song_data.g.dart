// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongDataAdapter extends TypeAdapter<SongData> {
  @override
  final int typeId = 0;

  @override
  SongData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongData(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SongData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.identifier)
      ..writeByte(1)
      ..write(obj.songTitle)
      ..writeByte(2)
      ..write(obj.singer)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.lyrics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
