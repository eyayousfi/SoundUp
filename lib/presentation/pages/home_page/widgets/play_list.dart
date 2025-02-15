import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptify/common/helpers/is_dark_mode.dart';

import '../../../../common/widgets/button/favorite_button.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../domain/entities/songs/song.dart';
import '../../../song_player/song_player/song_player.dart';
import '../bloc/play_list_cubit.dart';
import '../bloc/play_list_state.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    print('PlayList widget is building');

    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            print('PlayListLoading state');
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if (state is PlayListLoaded) {
            print('PlayListLoaded state');
            print('Number of songs loaded: ${state.songs.length}');

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        'See More',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _songs(state.songs),
                ],
              ),
            );
          }
          print('Default state (no data)');
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    print('Building songs list');
    print('Number of songs in _songs method: ${songs.length}');

    if (songs.isEmpty) {
      print('No songs available');
    } else {
      for (int i = 0; i < songs.length; i++) {
        print('Song ${i + 1}: Title=${songs[i].title}, Artist=${songs[i].artist}, Duration=${songs[i].duration}');
      }
    }

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final song = songs[index];
        print('Building item $index: Title=${song.title}, Artist=${song.artist}, Duration=${song.duration}');

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context)
                    => SongPlayerPage(
                      songEntity: song,
                    )
                )
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode ? AppColors.darkGrey : const Color(0xffE6E6E6),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode ? const Color(0xff959595) : const Color(0xffFF3EA5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        song.artist,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    song.duration.toString().replaceAll('.', ':'),
                  ),
                  const SizedBox(width: 20),
                  FavoriteButton(
                    songEntity: song,
                  )
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: songs.length,
    );
  }
}
