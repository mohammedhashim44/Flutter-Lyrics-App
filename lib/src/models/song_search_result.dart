import 'package:flutter_lyrics/src/models/song_data.dart';

class SongSearchResult {
  List<SongDetails> songsDetails;

  SongSearchResult(this.songsDetails);

  factory SongSearchResult.fromJson(Map<String, dynamic> json) {
    print(json);
    print("###" * 50);
    List<SongDetails> songs = [];
    var songsJson = json["data"] as List<dynamic>;
    songsJson.forEach((songJson) {
      SongDetails song = SongDetails.fromJson(songJson);
      songs.add(song);
    });
    return SongSearchResult(songs);
  }
}

class SongDetails {
  String identifier;
  String songName;
  String singer;
  String songImage;
  String songImageLowQuality;

  SongDetails(
    this.identifier,
    this.songName,
    this.singer,
    this.songImage,
  );

  factory SongDetails.fromJson(Map<String, dynamic> json) {
    return SongDetails(
      json["identifier"] as String,
      json["song_name"] as String,
      json["singer"] as String,
      json["song_image"] as String,
    );
  }

  factory SongDetails.fromSongData(SongData songData) {
    return SongDetails(
      songData.identifier,
      songData.songTitle,
      songData.singer,
      songData.image,
    );
  }

}
