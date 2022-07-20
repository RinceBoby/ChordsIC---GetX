import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class FavoriteController extends GetxController {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  final OnAudioQuery audioQuery = OnAudioQuery();
  final OnAudioRoom audioRoom = OnAudioRoom();

  List<Audio> favSongs = [];

  delAllFav() async {
    await audioRoom.clearRoom(RoomType.FAVORITES);
    update();
  }

  delFav({
    required favorites,
    required index,
  }) async {
    await audioRoom.deleteFrom(
      RoomType.FAVORITES,
      favorites[index].key,
    );
    update();
  }

  playOnTap({
    required favSongsList,
    required index,
  }) async {
    await player.open(
      Playlist(
        audios: favSongsList,
        startIndex: index,
      ),
      showNotification: true,
      loopMode: LoopMode.playlist,
      notificationSettings: const NotificationSettings(stopEnabled: false),
    );
  }
}
