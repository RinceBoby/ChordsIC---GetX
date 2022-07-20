import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/splashscreen.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlayerController extends GetxController {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  final OnAudioQuery audioQuery = OnAudioQuery();
  final OnAudioRoom audioRoom = OnAudioRoom();

  addFavPlayer({required currentIndex}) {
    audioRoom.addTo(
      RoomType.FAVORITES,
      allSongs[currentIndex].getMap.toFavoritesEntity(),
    );
    update();
  }

  delFavPlayer({required key}) {
    audioRoom.deleteFrom(RoomType.FAVORITES, key);
    update();
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Mini_Player>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
}
