import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minute_player/screens/folders_screen.dart';
import 'package:minute_player/widgets/video_card.dart';
// import 'package:permission_handler/permission_handler.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FolderScreen(),
        VideoCard(),
        VideoCard(),
        VideoCard(),
        VideoCard(),
      ],
    );
  }
}
