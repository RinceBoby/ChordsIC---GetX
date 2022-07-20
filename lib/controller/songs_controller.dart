import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/splashscreen.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class SongsController extends GetxController {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  final OnAudioQuery audioQuery = OnAudioQuery();
  final OnAudioRoom audioRoom = OnAudioRoom();

  List<SongModel> allSongs = [];

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Play_Song>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  playSong(int index) {
    player.open(
      Playlist(
        audios: songDetails,
        startIndex: index,
      ),
      showNotification: true,
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      autoStart: true,
      loopMode: LoopMode.playlist,
      playInBackground: PlayInBackground.enabled,
    );

  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Add_To_Fav>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  addFav({required favSongDetails}) {
    print(allSongs.length);
    audioRoom.addTo(
      RoomType.FAVORITES,
    favSongDetails,
      ignoreDuplicate: false,
    );
    update();
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Del_From_Fav>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  delFav({required key}) {
    audioRoom.deleteFrom(
      RoomType.FAVORITES,
      key!,
    );
    update();
  }

  addToPl() {}
}
