import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptify/presentation/pages/home_page/bloc/play_list_state.dart';

import '../../../../domain/usecases/songs/get_play_list.dart';
import '../../../../service_locator.dart';


class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    try {
      print('Fetching playlist...'); // Debug print before fetching
      var returnedSongs = await sl<GetPlayListUseCase>().call();
      print('Fetch complete'); // Debug print after fetch

      returnedSongs.fold(
            (failure) {
          print('Failed to fetch playlist: $failure'); // Debug print on failure
          emit(PlayListLoadFailure());
        },
            (data) {
          print('Fetched playlist successfully: $data'); // Debug print on success
          emit(PlayListLoaded(songs: data));
        },
      );
    } catch (e) {
      print('Exception occurred while fetching playlist: $e'); // Debug print for exceptions
      emit(PlayListLoadFailure());
    }
  }
}
