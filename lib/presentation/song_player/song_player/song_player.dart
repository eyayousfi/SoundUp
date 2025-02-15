import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/favorite_button.dart';
import '../../../core/configs/constants/app_Urls.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/songs/song.dart';
import '../bloc/song_player_cubit.dart';
import '../bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    required this.songEntity,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(

        action: IconButton(
            onPressed: (){},
            icon: const Icon(
                Icons.more_vert_rounded
            )
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: -88 ,
            right: -80,
            child: Container(
              height: 166,
              width: 166,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.purple,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 500, sigmaY: 500),
                child: Container(
                  height: 200,
                  width: 200,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.pink,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 500, sigmaY: 500),
                child: Container(
                  height: 200,
                  width: 200,
                ),
              ),
            ),
          ),
          // Main content
          BlocProvider(
            create: (_) => SongPlayerCubit()..loadSong(
                '${AppURLs.songFirestorage}${songEntity.artist}%20${songEntity.title}.mp3?${AppURLs.mediaAlt}'
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _songCover(context),
                  const SizedBox(height: 150),
                  _songDetail(),
                  const SizedBox(height: 30),
                  _songPlayer(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppURLs.coverFirestorage}${songEntity.artist}.jpg?${AppURLs.mediaAlt}',
          ),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              songEntity.artist,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
        FavoriteButton(
          songEntity: songEntity,
        ),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(context.read<SongPlayerCubit>().songPosition),
                  ),
                  Text(
                    formatDuration(context.read<SongPlayerCubit>().songDuration),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Previous song functionality to be implemented
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.pink,
                      ),
                      child: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<SongPlayerCubit>().playOrPauseSong();
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.pink,
                      ),
                      child: Icon(
                        context.read<SongPlayerCubit>().audioPlayer.playing
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Next song functionality to be implemented
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.pink,
                      ),
                      child: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
