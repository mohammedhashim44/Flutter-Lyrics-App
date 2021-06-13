import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyrics/src/models/song_lyrics.dart';
import 'package:flutter_lyrics/src/models/song_search_result.dart';
import 'package:flutter_lyrics/src/repositories/songs_repository.dart';
import 'package:flutter_lyrics/src/service_locator.dart';

class FetchLyricsBlocEvent {}

class FetchLyric extends FetchLyricsBlocEvent {
  final String link;

  FetchLyric(this.link);
}

class FetchLyricsBlocState {}

class InitialState extends FetchLyricsBlocState {}

class LoadingState extends FetchLyricsBlocState {}

class LoadedState extends FetchLyricsBlocState {
  final SongLyrics songLyrics;

  LoadedState(this.songLyrics);
}

class ErrorState extends FetchLyricsBlocState {}

class FetchLyricsBloc extends Bloc<FetchLyricsBlocEvent, FetchLyricsBlocState> {
  FetchLyricsBloc() : super(InitialState());

  SongsRepository _lyricsRepository = serviceLocator.get<SongsRepository>();

  @override
  Stream<FetchLyricsBlocState> mapEventToState(
      FetchLyricsBlocEvent event) async* {
    if (event is FetchLyric) {
      yield* _mapSearchEventToState(event);
    }
  }

  Stream<FetchLyricsBlocState> _mapSearchEventToState(
      FetchLyric event) async* {
    yield LoadingState();
    try {
      var songLyrics = await  _lyricsRepository.fetchLyricsFromLink(event.link);
      yield LoadedState(songLyrics);
    } catch (e) {
      print(e);
      yield ErrorState();
    }
  }
}
