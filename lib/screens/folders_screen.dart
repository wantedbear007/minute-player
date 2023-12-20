import 'package:flutter/material.dart';
import 'package:minute_player/utils/dialog.dart';
import 'package:minute_player/utils/file_manager.dart';
import 'package:minute_player/widgets/folder_card.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  bool _loadingFiles = false;

  void _refreshFiles() async {
    setState(() {
      _loadingFiles = true;
    });
    await FileManager.getAllFoldersWithFiles();
    setState(() {
      _loadingFiles = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Folders"),
        leading: const Icon(Icons.explore),
        actions: [
          _loadingFiles
              ? Container()
              : IconButton(
                  onPressed: () {
                    _refreshFiles();
                  },
                  icon: const Icon(Icons.refresh),
                )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: FileManager.getAllFoldersWithFiles(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return FolderCard(
                  folderName: snapshot.data[index]["folderName"],
                  fileCount: snapshot.data[index]["filesCount"],
                  // relatedFiles: snapshot.data[index],
                  files: snapshot.data[index]["files"],
                );
              },
            );
          } else {
            return Dialogs.showLoading("Loading Folders");
          }
        },
      ),
    );
  }
}
