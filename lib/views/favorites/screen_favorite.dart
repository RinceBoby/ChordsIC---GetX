// ignore_for_file: file_names

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/controller/favorite_controller.dart';
import 'package:chordsic/views/player/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class Favorite extends StatelessWidget {
  Favorite({Key? key}) : super(key: key);
  FavoriteController favoriteController = Get.put(FavoriteController());

  List<Audio> favSongs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),

      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Mini_Player>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
      bottomSheet: MiniPlayer(),

      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Appbar>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        elevation: 0,
        title: Text(
          'Favorites',
          style: GoogleFonts.nunito(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          //<<<<<Delete>>>>>//
          IconButton(
            onPressed: () => Get.defaultDialog(
              backgroundColor: const Color.fromARGB(255, 212, 167, 220),
              title: "Delete Favorites!",
              middleText: "You want to delete all favourites?",
              middleTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textCancel: "No",
              onCancel: () {
                Get.back();
              },
              textConfirm: "Yes",
              onConfirm: () {
                favoriteController.delAllFav();
                Get.back();
              },
              buttonColor: Colors.green,
            ),
            // showDialog<String>(
            //   context: context,
            //   builder: (BuildContext context) => AlertDialog(
            //     backgroundColor: const Color.fromARGB(255, 212, 167, 220),
            //     content: Text(
            //       'All favorites will be deleted',
            //       style: GoogleFonts.dmSans(color: Colors.black),
            //     ),
            //     actions: <Widget>[
            //       TextButton(
            //         onPressed: () => Navigator.pop(context, 'Cancel'),
            //         child: Text(
            //           'Cancel',
            //           style: GoogleFonts.nunito(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ),
            //       TextButton(
            //         onPressed: () async {
            //           await audioRoom.clearRoom(RoomType.FAVORITES);
            //           //setState(() {});
            //           Navigator.pop(context, 'OK');
            //         },
            //         child: Text(
            //           'Ok',
            //           style: GoogleFonts.nunito(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            icon: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
          ),
        ],
      ),

      //<<<<<Body>>>>>//
      body: Center(
        child: GetBuilder<FavoriteController>(
            init: FavoriteController(),
            builder: (controller) {
              return FutureBuilder<List<FavoritesEntity>>(
                future: OnAudioRoom().queryFavorites(
                  limit: 50,
                  reverse: false,
                  sortType: null, //  Null will use the [key] has sort.
                ),
                builder: (context, item) {
                  if (item.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (item.data!.isEmpty) {
                    return Text(
                      "No Favorites found!",
                      style: GoogleFonts.raleway(color: Colors.black),
                    );
                  }

                  List<FavoritesEntity> favorites = item.data!;

                  List<Audio> favSongsList = [];

                  for (var songs in favorites) {
                    favSongsList.add(
                      Audio.file(
                        songs.lastData,
                        metas: Metas(
                          title: songs.title,
                          artist: songs.artist,
                          id: songs.id.toString(),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
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
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ListTile(
                              onLongPress: () {
                                Get.defaultDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 244, 184, 255),
                                  title: "Remove from Favorites!",
                                  middleText: "Are you sure?",
                                  middleTextStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textCancel: "No",
                                  onCancel: () {
                                    Get.back();
                                  },
                                  textConfirm: "Yes",
                                  onConfirm: () {
                                    favoriteController.delFav(
                                        favorites: favorites, index: index);
                                    Get.back();
                                  },
                                  buttonColor: Colors.green,
                                );
                                // showDialog<String>(
                                //   barrierColor: Colors.transparent,
                                //   context: context,
                                //   builder: (BuildContext context) => AlertDialog(
                                //     backgroundColor:
                                //         const Color.fromARGB(255, 244, 184, 255),
                                //     content: Text(
                                //       "Remove from Favorites?",
                                //       style: GoogleFonts.nunito(
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.w600,
                                //         color: Colors.black,
                                //       ),
                                //     ),
                                //     actions: <Widget>[
                                //       TextButton(
                                //         onPressed: () =>
                                //             Navigator.pop(context, 'Cancel'),
                                //         child: Text(
                                //           "Cancel",
                                //           style: GoogleFonts.nunito(
                                //             fontSize: 20,
                                //             fontWeight: FontWeight.w600,
                                //             color: Colors.black,
                                //           ),
                                //         ),
                                //       ),
                                //       TextButton(
                                //         onPressed: () async {
                                //           await audioRoom.deleteFrom(
                                //             RoomType.FAVORITES,
                                //             favorites[index].key,
                                //           );
                                //           setState(() {});
                                //           Navigator.pop(context, 'OK');
                                //         },
                                //         child: Text(
                                //           "Ok",
                                //           style: GoogleFonts.nunito(
                                //             fontSize: 20,
                                //             fontWeight: FontWeight.w600,
                                //             color: Colors.black,
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // );
                              },
                              textColor: Colors.black,
                              iconColor: Colors.grey,
                              leading: SizedBox(
                                height: 60,
                                width: 60,
                                child: QueryArtworkWidget(
                                  id: item.data![index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    child: Image.asset(
                                      'assets/images/Apple-Music-Artist-Lover.png',
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                favorites[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
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
                              onTap: () {
                                favoriteController.playOnTap(
                                  favSongsList: favSongsList,
                                  index: index,
                                );
                              },
                              // async {
                              //   await player.open(
                              //     Playlist(
                              //         audios: favSongsList, startIndex: index),
                              //     showNotification: true,
                              //     loopMode: LoopMode.playlist,
                              //     notificationSettings:
                              //         const NotificationSettings(
                              //             stopEnabled: false),
                              //   );
                              // },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}
