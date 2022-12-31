import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'songPage.dart';
// import 'package:async/async.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:audioplayer/audioplayer.dart';

var path;
var play;
var ind;
var newId;
final player = AudioPlayer();
List<SongModel> songs = play.data!;

class AudioList extends StatefulWidget {
  const AudioList({Key? key}) : super(key: key);

  @override
  State<AudioList> createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  // final player = AudioPlayer();

  //...
  // AudioPlayer audioPlayer = AudioPlayer();
//...

  requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      // Default values:
      future: _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context, item) {
        play = item;
        // Loading content
        if (item.data == null) return const CircularProgressIndicator();

        // When you try "query" without asking for [READ] or [Library] permission
        // the plugin will return a [Empty] list.
        if (item.data!.isEmpty) return const Text("Nothing found!");

        // You can use [item.data!] direct or you can create a:
        List<SongModel> songs = item.data!;
        return ListView.builder(
          // itemCount: item.data!.length,
          itemCount: songs.length,
          itemBuilder: (context, index) {
            ind = index;
            return ListTile(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SongPage()),
                );

                newId = songs[index].id;
                path = songs[index].data.toString();

                await player.play(
                  DeviceFileSource(path),
                );
                // will immediately start playing
              },
              title: Text(item.data![index].title),
              subtitle: Text(item.data![index].artist ?? "No Artist"),
              trailing: const Icon(Icons.arrow_forward_rounded),
              // This Widget will query/load image. Just add the id and type.
              // You can use/create your own widget/method using [queryArtwork].
              leading: QueryArtworkWidget(
                id: item.data![index].id,
                type: ArtworkType.AUDIO,
                // type: ArtworkType.ALBUM,
              ),
            );
          },
        );
      },
    );
  }
}
