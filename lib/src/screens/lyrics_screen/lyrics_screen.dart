import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_lyrics/src/models/song_lyrics.dart';
import 'package:flutter_lyrics/src/repositories/saved_songs_repository.dart';

import '../../service_locator.dart';
import 'favorite_icon_widget.dart';
import 'lyrics_text_widget.dart';

class LyricsScreen extends StatefulWidget {
  final SongLyrics songLyrics;

  LyricsScreen(this.songLyrics);

  @override
  _LyricsScreenState createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  ScrollController _scrollController;

  bool savedToFavorites;
  bool showFAB = true;

  SavedSongsRepository _savedSongsRepository =
      serviceLocator<SavedSongsRepository>();

  @override
  void initState() {
    super.initState();

    savedToFavorites = _savedSongsRepository.isSongSaved(widget.songLyrics);
    print(savedToFavorites);

    _scrollController = ScrollController();
    _scrollController.addListener(onPageScrolled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.songLyrics.songTitle),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedOpacity(
            opacity: showFAB ? 1 : 0,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: FavoriteIconWidget(savedToFavorites, () {
              onFloatingButtonClicked(widget.songLyrics);
            }),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: LyricsTextWidget(widget.songLyrics.lyrics),
        ),
      ),
    );
  }

  void onFloatingButtonClicked(SongLyrics songLyrics) async {
    if (!showFAB) return;
    var savedSongRepo = serviceLocator.get<SavedSongsRepository>();
    if (savedToFavorites) {
      savedSongRepo.deleteSong(songLyrics);
    } else {
      await savedSongRepo.addNewSong(songLyrics);
    }
    setState(() {
      savedToFavorites = !savedToFavorites;
    });
  }

  void onPageScrolled() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!showFAB) {
        setState(() {
          showFAB = true;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (showFAB) {
        setState(() {
          showFAB = false;
        });
      }
    }
  }
}

