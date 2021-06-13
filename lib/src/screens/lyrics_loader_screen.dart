import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyrics/src/blocs/fetch_lyrics_bloc.dart';
import 'package:flutter_lyrics/src/models/song_lyrics.dart';
import 'package:flutter_lyrics/src/models/song_search_result.dart';
import 'package:flutter_lyrics/src/widgets/loading_widget.dart';

import 'package:flutter_lyrics/src/widgets/network_error_widget.dart';
import 'package:flutter_lyrics/src/screens/lyrics_screen/lyrics_screen.dart';

class LyricsLoaderScreen extends StatelessWidget {
  final SongDetails songDetails;

  const LyricsLoaderScreen(this.songDetails) : assert(songDetails != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            FetchLyricsBloc()..add(FetchLyric(songDetails.link)),
        child: LyricsLoaderScreenBuilder(songDetails),
      ),
    );
  }
}

class LyricsLoaderScreenBuilder extends StatefulWidget {
  final SongDetails songDetails;

  LyricsLoaderScreenBuilder(this.songDetails);

  @override
  _LyricsLoaderScreenBuilderState createState() =>
      _LyricsLoaderScreenBuilderState();
}

class _LyricsLoaderScreenBuilderState extends State<LyricsLoaderScreenBuilder> {
  bool savedToFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchLyricsBloc, FetchLyricsBlocState>(
      builder: (context, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: Duration(seconds: 1),
            switchInCurve: Curves.ease,
            reverseDuration: Duration(seconds: 1),
            switchOutCurve: Curves.ease,
            child: _buildScreen(state),
          ),
        );
      },
    );
  }

  Widget _buildScreen(FetchLyricsBlocState state) {
    Widget screen;

    screen = Container();
    if (state is LoadingState) {
      screen = _buildLoadingWidget();
    } else if (state is ErrorState) {
      screen = _buildErrorWidget(context);
    } else if (state is LoadedState) {
      screen = _buildLoadedWidget(state.songLyrics);
    }
    return screen;
  }

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }

  Widget _buildErrorWidget(BuildContext context) {
    void onRetryClicked() {
      context.read<FetchLyricsBloc>().add(FetchLyric(widget.songDetails.link));
    }

    return NetworkErrorWidget(
      onRetryClicked: onRetryClicked,
    );
  }

  Widget _buildLoadedWidget(SongLyrics songLyrics) {
    return LyricsScreen(songLyrics);
  }
}
