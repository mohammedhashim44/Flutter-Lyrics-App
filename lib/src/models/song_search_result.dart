class SongSearchResult {
  List<SongDetails> songsDetails;

  SongSearchResult(this.songsDetails);

  factory SongSearchResult.fromJson(Map<String, dynamic> json) {
    List<SongDetails> songs = [];
    var songsJson = json["songs"] as List<dynamic>;
    songsJson.forEach((songJson) {
      SongDetails song = SongDetails.fromJson(songJson);
      songs.add(song);
    });
    return SongSearchResult(songs);
  }
}

class SongDetails {
  String songName;
  String singer;
  String link;

  SongDetails(this.songName, this.singer, this.link);

  factory SongDetails.fromJson(Map<String, dynamic> json) {
    return SongDetails(
      json["song_name"] as String,
      json["singer"] as String,
      json["link"] as String,
    );
  }
}
