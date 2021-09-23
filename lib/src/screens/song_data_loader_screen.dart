import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyrics/src/blocs/fetch_song_data_bloc.dart';
import 'package:flutter_lyrics/src/models/song_data.dart';
import 'package:flutter_lyrics/src/models/song_search_result.dart';
import 'package:flutter_lyrics/src/repositories/songs_repository.dart';
import 'package:flutter_lyrics/src/screens/song_screen/song_screen.dart';
import 'package:flutter_lyrics/src/widgets/app_image.dart';
import 'package:flutter_lyrics/src/widgets/extended_text_widget.dart';
import 'package:flutter_lyrics/src/widgets/loading_widget.dart';

import 'package:flutter_lyrics/src/widgets/network_error_widget.dart';

class SongDataLoaderScreen extends StatelessWidget {
  final SongDetails songDetails;

  const SongDataLoaderScreen(this.songDetails) : assert(songDetails != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            FetchSongDataBloc()..add(FetchSongData(songDetails.identifier)),
        child: SongDataScreenBuilder(songDetails),
      ),
    );
  }
}

class SongDataScreenBuilder extends StatefulWidget {
  final SongDetails songDetails;

  SongDataScreenBuilder(this.songDetails);

  @override
  _SongDataScreenBuilderState createState() => _SongDataScreenBuilderState();
}

class _SongDataScreenBuilderState extends State<SongDataScreenBuilder> {
  bool savedToFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSongDataBloc, FetchSongDataBlocState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              switchInCurve: Curves.ease,
              reverseDuration: Duration(seconds: 1),
              switchOutCurve: Curves.ease,
              child: _buildScreen(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScreen(FetchSongDataBlocState state) {
    Widget screen;

    screen = Container();
    if (state is LoadingState) {
      screen = _buildLoadingWidget();
    } else if (state is ErrorState) {
      screen = _buildErrorWidget(context);
    } else if (state is LoadedState) {
      screen = _buildLoadedWidget(state.songData);
    }

    return screen;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          child: songHeaderWidget(),
        ),
        Expanded(
          child: screen,
        ),
      ],
    );
    return screen;
  }

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }

  Widget _buildErrorWidget(BuildContext context) {
    void onRetryClicked() {
      context
          .read<FetchSongDataBloc>()
          .add(FetchSongData(widget.songDetails.identifier));
    }

    return NetworkErrorWidget(
      onRetryClicked: onRetryClicked,
    );
  }

  Widget songHeaderWidget() {
    return Row(
      children: [
        Hero(
          tag: widget.songDetails.identifier,
          child: AppImage(
            widget.songDetails.songImage,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.songDetails.songName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                widget.songDetails.singer,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1.apply(
                      color: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .color
                          .withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadedWidget(SongData songData) {
    return SongScreen(songData);
  }

  Widget getLyricsWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExtendedTextWidget(
            "Description",
            fakeDescription,
          ),
        ],
      ),
    );
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: Text(
        perfectLyrics,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class SongDescription extends StatefulWidget {
  final String description;

  const SongDescription(this.description);

  @override
  _SongDescriptionState createState() => _SongDescriptionState();
}

class _SongDescriptionState extends State<SongDescription>
    with TickerProviderStateMixin {
  bool visible = true;
  Color color = Colors.red;
  double size = 100;

  void toggle() {
    setState(() {
      print("A");
      visible = !visible;
      color = visible ? Colors.red : Colors.greenAccent;
      size = visible ? 100 : 500;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      color: visible ? Colors.blue : Colors.red,
      child: InkWell(
        onTap: toggle,
        child: AnimatedSize(
          duration: Duration(seconds: 2),
          curve: Curves.easeIn,
          vsync: this,
          child: SizedBox(width: 100, height: size),
        ),
      ),
    );
    return AnimatedContainer(
      duration: Duration(seconds: 5),
      child: Container(
        color: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: GestureDetector(
                onTap: toggle,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Description"),
                    Icon(
                      visible ? Icons.arrow_drop_down : Icons.arrow_right_sharp,
                    )
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 5),
              color: Colors.red,
              child: Text(
                visible ? fakeDescription : "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SongLyrics extends StatefulWidget {
  final String lyrics;

  const SongLyrics(this.lyrics, {Key key}) : super(key: key);

  @override
  _SongLyricsState createState() => _SongLyricsState();
}

class _SongLyricsState extends State<SongLyrics> {
  bool visible = true;

  void toggle() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: GestureDetector(
              onTap: toggle,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Lyrics"),
                  Icon(
                    visible ? Icons.arrow_drop_down : Icons.arrow_right_sharp,
                  )
                ],
              ),
            ),
          ),
          if (visible)
            Text(
              perfectLyrics,
            ),
        ],
      ),
    );
  }
}

String fakeDescription = """
In \u201chappier,\u201d Olivia wishes the best for an ex-lover and their new relationship, but simultaneously hopes to remain a significant memory in their life.\n\nThe whole album of SOUR centers on the loss of a lover (in Rodrigo\u2019s case, speculated to be about losing Joshua Bassett to Sabrina Carpenter). From the scathing \u201cgood 4 u,\u201d to the bitter \u201cdeja vu,\u201d headed up by the heartbreaking \u201cdrivers license\u201d the album is full of songs allegedly directed at Bassett, revealing Rodrigo\u2019s heartbreak in him leaving her. By the eighth track, Rodrigo starts to accept the fact that even though she wants him back it is doubtful it will happen. Rodrigo wants him to know that even though she is letting him go, she wants him to remember that she was the best he could ever get.\n\nOlivia first teased the song on Instagram on January 13, 2020, by posting an acoustic snippet with the caption: \u201cshe do be writing doe. \u2018happier\u2019 by me!\u201d
""";
