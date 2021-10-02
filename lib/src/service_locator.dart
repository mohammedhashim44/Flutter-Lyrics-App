import 'package:flutter_lyrics/src/repositories/local_storage_repository.dart';
import 'package:flutter_lyrics/src/repositories/songs_repository.dart';
import 'package:flutter_lyrics/src/repositories/saved_songs_repository.dart';
import 'package:get_it/get_it.dart';

Future<void> setupServiceLocator() async {
  LocalStorageRepository localStorageRepository = LocalStorageRepository();
  await localStorageRepository.init();
  serviceLocator
      .registerSingleton<LocalStorageRepository>(localStorageRepository);

  serviceLocator.registerSingleton<SongsRepository>(APISongsRepository());

  serviceLocator.registerSingleton<SavedSongsRepository>(
    SavedSongsRepository(serviceLocator.get<LocalStorageRepository>()),
  );
}

final serviceLocator = GetIt.instance;
