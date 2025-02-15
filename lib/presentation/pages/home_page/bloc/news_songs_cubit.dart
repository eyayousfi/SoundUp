import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/songs/get_new_song.dart';
import '../../../../service_locator.dart';
import 'news_songs_state.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {

  NewsSongsCubit() : super(NewsSongsLoading());

  Future < void > getNewsSongs() async {
    print('Fetching new songs...');

    var returnedSongs = await sl < GetNewsSongsUseCase > ().call();
    print('Songs fetched: $returnedSongs');

    returnedSongs.fold(

            (l) {
          emit(NewsSongsLoadFailure());
        },
            (data) {
          emit(
              NewsSongsLoaded(songs: data)
          );
        }
    );
  }


}