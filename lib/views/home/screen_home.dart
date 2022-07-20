import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/controller/player_controller.dart';
import 'package:chordsic/controller/songs_controller.dart';
import 'package:chordsic/views/playlist/playlistclone.dart';
import 'package:chordsic/views/search/screen_search.dart';
import 'package:chordsic/views/player/mini_player.dart';
import 'package:chordsic/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

import '../search/screen_search.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  SongsController controller = Get.put(SongsController());

  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    PlayerController playcontroller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),

      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Mini_Player>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

      bottomSheet: MiniPlayer(),

      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Appbar>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
      appBar: AppBar(
        title: Text(
          'Library',
          style: GoogleFonts.nunito(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearch(),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 35,
                color: Colors.grey,
              ),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        elevation: 0,
      ),

      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Song_List_Internal>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return item.data!.isEmpty
              ? Center(
                  child: Text(
                    'No songs found!',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                )
              : FutureBuilder<List<FavoritesEntity>>(
                  future: audioRoom.queryFavorites(
                    reverse: false,
                    sortType: null,
                  ),
                  builder: (context, allFavorite) {
                    if (allFavorite.data == null) {
                      return const SizedBox();
                    }
                    List<FavoritesEntity> favorites = allFavorite.data!;
                    List<Audio> favSongs = [];
                    for (var favrSongs in favorites) {
                      favSongs.add(
                        Audio.file(
                          favrSongs.lastData,
                          metas: Metas(
                            title: favrSongs.title,
                            artist: favrSongs.artist,
                            id: favrSongs.id.toString(),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: item.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: Container(
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.3,
                                  blurRadius: 1,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purpleAccent.withOpacity(0.3),
                                  Colors.purpleAccent.withOpacity(0.015),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: Center(
                              child: ListTile(
                                onTap: () async {
                                  await controller.playSong(index);
                                },

                                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Thumb_Titile_Artist>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                                leading: QueryArtworkWidget(
                                  id: item.data![index].id,
                                  type: ArtworkType.AUDIO,

                                  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<If_No_Thumbnail>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    child: Image.asset(
                                      'assets/images/Apple-Music-Artist-Lover.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Songname>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                                title: Text(
                                  item.data![index].title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),

                                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Artist>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                                subtitle: Text(
                                  item.data![index].artist.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  //"${item.data![index].artist}",//
                                  //====This is another way without toString()====//
                                  style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Wrap(
                                  children: [
                                    //
                                    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Favorite>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                                    GetBuilder<SongsController>(
                                      builder: (SongsController controller) {
                                        return FutureBuilder<
                                            List<FavoritesEntity>>(
                                          future:
                                              OnAudioRoom().queryFavorites(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Icon(
                                                Icons.favorite_rounded,
                                                size: 30,
                                                color: Colors.grey,
                                              );
                                            }

                                            List<FavoritesEntity> favorites =
                                                snapshot.data!;

                                            bool isFav = favorites.any(
                                              (element) =>
                                                  element.id ==
                                                  item.data![index].id,
                                            );

                                            return InkWell(
                                              onTap: () async {
                                                if (!isFav) {
                                                  controller.addFav(
                                                    favSongDetails: item
                                                        .data![index].getMap
                                                        .toFavoritesEntity(),
                                                  );

                                                  Get
                                                    ..closeAllSnackbars()
                                                    ..showSnackbar(
                                                      const GetSnackBar(
                                                        //title: "❤",
                                                        duration: Duration(
                                                            seconds: 2),
                                                        icon: Icon(
                                                          Icons
                                                              .favorite_rounded,
                                                          color: Colors.red,
                                                        ),
                                                        message:
                                                            "Added to Favorites!",
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                211, 127, 225),
                                                      ),
                                                    );
                                                } else {
                                                  int favIndex = favorites
                                                      .indexWhere((element) =>
                                                          element.id ==
                                                          item.data![index].id);
                                                  controller.delFav(
                                                      key: favorites[favIndex]
                                                          .key);
                                                  Get
                                                    ..closeAllSnackbars()
                                                    ..showSnackbar(
                                                      const GetSnackBar(
                                                        //title: "Favorite",
                                                        icon: Icon(
                                                          Icons.heart_broken,
                                                          color: Colors.red,
                                                        ),
                                                        message:
                                                            "Removed from Favorites",
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                211, 127, 225),
                                                        duration: Duration(
                                                          seconds: 2,
                                                        ),
                                                      ),
                                                    );
                                                }
                                              },
                                              child: Icon(
                                                Icons.favorite_rounded,
                                                size: 30,
                                                color: isFav
                                                    ? Colors.purpleAccent
                                                    : Colors.grey,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 4),

                                    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<+_Playlist>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                                    InkWell(
                                      onTap: () {
                                        Get.defaultDialog(
                                          backgroundColor: const Color.fromARGB(
                                              255, 211, 127, 225),
                                          title: "",
                                          middleText: "Add to Playlist?",
                                          middleTextStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textCancel: "No",
                                          cancelTextColor: Colors.white,
                                          onCancel: () {
                                            Get.back();
                                          },
                                          textConfirm: "Yes",
                                          buttonColor: const Color.fromARGB(
                                              255, 211, 127, 225),
                                          onConfirm: () {
                                            Get.off(
                                              PlayListClone(
                                                songIndex: index,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.more_vert_rounded,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
