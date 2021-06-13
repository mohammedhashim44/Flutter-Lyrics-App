import 'package:hive/hive.dart';

part 'song_lyrics.g.dart';

@HiveType(typeId: 0)
class SongLyrics {
  @HiveField(0)
  String songTitle;

  @HiveField(1)
  String lyrics;

  SongLyrics(this.songTitle, this.lyrics);

  factory SongLyrics.fromJson(Map<String, dynamic> json) {
    return SongLyrics(
      json["song_title"],
      json["lyrics"],
    );
  }

  bool hasSameData(SongLyrics songLyrics) {
    return (this.lyrics == songLyrics.lyrics &&
        this.songTitle == songLyrics.songTitle);
  }
}
