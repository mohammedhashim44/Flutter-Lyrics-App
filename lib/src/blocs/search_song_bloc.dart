import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyrics/src/models/song_search_result.dart';
import 'package:flutter_lyrics/src/repositories/songs_repository.dart';
import 'package:flutter_lyrics/src/service_locator.dart';

class SearchSongBlocEvent {}

class SearchForSong extends SearchSongBlocEvent {
  final String songName;

  SearchForSong(this.songName);
}

class SearchSongBlocState {}

class InitialState extends SearchSongBlocState {}

class LoadingState extends SearchSongBlocState {}

class LoadedState extends SearchSongBlocState {
  final SongSearchResult songSearchResult;

  LoadedState(this.songSearchResult);
}

class ErrorState extends SearchSongBlocState {}

class SearchSongBloc extends Bloc<SearchSongBlocEvent, SearchSongBlocState> {
  SearchSongBloc() : super(InitialState());

  SongsRepository _lyricsRepository = serviceLocator.get<SongsRepository>();

  @override
  Stream<SearchSongBlocState> mapEventToState(
      SearchSongBlocEvent event) async* {
    if (event is SearchForSong) {
      yield* _mapSearchEventToState(event);
    }
  }

  Stream<SearchSongBlocState> _mapSearchEventToState(
      SearchForSong event) async* {
    yield LoadingState();
    try {
      SongSearchResult songSearchResult =
          await _lyricsRepository.getSearchResults(event.songName);

      yield LoadedState(songSearchResult);
    } catch (e) {
      print(e);
      yield ErrorState();
    }
  }
}
