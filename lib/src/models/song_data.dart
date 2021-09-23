import 'package:hive/hive.dart';

part 'song_data.g.dart';

@HiveType(typeId: 0)
class SongData {
  @HiveField(0)
  String identifier;

  @HiveField(1)
  String songTitle;

  @HiveField(2)
  String singer;

  @HiveField(3)
  String image;

  @HiveField(4)
  String description;

  @HiveField(5)
  String lyrics;

  SongData(this.identifier, this.songTitle, this.singer, this.image,
      this.description, this.lyrics);

  factory SongData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json["data"];
    return SongData(
      data["identifier"],
      data["song_title"],
      data["singer"],
      data["image"],
      data["description"],
      data["lyrics"],
    );
  }

  bool isTheSameSong(SongData songData) {
    return this.identifier == songData.identifier;
  }
}
