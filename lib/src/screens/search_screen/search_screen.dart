import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyrics/src/blocs/search_song_bloc.dart';
import 'package:flutter_lyrics/src/models/song_search_result.dart';
import 'package:flutter_lyrics/src/screens/lyrics_loader_screen.dart';
import 'package:flutter_lyrics/src/utils/navigation.dart';
import 'package:flutter_lyrics/src/widgets/loading_widget.dart';
import 'package:flutter_lyrics/src/widgets/network_error_widget.dart';
import 'package:lottie/lottie.dart';
import 'songs_search_delegate.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String lastSearchedSong = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchSongBloc, SearchSongBlocState>(
        builder: (context, state) {
          Widget screenWidget;
          if (state is InitialState) {
            screenWidget = _buildInitialWidget();
          } else if (state is LoadingState) {
            screenWidget = _buildLoadingWidget();
          } else if (state is ErrorState) {
            screenWidget = _buildErrorWidget();
          } else if (state is LoadedState) {
            var songsDetails = state.songSearchResult.songsDetails;
            if (songsDetails.isEmpty) {
              screenWidget = _buildNoSongsFoundWidget();
            } else {
              screenWidget = _buildSongsWidgetsList(songsDetails);
            }
          }

          // Disable scroll if user is not in
          // LoadedState and not empty
          bool ableToScroll = state is LoadedState && state.songSearchResult.songsDetails.isNotEmpty;

          return WillPopScope(
            onWillPop: ()async{
              // If user hit back button and has result,clear the result
              // else , pop the screen
              if(state is LoadedState){
                context.read<SearchSongBloc>().add(ClearSearch());
                return false;
              }else{
                return true;
              }
            },
            child: CustomScrollView(
              physics: ableToScroll
                  ? AlwaysScrollableScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              slivers: [
                _buildSliverAppBar(),
                screenWidget,
              ],
            ),
          );
        },
      ),
    );
  }

  void onSearchSubmitted(String query) {
    if (query != null) {
      lastSearchedSong = query;
      context.read<SearchSongBloc>().add(SearchForSong(query));
    }
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      elevation: 4,
      floating: true,
      title: Text(
        "Search",
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () async {
            var searchedSong = await showSearch(
              context: context,
              delegate: SongsSearchDelegate(),
            );
            onSearchSubmitted(searchedSong);
          },
        ),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return SliverFillRemaining(
      child: LoadingWidget(),
    );
  }

  Widget _buildInitialWidget() {
    return SliverFillRemaining(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Lottie.asset(
                  "assets/lottie_animations/4876-speakers-music.json",
                  repeat: true,
                ),
              ),
              Opacity(
                opacity: 0.8,
                child: Text(
                  "Search to get Lyrics :)",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSongClicked(SongDetails songDetails) {
    goToScreen(context, LyricsLoaderScreen(songDetails));
  }

  Widget _buildSongsWidgetsList(List<SongDetails> songsDetails) {
    List<Widget> list = [];
    songsDetails.forEach((e) {
      Widget songWidget = InkWell(
        onTap: () {
          onSongClicked(e);
        },
        child: SongWidget(e),
      );
      list.add(songWidget);
      list.add(Divider());
    });
    return SliverList(
      delegate: SliverChildListDelegate(list),
    );
  }

  Widget _buildNoSongsFoundWidget() {
    return SliverFillRemaining(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie_animations/empty.json",
                  height: MediaQuery.of(context).size.height / 3,
                  repeat: false),
              Opacity(
                opacity: 0.8,
                child: Text(
                  "No Songs Found :(",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    void onRetryClicked() {
      if (lastSearchedSong.isNotEmpty) {
        context.read<SearchSongBloc>().add(SearchForSong(lastSearchedSong));
      }
    }

    return SliverFillRemaining(
      child: NetworkErrorWidget(
        onRetryClicked: onRetryClicked,
      ),
    );
  }
}

class SongWidget extends StatelessWidget {
  final SongDetails songDetails;

  const SongWidget(this.songDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songDetails.songName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    songDetails.singer,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
          )
        ],
      ),
    );
  }
}
