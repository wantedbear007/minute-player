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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Folders"),
        leading: const Icon(Icons.explore),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: FileManager.getAllFoldersWithFiles(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.runtimeType);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return FolderCard(
                    folderName: snapshot.data[index]["folderName"],
                    fileCount: snapshot.data[index]["filesCount"],
                    files: snapshot.data[index]["files"]);
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
