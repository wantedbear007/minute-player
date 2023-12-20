import 'package:flutter/material.dart';
import 'package:minute_player/widgets/video_card.dart';

class VideoScreen extends StatelessWidget {
  final String folderName;
  final List<String> folderFiles;
  final List<String> allFiles;

  const VideoScreen({
    super.key,
    required this.folderName,
    required this.folderFiles,
    required this.allFiles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          folderName,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: folderFiles.length,
        itemBuilder: (BuildContext context, int index) {
          return VideoCard(
            name: folderFiles[index],
            nextFiles: folderFiles,
          );
        },
      ),
    );
  }
}
