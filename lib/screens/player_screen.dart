import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minute_player/widgets/video_card.dart';
import 'package:path/path.dart';

class PlayerScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    List<String> updated = nextFiles.where((str) => str != fileName).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              // child: Text(basename(fileName)),
              child: SvgPicture.asset("empty.svg", height: 50),
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
                            basename(fileName),
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
                  ? Center(child: Text("notavailable"))
                  : ListView.builder(
                      itemCount: updated.length,
                      itemBuilder: (context, int index) {
                        return VideoCard(
                            name: updated[index], nextFiles: nextFiles);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
