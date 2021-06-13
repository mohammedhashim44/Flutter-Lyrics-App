import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_lyrics/src/models/song_lyrics.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

const SONGS_BOX_NAME = "songs_box";
const SETTINGS_BOX_NAME = "settings_box";

const SAVED_SONGS_KEY = "saved_songs";
const FONT_FACTOR_KEY = "font_factor";

const double MAX_FONT_FACTOR = 2;

const double MIN_FONT_FACTOR = 1;

class LocalStorageRepository {
  ValueNotifier<double> fontFactorListenable;

  Box _songBox;
  Box _settingsBox;

  Future<void> init() async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();

    Hive.registerAdapter(SongLyricsAdapter());
    Hive.init(directory.path);
    _songBox = await Hive.openBox(SONGS_BOX_NAME);
    _settingsBox = await Hive.openBox(SETTINGS_BOX_NAME);

    fontFactorListenable = ValueNotifier(getFontFactor());
  }

  List<SongLyrics> getSavedSongs() {
    var x = _songBox.values.map<SongLyrics>((e) => e).toList();
    return x;
  }

  Future<void> addNewSong(SongLyrics songLyrics) async {
    await _songBox.add(songLyrics);
  }

  int getSongIndex(SongLyrics songLyrics){
    var songs = getSavedSongs();

    var songIndex = songs.indexWhere((element) {
      return element.hasSameData(songLyrics);
    });
    return songIndex;
  }

  Future<void> deleteSong(SongLyrics songLyrics) async {
    var songIndex = getSongIndex(songLyrics);
    if (songIndex != -1) {
      await _songBox.deleteAt(songIndex);
    }
  }

  bool isSongSaved(SongLyrics songLyrics){
    var songIndex = getSongIndex(songLyrics);
    if(songIndex == -1){
      return false;
    }
    return true;
  }

  double getFontFactor() {
    return _settingsBox.get(FONT_FACTOR_KEY, defaultValue: 1.0);
  }

  void setFontFactor(double fontFactor) {
    double value = fontFactor.clamp(MIN_FONT_FACTOR, MAX_FONT_FACTOR);
    _settingsBox.put(FONT_FACTOR_KEY, value);
    fontFactorListenable.value = value;
  }
}
