import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
import 'dart:async';
// import 'dart:io';
// import 'audiolist.dart';
// import 'package:on_audio_query/on_audio_query.dart';
import 'audiolist.dart';

void main() {
  runApp(const MyApp());
}

enum SampleItem { itemOne }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String getFile() {
  //   Future<String> get _localPath async {
  //     final directory = await getApplicationDocumentsDirectory();
  //
  //     return directory.path;
  //   }
  //   Future<File> get _localFile async {
  //     final path = await _localPath;
  //     return File('$path/counter.txt');
  //   }
  // }
  // late Future permissionGranted;
  // Future _getStoragePermission() async {
  //   if (await Permission.storage.request().isGranted) {
  //     setState(() {
  //       permissionGranted = true as Future;
  //     });
  //   }
  // }
  // late Future<int> storagePermissionChecker;
  // late List<SongModel> something;
  var result;
  // final OnAudioQuery _audioQuery = OnAudioQuery();
  SampleItem? selectedMenu;

  // requestPermission() async {
  //   // Web platform don't support permissions methods.
  //   if (!kIsWeb) {
  //     bool permissionStatus = await _audioQuery.permissionsStatus();
  //     if (!permissionStatus) {
  //       await _audioQuery.permissionsRequest();
  //     }
  //     setState(() {});
  //   }
  // }

  void storagePermission() async {
    result = await Permission.storage.request();
    if (await Permission.storage.isGranted) {
      print("permission is granted");
    } else {
      result;
    }

    // print(result);

    // else if (Permission.storage.status) {
    //   // if (await Permission.storage.request().isGranted) {
    //   //   print("Permisson is granted");
    //   // }
    //   Permission.storage.request();
    // }
    // return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    storagePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const AudioList(),
        // FutureBuilder<List<SongModel>>(
        //   // Default values:
        //   future: _audioQuery.querySongs(
        //     sortType: null,
        //     orderType: OrderType.ASC_OR_SMALLER,
        //     uriType: UriType.EXTERNAL,
        //     ignoreCase: true,
        //   ),
        //   builder: (context, item) {
        //     // Loading content
        //     if (item.data == null) return const CircularProgressIndicator();
        //
        //     // When you try "query" without asking for [READ] or [Library] permission
        //     // the plugin will return a [Empty] list.
        //     if (item.data!.isEmpty) return const Text("Nothing found!");
        //
        //     // You can use [item.data!] direct or you can create a:
        //     List<SongModel> songs = item.data!;
        //     return ListView.builder(
        //       // itemCount: item.data!.length,
        //       itemCount: songs.length,
        //       itemBuilder: (context, index) {
        //         return ListTile(
        //           onTap: () {
        //             // print(item.data![index].title);
        //           },
        //           title: Text(item.data![index].title),
        //           subtitle: Text(item.data![index].artist ?? "No Artist"),
        //           trailing: const Icon(Icons.arrow_forward_rounded),
        //           // This Widget will query/load image. Just add the id and type.
        //           // You can use/create your own widget/method using [queryArtwork].
        //           leading: QueryArtworkWidget(
        //             id: item.data![index].id,
        //             type: ArtworkType.AUDIO,
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
        // body: SafeArea(
        //   child: Column(
        //     children: [
        //       const Text("this is new app"),
        //       TextButton(
        //         // child: Colors.green,
        //         child: const Text(
        //           'Flat Button',
        //           style: TextStyle(color: Colors.black),
        //         ),
        //         onPressed: () {
        //           storagePermission();
        //           // if (result.isGranted) {
        //           //   Navigator.push(
        //           //       context,
        //           //       MaterialPageRoute(
        //           //           builder: (context) => const AudioList()));
        //           // }
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          title: const Text("Music Player"),
          actions: [
            PopupMenuButton<SampleItem>(
              offset: (const Offset(10, 10)),
              initialValue: selectedMenu,
              // Callback that sets the selected popup menu item.
              onSelected: (SampleItem item) {
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                PopupMenuItem<SampleItem>(
                  onTap: () {
                    storagePermission();
                  },
                  value: SampleItem.itemOne,
                  child: const Text('Storage permission'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // List<String> list = <String>['Permission'];
}
