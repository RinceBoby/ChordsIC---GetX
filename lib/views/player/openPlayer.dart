// ignore_for_file: file_names

import 'package:assets_audio_player/assets_audio_player.dart';

class OpenPlayer {
  
  List<Audio> allSongs;
  int index;
  bool? notify;

  OpenPlayer({
    required this.allSongs,
    required this.index,
  });

  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  openAssetPlayer({List<Audio>? songs, required int index}) async {
    player.open(
      Playlist(audios: songs, startIndex: index),
      showNotification: notify == null || notify == true ? true : false,
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      autoStart: true,
      loopMode: LoopMode.playlist,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
      playInBackground: PlayInBackground.enabled,
    );
  }
}
