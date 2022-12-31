import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'audiolist.dart';
import 'songPage.dart';

class Duratioin extends StatefulWidget {
  const Duratioin({Key? key}) : super(key: key);

  @override
  State<Duratioin> createState() => _DuratioinState();
}

Duration duration = Duration.zero;
Duration position = Duration.zero;

class _DuratioinState extends State<Duratioin> {
  bool isPlaying = false;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split(".")[0].padLeft(8, '0');
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: duration.inSeconds.toDouble(),
      value: position.inSeconds.toDouble(),
      onChanged: (value) {
        setState(
          () {
            final position = Duration(seconds: value.toInt());
            player.seek(position);
            // player.resume();
          },
        );
      },
    );
  }
}

class length extends StatefulWidget {
  const length({Key? key}) : super(key: key);

  @override
  State<length> createState() => _lengthState();
}

class _lengthState extends State<length> {
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split(".")[0].padLeft(8, '0');
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formatTime(position.inSeconds)),
          Text(formatTime((duration - position).inSeconds)),
        ],
      ),
    );
  }
}
