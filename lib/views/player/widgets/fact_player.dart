import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:chordsic/splashscreen.dart';
import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  const SeekBar({Key? key}) : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  @override
  Widget build(BuildContext context) {
    return player.builderRealtimePlayingInfos(
      builder: (ctx, infos) {
        Duration currentPosition = infos.currentPosition;
        Duration total = infos.duration;
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ProgressBar(
              progress: currentPosition,
              total: total,
              onSeek: (to) {
                player.seek(to);
              },
              timeLabelTextStyle: const TextStyle(color: Colors.black),
              baseBarColor: const Color.fromARGB(255, 190, 190, 190),
              progressBarColor: Colors.purpleAccent,
              thumbColor: Colors.purpleAccent),
        );
      },
    );
  }
}
