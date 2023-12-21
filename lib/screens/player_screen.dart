import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:minute_player/utils/dialog.dart';
import 'package:minute_player/widgets/video_card.dart';
import 'package:path/path.dart';

class PlayerScreen extends StatefulWidget {
  final String fileName;
  final String thumbnail;
  final List<String> nextFiles;

  // final List subFiles;

  const PlayerScreen({
    super.key,
    required this.fileName,
    required this.thumbnail,
    required this.nextFiles,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final String _file =
      "https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4";
  late final player = Player();

  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    player.open(Media(widget.fileName));
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  // /storage/emulated/0/Movies/Whatsapp/VID-20231022-WA0000.mp4
  @override
  Widget build(BuildContext context) {
    List<String> updated =
        widget.nextFiles.where((str) => str != widget.fileName).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.screen_rotation),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              // child: Text(basename(fileName)),
              child: Video(
                controller: controller,
              ),
            ),
            // const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back)),
                        Flexible(
                          child: Text(
                            basename(widget.fileName),
                            maxLines: 3,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            const Divider(),
            Flexible(
              child: updated.isEmpty
                  ? Dialogs.showSvg(
                      "assets/images/empty.svg",
                      "There are no additional files.",
                      MediaQuery.of(context).size.width * 0.25)
                  : ListView.builder(
                      itemCount: updated.length,
                      itemBuilder: (context, int index) {
                        return VideoCard(
                            name: updated[index], nextFiles: widget.nextFiles);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
