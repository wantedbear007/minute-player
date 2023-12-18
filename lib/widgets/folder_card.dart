import 'package:flutter/material.dart';

class FolderCard extends StatefulWidget {
  final String folderName;
  final int fileCount;

  const FolderCard(
      {super.key, required this.folderName, required this.fileCount});

  @override
  State<FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("hello");
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
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
                    style: TextStyle(overflow: TextOverflow.ellipsis),
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
