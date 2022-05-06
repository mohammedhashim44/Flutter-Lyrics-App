import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyrics/src/blocs/fetch_song_data_bloc.dart';
import 'package:flutter_lyrics/src/models/song_data.dart';
import 'package:flutter_lyrics/src/models/song_search_result.dart';
import 'package:flutter_lyrics/src/screens/song_screen/song_screen.dart';
import 'package:flutter_lyrics/src/widgets/loading_widget.dart';

import 'package:flutter_lyrics/src/widgets/network_error_widget.dart';

class SongDataLoaderScreen extends StatelessWidget {
  final SongDetails songDetails;

  const SongDataLoaderScreen(this.songDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FetchSongDataBloc()
          ..add(
            FetchSongData(songDetails.identifier!),
          ),
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
  }

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }

  Widget _buildErrorWidget(BuildContext context) {
    void onRetryClicked() {
      context.read<FetchSongDataBloc>().add(
            FetchSongData(widget.songDetails.identifier!),
          );
    }

    return NetworkErrorWidget(
      onRetryClicked: onRetryClicked,
    );
  }

  Widget _buildLoadedWidget(SongData songData) {
    return SongScreen(songData);
  }
}
