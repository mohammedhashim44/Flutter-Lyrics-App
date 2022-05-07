import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_lyrics/src/models/song_data.dart';
import 'package:flutter_lyrics/src/repositories/saved_songs_repository.dart';
import 'package:flutter_lyrics/src/widgets/app_image.dart';
import 'package:flutter_lyrics/src/widgets/extended_text_widget.dart';

import '../../service_locator.dart';
import 'favorite_icon_widget.dart';

class SongScreen extends StatefulWidget {
  final SongData songData;

  SongScreen(this.songData);

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  Color backgroundColor = Color(0xffea9b4d);
  Color backgroundColorBottom = Color(0xff9b5f22);
  Color lyricsTextColor = Colors.white;
  Color songNameTextColor = Colors.white;
  Color singerNameTextColor = Colors.white;

  bool? savedToFavorites;

  SavedSongsRepository? _savedSongsRepository =
      serviceLocator<SavedSongsRepository>();

  @override
  void initState() {
    super.initState();
    savedToFavorites = _savedSongsRepository!.isSongSaved(widget.songData);
    print(savedToFavorites);
  }

  void setupColors() {
    backgroundColor = Theme.of(context).primaryColor;
    backgroundColorBottom = Theme.of(context).scaffoldBackgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    setupColors();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              backgroundColor,
              backgroundColorBottom,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: _buildHeader(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _buildDescription(),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: _buildLyrics(),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      child: Row(
        children: [
          Hero(
            tag: widget.songData.identifier! + "image",
            child: AppImage(
              widget.songData.image!,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.songData.identifier! + "song_name",
                  child: Text(
                    widget.songData.songTitle!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle1!.apply(
                          color: songNameTextColor,
                        ),
                  ),
                ),
                Hero(
                  tag: widget.songData.identifier! + "singer",
                  child: Text(
                    widget.songData.singer!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle1!.apply(
                          color: singerNameTextColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
          _buildFavoriteWidget()
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return ExtendedTextWidget(
      "Description",
      widget.songData.description ?? "",
      color: lyricsTextColor,
      backgroundColor: backgroundColor,
    );
  }

  Widget _buildLyrics() {
    return Text(
      widget.songData.lyrics ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: lyricsTextColor,
      ),
    );
  }

  Widget _buildFavoriteWidget() {
    return FavoriteIconWidget(savedToFavorites!, () {
      onFloatingButtonClicked(widget.songData);
    });
  }

  void onFloatingButtonClicked(SongData songLyrics) async {
    var savedSongRepo = serviceLocator.get<SavedSongsRepository>();
    if (savedToFavorites!) {
      savedSongRepo.deleteSong(songLyrics);
    } else {
      await savedSongRepo.addNewSong(songLyrics);
    }
    setState(() {
      savedToFavorites = !savedToFavorites!;
    });
  }
}
