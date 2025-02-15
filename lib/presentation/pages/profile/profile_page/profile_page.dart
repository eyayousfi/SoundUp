import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptify/common/helpers/is_dark_mode.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/button/favorite_button.dart';
import '../../../../core/configs/constants/app_Urls.dart';
import '../../../song_player/song_player/song_player.dart';
import '../../mode/choose_mode.dart';
import '../bloc/favorite_songs_cubit.dart';
import '../bloc/favorite_songs_state.dart';
import '../bloc/profile_info_cubit.dart';
import '../bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
        title: const Text('Profile'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.settings,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onSelected: (value) {
              if (value == 'change_mode') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ChooseModePage(),
                  ),
                );
              } else if (value == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'change_mode',
                child: ListTile(
                  leading: Icon(
                    Icons.mode_night,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  title: Text('Change Mode'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          const SizedBox(height: 30),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }
            if (state is ProfileInfoLoaded) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(state.userEntity.imageURL!),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.userEntity.email!,
                        style: TextStyle(
                          color: context.isDarkMode ? Colors.white70 : Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.userEntity.fullName!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            if (state is ProfileInfoFailure) {
              return Center(
                child: const Text(
                  'Failed to load profile. Please try again.',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAVORITE SONGS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
                }
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final song = state.favoriteSongs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SongPlayerPage(
                                songEntity: song,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${AppURLs.coverFirestorage}${song.artist}.jpg?${AppURLs.mediaAlt}',

                                      ),
                                      fit: BoxFit.cover,
                                    ),
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
                                        fontSize: 12,
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
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 20),
                                FavoriteButton(
                                  songEntity: song,
                                  key: UniqueKey(),
                                  function: () {
                                    context.read<FavoriteSongsCubit>().removeSong(index);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemCount: state.favoriteSongs.length,
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return Center(
                    child: const Text(
                      'Failed to load favorite songs. Please try again.',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    // Implement your logout logic here
    Navigator.pushReplacementNamed(context, '/login'); // Replace '/login' with your actual login route
  }
}
