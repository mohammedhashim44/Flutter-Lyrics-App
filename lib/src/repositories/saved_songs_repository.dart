import 'package:flutter_lyrics/src/models/song_data.dart';

import 'package:flutter_lyrics/src/repositories/local_storage_repository.dart';

class SavedSongsRepository {
  final LocalStorageRepository _localStorageRepository;

  SavedSongsRepository(this._localStorageRepository);

  List<SongData> getSavedSongs() {
    var songs = _localStorageRepository.getSavedSongs();
    return songs.reversed.toList();
  }

  Future<void> addNewSong(SongData songLyrics) async {
    await _localStorageRepository.addNewSong(songLyrics);
  }

  Future<void> deleteSong(SongData songLyrics) async {
    await _localStorageRepository.deleteSong(songLyrics);
  }

  bool isSongSaved(SongData songLyrics) {
    return _localStorageRepository.isSongSaved(songLyrics);
  }
}
