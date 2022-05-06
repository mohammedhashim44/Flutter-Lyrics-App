import 'package:hive/hive.dart';

part 'song_data.g.dart';

@HiveType(typeId: 0)
class SongData {
  @HiveField(0)
  String? identifier;

  @HiveField(1)
  String? songTitle;

  @HiveField(2)
  String? singer;

  @HiveField(3)
  String? image;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? lyrics;

  SongData(this.identifier, this.songTitle, this.singer, this.image,
      this.description, this.lyrics);

  factory SongData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json;
    return SongData(
      data["id"].toString(),
      data["title"],
      data["primary_artist"]["name"],
      data["song_art_image_thumbnail_url"],
      data["description"]["plain"],
      data["lyrics"],
    );
  }

  bool isTheSameSong(SongData songData) {
    return this.identifier == songData.identifier;
  }
}
