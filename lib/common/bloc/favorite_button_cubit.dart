import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/songs/add_or_remove_favorite.dart';
import '../../service_locator.dart';
import 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {

  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdated(String songId) async {

    var result = await sl<AddOrRemoveFavoriteSongUseCase>().call(
        params: songId
    );
    result.fold(
          (l){},
          (isFavorite){
        emit(
            FavoriteButtonUpdated(
                isFavorite: isFavorite
            )
        );
      },
    );
  }
}