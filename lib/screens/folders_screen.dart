import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minute_player/utils/color_schemes.dart';
import 'package:minute_player/utils/file_manager.dart';
import 'package:minute_player/widgets/folder_card.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  bool _loading = true;
  late Map<String, int> folders;

  void _loadFolders() async {
    // setState(() {
    //   _loading = true;
    // });
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
        appBar: AppBar(
          title: Text("loading "),
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary),
              )
            : ListView.builder(
                itemCount: folders.length,
                itemBuilder: (BuildContext context, int index) {
                  String folderName = folders.keys.elementAt(index);
                  return FolderCard(
                      folderName: folderName,
                      fileCount: folders[folderName] ?? 0);
                }));
  }
}
