import 'dart:io';

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
  bool _loading = true;
  late List<Map<String, dynamic>> folders;

  // to load all folders with video files
  void _loadFolders() async {
    folders = await FileManager.getFoldersWithFiles();

    setState(() {
      _loading = false;
    });
  }

  @override

  void initState() {
    super.initState();
    _loadFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Dialogs.showLoading("Loading folders")
          : ListView.builder(
              itemCount: folders.length,
              itemBuilder: (BuildContext context, int index) {
                String folderName = folders[index]['folderName'] ?? "NA";

                return FolderCard(
                  path: folders[index]["folderPath"] ?? "NA",
                  folderName: folderName,
                  fileCount: folders[index]["fileCount"] ?? "NA",
                );
              },
            ),
    );
  }
}
