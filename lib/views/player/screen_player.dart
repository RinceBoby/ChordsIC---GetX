// ignore_for_file: file_names
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/controller/player_controller.dart';
import 'package:chordsic/views/player/widgets/fact_player.dart';
import 'package:chordsic/views/playlist/playlistclone.dart';
import 'package:chordsic/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class Player extends StatelessWidget {
  Player({Key? key}) : super(key: key);

  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),

      //<<<<<Appbar>>>>>//
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        elevation: 0,

        //<<<<<Heading>>>>>//
        title: Text(
          'Now Playing',
          style: GoogleFonts.nunito(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      //<<<<<Body>>>>>//

      body: GetBuilder<PlayerController>(
        init: PlayerController(),
        builder: (controller) {
          return player.builderCurrent(
            builder: (context, playing) {
              return FutureBuilder<List<FavoritesEntity>>(
                future: audioRoom.queryFavorites(
                  //limit: 50,
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
                  int currentIndex = playing.index;
                  bool isFav = false;
                  int? key;
                  for (var fav in favorites) {
                    if (songDetails[currentIndex].metas.title == fav.title) {
                      isFav = true;
                      key = fav.key;
                    }
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      //<<<<<Thumbnail>>>>>//
                      Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(250)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                spreadRadius: 0.3,
                                blurRadius: 5,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: QueryArtworkWidget(
                            artworkQuality: FilterQuality.high,
                            quality: 100,
                            size: 2000,
                            artworkFit: BoxFit.contain,
                            artworkBorder: BorderRadius.circular(250),
                            id: int.parse(
                                playing.audio.audio.metas.id.toString()),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(250),
                              ),
                              child: Image.asset(
                                'assets/images/Apple-Music-Artist-Lover.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //<<<<<Title_&_Artist>>>>>//
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 300,
                            child: Marquee(
                              blankSpace: 20,
                              velocity: 20,
                              text: player.getCurrentAudioTitle,
                              style: GoogleFonts.nunito(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 150,
                            child: Marquee(
                              blankSpace: 20,
                              velocity: 20,
                              text: player.getCurrentAudioArtist,
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 0,
                      ),

                      //<<<<<+_Pl_&_Fav>>>>>//
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                        child: Row(
                          children: [
                            //<<<<<Playlist>>>>>//
                            IconButton(
                              onPressed: () async {
                                Navigator.pop(context, 'Yes');
                                Get.to(PlayListClone(songIndex: currentIndex));
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => PlayListClone(
                                //       songIndex: currentIndex,
                                //     ),
                                //   ),
                                // );
                                //setState(() {});
                              },
                              icon: const Icon(Icons.playlist_add_rounded),
                              color: Colors.purpleAccent,
                              iconSize: 35,
                            ),
                            const Spacer(),

                            //<<<<<Favorites>>>>>//
                            IconButton(
                              onPressed: () {
                                if (!isFav) {
                                  Get
                                    ..closeAllSnackbars()
                                    ..showSnackbar(
                                      const GetSnackBar(
                                        duration: Duration(seconds: 2),
                                        backgroundColor:
                                            Color.fromARGB(255, 211, 127, 225),
                                        icon: Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.red,
                                        ),
                                        message: "Added to Favorites!",
                                      ),
                                    );
                                  controller.addFavPlayer(
                                      currentIndex: currentIndex);
                                  // ScaffoldMessenger.of(context)
                                  //   ..removeCurrentSnackBar()
                                  //   ..showSnackBar(
                                  //     SnackBar(
                                  // backgroundColor: const Color.fromARGB(
                                  //     255, 211, 127, 225),
                                  //       content: Text(
                                  //         "Added to Favorites!",
                                  //         style: GoogleFonts.nunito(
                                  //           fontSize: 15,
                                  //           fontWeight: FontWeight.w600,
                                  //           color: Colors.black,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   );
                                  // audioRoom.addTo(
                                  //   RoomType.FAVORITES, //Specify Room Type
                                  //   allSongs[currentIndex]
                                  //       .getMap
                                  //       .toFavoritesEntity(),
                                  //   ignoreDuplicate: false, //Avoid Same Song
                                  // );
                                } else {
                                  Get
                                    ..closeAllSnackbars()
                                    ..showSnackbar(
                                      const GetSnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 211, 127, 225),
                                        duration: Duration(seconds: 2),
                                        icon: Icon(
                                          Icons.heart_broken,
                                          color: Colors.red,
                                        ),
                                        message: "Removed From Favorites!",
                                      ),
                                    );
                                  controller.delFavPlayer(key: key);
                                  // ScaffoldMessenger.of(context)
                                  //   ..removeCurrentSnackBar()
                                  //   ..showSnackBar(
                                  //     SnackBar(
                                  //       backgroundColor: const Color.fromARGB(
                                  //           255, 211, 127, 225),
                                  //       content: Text(
                                  //         "Removed From Favorites!",
                                  //         style: GoogleFonts.nunito(
                                  //           fontSize: 15,
                                  //           fontWeight: FontWeight.w600,
                                  //           color: Colors.black,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   );
                                  // audioRoom.deleteFrom(
                                  //   RoomType.FAVORITES,
                                  //   key!,
                                  // );
                                  // setState(() {});
                                }
                                //setState(() {});
                              },
                              icon: const Icon(FontAwesomeIcons.solidHeart),
                              color: isFav ? Colors.purpleAccent : Colors.grey,
                              iconSize: 30,
                            ),
                          ],
                        ),
                      ),

                      //<<<<<Progress_Bar>>>>>//
                      const Padding(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 0),
                        child: SeekBar(),
                      ),

                      //<<<<<Player_Controls>>>>>//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //<<<<<Shuffle>>>>>//
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.shuffle),
                            iconSize: 25,
                            color: Colors.purpleAccent,
                          ),

                          //<<<<<Previous>>>>>//
                          IconButton(
                            onPressed: playing.index != 0
                                ? () {
                                    player.previous();
                                  }
                                : () {},
                            icon: playing.index == 0
                                ? Icon(
                                    FontAwesomeIcons.backward,
                                    size: 40,
                                    color: Colors.purple[100],
                                  )
                                : const Icon(
                                    FontAwesomeIcons.backward,
                                    size: 40,
                                    color: Colors.purpleAccent,
                                  ),
                          ),
                          const SizedBox(width: 8),

                          //<<<<<Play_Pause>>>>>//
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: PlayerBuilder.isPlaying(
                              player: player,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  icon: Icon(
                                    isPlaying
                                        ? FontAwesomeIcons.solidCirclePause
                                        : FontAwesomeIcons.solidCirclePlay,
                                    size: 80,
                                  ),
                                  onPressed: () {
                                    player.playOrPause();
                                  },
                                  color: Colors.purpleAccent,
                                );
                              },
                            ),
                          ),

                          //<<<<<Next>>>>>//
                          IconButton(
                            onPressed: playing.index == allSongs.length - 1
                                ? () {}
                                : () {
                                    player.next();
                                  },
                            icon: playing.index == allSongs.length - 1
                                ? Icon(
                                    FontAwesomeIcons.forward,
                                    size: 40,
                                    color: Colors.purple[100],
                                  )
                                : const Icon(
                                    FontAwesomeIcons.forward,
                                    size: 40,
                                    color: Colors.purpleAccent,
                                  ),
                            iconSize: 40,
                            color: Colors.purpleAccent,
                          ),

                          //<<<<<Repeat>>>>>//
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.rotate),
                            iconSize: 25,
                            color: Colors.purpleAccent,
                          ),
                        ],
                      ),
                    ],
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
