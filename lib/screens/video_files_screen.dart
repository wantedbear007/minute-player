import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minute_player/widgets/video_card.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  Future<void> _requestPermission() async {
    await Permission.videos.request();
    await Permission.notification.request();
    final status = await Permission.mediaLibrary.request();

    if (status == PermissionStatus.granted) {
      print("permission is granted !");
    } else {
      print("Permission is not granted !");
    }
  }

  _getPaths() async {
    List<FileSystemEntity> files = [];
    Directory dir = Directory("/storage/emulated/0/Download");
    List<FileSystemEntity> list = dir.listSync();

    for (var lst in list) {
      // print(lst);
      print("---------------------");
    }

    print("below is the data");

    // print(list.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermission();
    _getPaths();
    // _anotherOne();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VideoCard(),
        VideoCard(),
        VideoCard(),
        VideoCard(),
      ],
    );
  }
}
