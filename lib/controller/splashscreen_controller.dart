import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/model/songmodel.dart';
import 'package:chordsic/views/home/bottom_nav.dart';
import 'package:get/get.dart';

import '../splashscreen.dart';


class SplashController extends GetxController {
  // final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  // final OnAudioQuery audioQuery = OnAudioQuery();
  // final OnAudioRoom audioRoom = OnAudioRoom();

  // List<SongModel> allSongs = [];
  // List<Songs> mappedSongs = [];
  // List<Audio> songDetails = [];

  @override
  void onInit() {
    requestPermission();
    goToHomeScreen();
    super.onInit();
  }

  void requestPermission() async {
    bool permissionsStatus = await audioQuery.permissionsStatus();
    if (permissionsStatus) {
      await audioQuery.permissionsRequest();
      update();
    }
    allSongs = await audioQuery.querySongs();
    mappedSongs = allSongs
        .map((audio) => Songs(
              id: audio.id,
              artist: audio.artist,
              duration: audio.duration,
              songname: audio.title,
              songurl: audio.uri,
            ))
        .toList();

    for (var i in allSongs) {
      songDetails.add(
        Audio.file(
          i.uri.toString(),
          metas: Metas(
            title: i.title,
            id: i.id.toString(),
            artist: i.artist,
          ),
        ),
      );
      update();
    }
  }

  Future<void> goToHomeScreen()async{
    await Future.delayed(const Duration(seconds: 2),);
    Get.off(const HomeScreen1());

  }
}
