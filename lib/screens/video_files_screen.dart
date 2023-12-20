import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minute_player/utils/dialog.dart';
import 'package:minute_player/utils/file_manager.dart';
import 'package:minute_player/widgets/video_card.dart';

class VideoScreen extends StatefulWidget {
  final String folderName;
  final String folderPath;

  const VideoScreen(
      {super.key, required this.folderName, required this.folderPath});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool _loading = true;
  late List<FileSystemEntity> files;

  _getAllFiles() async {
    files = await FileManager.getVideoFiles(widget.folderPath);

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.folderName,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: _loading
          ? Dialogs.showLoading("Loading Videos")
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (BuildContext context, int index) {
                return VideoCard(
                  name: files[index].toString(),
                  file: files[index],
                );
              },
            ),
    );
  }
}
