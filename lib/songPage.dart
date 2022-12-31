import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'duration.dart';
import 'main.dart';
import 'audiolist.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  // final player = AudioPlayer();
  int _value = 1;
  var i = const Icon(Icons.pause);

  SongPage() async {
    if (_value % 2 == 0) {
      print("harsh");
      i = const Icon(Icons.pause);
      await player.resume();
    } else if ((duration - position) == 0) {
      i = const Icon(Icons.pause);
    } else {
      print("rajput");
      i = const Icon(Icons.play_arrow);
      await player.pause();
    }
    return i;
  }

  //
  // late Duration position;
  // double h = position as double;
  // late double position;
  // var position;
  // void duration() {
  //   player.onPositionChanged.listen((Duration p) => {
  //         print('Current position: $p'),
  //         setState(() {
  //           duration();
  //           position = p as double;
  //         })
  //       });
  //
  //   // return position;
  // }
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;
  // // late int a;
  // // int result = player.seek(Duration(milliseconds: 1200)) as int;
  // bool isPlaying = false;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split(".")[0].padLeft(8, '0');
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   player.onPlayerStateChanged.listen((state) {
  //     setState(() {
  //       isPlaying = state == PlayerState.playing;
  //     });
  //   });
  //   player.onDurationChanged.listen((newDuration) {
  //     setState(() {
  //       duration = newDuration;
  //     });
  //   });
  //
  //   player.onPositionChanged.listen((newPosition) {
  //     position = newPosition;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(150),
                        artworkHeight: 300,
                        artworkWidth: 300,
                        id: newId,
                        type: ArtworkType.AUDIO,
                        // type: ArtworkType.ALBUM,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: Duratioin(),
                          // Slider(
                          //   min: 0,
                          //   max: duration.inSeconds.toDouble(),
                          //   value: position.inSeconds.toDouble(),
                          //   onChanged: (value) {
                          //     setState(
                          //       () {
                          //         final position = Duration(seconds: value.toInt());
                          //         player.seek(position);
                          //         // player.resume();
                          //       },
                          //     );
                          //   },
                          // ),
                        ),
                      ],
                    ), //Slider
                    //Time
                    const length(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        // verticalDirection: VerticalDirection.down,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            child: const Icon(Icons.skip_previous),
                            onPressed: () {
                              setState(() {});
                            },
                            // child: Icon(i),
                          ),
                          FloatingActionButton(
                            child: i,
                            onPressed: () {
                              setState(() {
                                SongPage();
                                _value += 1;
                              });
                            },
                            // child: Icon(i),
                          ),
                          FloatingActionButton(
                            child: const Icon(Icons.skip_next),
                            onPressed: () {
                              setState(() {});
                            },
                            // child: Icon(i),
                          ),
                          // Text(formatTime(position.inSeconds)),
                          // Text(formatTime((duration - position).inSeconds)),
                        ],
                      ),
                    ),
                  ],
                ),
                //play button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
