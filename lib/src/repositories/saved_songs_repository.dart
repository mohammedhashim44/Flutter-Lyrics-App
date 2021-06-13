import 'package:flutter_lyrics/src/models/song_lyrics.dart';

import 'package:flutter_lyrics/src/repositories/local_storage_repository.dart';

class SavedSongsRepository {
  final LocalStorageRepository _localStorageRepository;

  SavedSongsRepository(this._localStorageRepository);

  List<SongLyrics> getSavedSongs() {
    var songs = _localStorageRepository.getSavedSongs();
    return songs;
  }

  Future<void> addNewSong(SongLyrics songLyrics) async {
    await _localStorageRepository.addNewSong(songLyrics);
  }

  Future<void> deleteSong(SongLyrics songLyrics) async {
    await _localStorageRepository.deleteSong(songLyrics);
  }

  bool isSongSaved(SongLyrics songLyrics) {
    return _localStorageRepository.isSongSaved(songLyrics);
  }
}
