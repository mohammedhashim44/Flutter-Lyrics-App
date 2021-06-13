// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_lyrics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongLyricsAdapter extends TypeAdapter<SongLyrics> {
  @override
  final int typeId = 0;

  @override
  SongLyrics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongLyrics(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SongLyrics obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.songTitle)
      ..writeByte(1)
      ..write(obj.lyrics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongLyricsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
