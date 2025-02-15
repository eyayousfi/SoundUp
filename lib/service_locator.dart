
import 'package:get_it/get_it.dart';
import 'package:sptify/domain/usecases/auth/auth.dart';
import 'package:sptify/domain/usecases/auth/signin.dart';

import 'data/repository/auth/auth_repository_implementation.dart';
import 'data/repository/songs/song_repository_impl.dart';
import 'data/sources/auth/auth_firebase_service.dart';
import 'data/sources/songs/song_firestore_service.dart';
import 'domain/repository/auth/auth.dart';
import 'domain/repository/songs/song.dart';
import 'domain/usecases/auth/get_user.dart';
import 'domain/usecases/songs/add_or_remove_favorite.dart';
import 'domain/usecases/songs/get_favorite_songs.dart';
import 'domain/usecases/songs/get_new_song.dart';
import 'domain/usecases/songs/get_play_list.dart';
import 'domain/usecases/songs/is_favorite_song.dart';
final sl = GetIt.instance ;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImpl()
  );




  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );


  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );
  sl.registerSingleton<SigninUseCase>(
      SigninUseCase()
  );

  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImpl()
  );


  sl.registerSingleton<GetNewsSongsUseCase>(
      GetNewsSongsUseCase()
  );

  sl.registerSingleton<SongsRepository>(
      SongRepositoryImpl()
  );
  sl.registerSingleton<GetPlayListUseCase>(
      GetPlayListUseCase()
  );

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase()
  );

  sl.registerSingleton<IsFavoriteSongUseCase>(
      IsFavoriteSongUseCase()
  );

  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );

  sl.registerSingleton<GetFavoriteSongsUseCase>(
      GetFavoriteSongsUseCase()
  );

}
