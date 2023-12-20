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
  final FileSystemEntity file;

  const VideoCard({super.key, required this.name, required this.file});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool _loading = true;
  late String videoSize = "NA";
  late var thumbnail;
  late String? thumbnailPath;
  late String? fileName;

  _getData() async {
    File file = File(widget.file.path);
    int fileSize = await file.length();

    // var x = await file.stat();
    videoSize = FileManager.formatBytes(fileSize, 2);
    String tempPath = widget.file.path;
    // /storage/emulated/0/Movies/Whatsapp/VID-20231022-WA0000.mp4
    // print(widget.file.path);
    thumbnailPath = await FileManager.getThumbnail(tempPath);
    // setState(() {
    //   _loading = false;
    // });

    return thumbnailPath;
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final double thumbnailWidth = MediaQuery.of(context).size.width * 0.30;

    return FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Card(thumbnailPath: snapshot.data.toString(),);
            // return Image.file(
            //   File(snapshot.data.toString()),
            //   width: 100,
            //   height: 100,
            // );
            // return Text(snapshot.data.toString());
          } else {
            return CircularProgressIndicator();
          }
        });
  }


}


class Card extends StatelessWidget {
  final String thumbnailPath;
  const Card({super.key, required this.thumbnailPath});

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
                    child: Image.file(
                      File(thumbnailPath),
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
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
                children: [
                  Text(
                    basename("helllo"),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "2:38:50 • 1080P • noobn",
                        style: TextStyle(
                            color: Theme.of(context).disabledColor),
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
    );;
  }
}
