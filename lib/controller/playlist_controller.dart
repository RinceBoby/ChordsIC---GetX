import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/views/playlist/playlistclone.dart';
import 'package:chordsic/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlaylistContoller extends GetxController {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  final OnAudioQuery audioQuery = OnAudioQuery();
  final OnAudioRoom audioRoom = OnAudioRoom();
  List<Audio> playListList = [];
  TextEditingController playlistcontroller = TextEditingController();

  addPlayList(String playlistName) {
    audioRoom.createPlaylist(playlistcontroller.text.capitalise());
    playlistcontroller.clear();
    update();
  }

  delPlayList({
    required index,
    required playList,
  }) {
    audioRoom.deletePlaylist(playList[index].key);
    update();
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Playlist_Clone>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  createPlclone() {
    audioRoom.createPlaylist(playlistcontroller.text.capitalise());
    playlistcontroller.clear();
    update();
  }

  delPlaylistClone({
    required item,
    required index,
  }) {
    audioRoom.deletePlaylist(item.data[index].key);
  }

  addToPlayList({
    required songIndex,
    required playList,
    required index,
  }) {
    audioRoom.addTo(
      RoomType.PLAYLIST,
      allSongs[songIndex].getMap.toSongEntity(),
      playlistKey: playList[index].key,
      ignoreDuplicate: false,
    );
    update();
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Playlist_Songs>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  delPlSongs({
    required playlistsongs,
    required index,
    required playlistkey,
  }) {
    audioRoom.deleteFrom(
      RoomType.PLAYLIST,
      playlistsongs[index].id,
      playlistKey: playlistkey,
    );
    update();
  }

  playPlSongs({required index, required List<Audio> playlistSongs}) {
    player.open(
      Playlist(
        audios: playlistSongs,
        startIndex: index,
      ),
      showNotification: true,
      loopMode: LoopMode.playlist,
      notificationSettings: const NotificationSettings(stopEnabled: false),
    );
  }
}
