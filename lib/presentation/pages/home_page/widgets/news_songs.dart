import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptify/common/helpers/is_dark_mode.dart';

import '../../../../core/configs/constants/app_Urls.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../domain/entities/songs/song.dart';
import '../bloc/news_songs_cubit.dart';
import '../bloc/news_songs_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    print("NewsSongs widget is called");

    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
          height: 200,
          child: BlocBuilder<NewsSongsCubit,NewsSongsState>(
            builder: (context,state) {
              if (state is NewsSongsLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()
                );
              }

              if (state is NewsSongsLoaded) {
                return _songs(
                    state.songs
                );
              }

              return Container();
            },
          )

      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context,index) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context)
              //         => SongPlayerPage(
              //           songEntity: songs[index],
              //         )
              //     )
              // );
            },
            child: SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${AppURLs.coverFirestorage}${songs[index].artist}.jpg?${AppURLs.mediaAlt}'
                              )
                          )
                      ),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    songs[index].title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ) ,
                  const SizedBox(height: 5,),
                  Text(
                    songs[index].artist,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context,index) => const SizedBox(width: 14,),
        itemCount: songs.length
    );
  }
}