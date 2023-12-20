import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:minute_player/utils/dialog.dart';
import 'package:minute_player/utils/file_manager.dart';
import 'package:path/path.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoCard extends StatefulWidget {
  final String name;

  // final FileSystemEntity file;

  const VideoCard({super.key, required this.name});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool _loading = true;
  late String videoSize = "NA";
  late var thumbnail;
  late String thumbnailPath =
      "https://images.unsplash.com/photo-1695653422872-9bd1e29fe490?q=80&w=2075&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  late String? fileName;

  //
  // _getData() async {
  //   File file = File(widget.file.path);
  //   int fileSize = await file.length();
  //
  //   // var x = await file.stat();
  //   videoSize = FileManager.formatBytes(fileSize, 2);
  //   String tempPath = widget.file.path;
  //   // /storage/emulated/0/Movies/Whatsapp/VID-20231022-WA0000.mp4
  //   // print(widget.file.path);
  //   thumbnailPath = await FileManager.getThumbnail(tempPath);
  //   // setState(() {
  //   //   _loading = false;
  //   // });
  //
  //   return thumbnailPath;
  // }

  @override
  void initState() {
    super.initState();
    // _getData();
  }

  @override
  Widget build(BuildContext context) {
    final double thumbnailWidth = MediaQuery.of(context).size.width * 0.30;

    return Card(
      fileName: widget.name,
      thumbnailPath: thumbnailPath,
      thumbnailWidth: thumbnailWidth,
    );
  }
}

class Card extends StatelessWidget {
  final String thumbnailPath;
  final double thumbnailWidth;
  final String fileName;

  const Card({
    super.key,
    required this.fileName,
    required this.thumbnailPath,
    required this.thumbnailWidth,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("helloo");
      },
      child: Container(
        padding: const EdgeInsets.only(top: 6, bottom: 6, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    // child: Image.memory(thumbnail),
                    child: Image.network(thumbnailPath, width: thumbnailWidth),
                    // child: Image.file(
                    //   File(thumbnailPath),
                    //   width: 100,
                    //   height: 100,
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  right: 8,
                  child: Icon(
                    Icons.play_circle,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    basename(fileName),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "2:38:50 • 1080P • 324MB",
                        style:
                            TextStyle(color: Theme.of(context).disabledColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
