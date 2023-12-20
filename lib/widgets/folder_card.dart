import 'package:flutter/material.dart';
import 'package:minute_player/screens/video_files_screen.dart';

class FolderCard extends StatefulWidget {
  final String folderName;
  final dynamic fileCount;
  final List<String> files;

  const FolderCard(
      {super.key,
      required this.folderName,
      required this.fileCount,
      required this.files});

  @override
  State<FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoScreen(
              folderName: widget.folderName,
              folderFiles: widget.files,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          children: [
            Icon(
              Icons.folder,
              color: Theme.of(context).colorScheme.primary,
              size: MediaQuery.of(context).size.width * 0.25,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.folderName,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  ),
                  Text(
                    "${widget.fileCount} Videos",
                    style: TextStyle(color: Theme.of(context).disabledColor),
                  )
                ],
              ),
            )
            //   folder details
            //   IconButton(onPressed: () {}, icon: const Icon(Icons.))
          ],
        ),
      ),
    );
  }
}
