import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyrics/src/models/song_data.dart';
import 'package:flutter_lyrics/src/models/song_search_result.dart';
import 'package:flutter_lyrics/src/repositories/saved_songs_repository.dart';
import 'package:flutter_lyrics/src/screens/search_screen/song_list_item_widget.dart';
import 'package:flutter_lyrics/src/screens/song_screen/song_screen.dart';
import 'package:flutter_lyrics/src/service_locator.dart';
import 'package:flutter_lyrics/src/utils/navigation.dart';

class SavedSongsScreen extends StatefulWidget {
  @override
  _SavedSongsScreenState createState() => _SavedSongsScreenState();
}

class _SavedSongsScreenState extends State<SavedSongsScreen> {
  late List<SongData> songs;

  @override
  void initState() {
    super.initState();
    updateSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Saved Songs: ${songs.length}"),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            if (songs.isEmpty) {
              return _buildNoSavedSongsWidget();
            }
            return _buildSavedSongsWidget();
          },
        ),
      ),
    );
  }

  Widget _buildNoSavedSongsWidget() {
    return Column(
      children: [
        Spacer(),
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: FlareActor(
            "assets/flare_animations/sad_face.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "idle",
          ),
        ),
        Opacity(
          opacity: 0.8,
          child: Text(
            "No Saved Songs",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildSavedSongsWidget() {
    return ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          var song = songs[index];
          return InkWell(
            onTap: () {
              onSongClicked(song);
            },
            child: getItemWidget(song, context),
          );
        });
  }

  void updateSongs() {
    var savedSongsRepo = serviceLocator.get<SavedSongsRepository>();
    songs = savedSongsRepo.getSavedSongs();
  }

  Widget getItemWidget(SongData songData, BuildContext context) {
    return SongListItemWidget(SongDetails.fromSongData(songData));
  }

  void onSongClicked(SongData songLyrics) {
    goToScreen(context, SongScreen(songLyrics), onReturn: onScreenPoped);
  }

  void onScreenPoped() {
    setState(() {
      updateSongs();
    });
  }
}
