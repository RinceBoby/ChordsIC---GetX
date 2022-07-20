// ignore_for_file: file_names

import 'package:chordsic/views/player/screen_player.dart';
import 'package:chordsic/views/player/openPlayer.dart';
import 'package:chordsic/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomSearch extends SearchDelegate {
  List<String> allData = [''];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.grey,
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      hintColor: Colors.grey,
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 221, 255, 252),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
              border: InputBorder.none, fillColor: Colors.black),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: GoogleFonts.nunito(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchSongItem = query.isEmpty
        ? songDetails
        : songDetails
                .where(
                  (element) => element.metas.title!.toLowerCase().contains(
                        query.toLowerCase().toString(),
                      ),
                )
                .toList() +
            songDetails
                .where(
                  (element) => element.metas.artist!.toLowerCase().contains(
                        query.toLowerCase().toString(),
                      ),
                )
                .toList();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),
      body: searchSongItem.isEmpty
          ? Center(
              child: Text(
                "No Songs Found",
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  letterSpacing: 1,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
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
                          Colors.purpleAccent.withOpacity(0.35),
                          Colors.purpleAccent.withOpacity(0.015),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Center(
                      child: ListTile(
                        onTap: (() async {
                          await OpenPlayer(
                            allSongs: [],
                            index: index,
                          ).openAssetPlayer(
                            index: index,
                            songs: searchSongItem,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) =>  Player()),
                            ),
                          );
                        }),
                        leading: QueryArtworkWidget(
                          nullArtworkWidget: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                            child: Image.asset(
                              'assets/images/Apple-Music-Artist-Lover.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          id: int.parse(searchSongItem[index].metas.id!),
                          type: ArtworkType.AUDIO,
                        ),
                        title: Text(
                          searchSongItem[index].metas.title!,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          searchSongItem[index].metas.artist!,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        // trailing: IconButton(
                        //   onPressed: () {},
                        //   icon: const Icon(
                        //     Icons.more_vert_rounded,
                        //     color: Colors.grey,
                        //     size: 30,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: searchSongItem.length,
            ),
    );
  }
}
