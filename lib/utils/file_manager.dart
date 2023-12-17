import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
//   Get all storage paths
  static Future<List<Directory>> getStoragePaths() async {
    List<Directory> paths = (await getExternalStorageDirectories())!;
    List<Directory> filteredPaths = [];
    for (Directory directory in paths) {
      filteredPaths.add(Directory(directory.path.split('Android')[0]));
    }

    return filteredPaths;
  }

  // to get all files in path
  static Future<List<FileSystemEntity>> getAllFilesInPath(String path) async {
    List<FileSystemEntity> files = [];
    Directory dir = Directory(path);

    List<FileSystemEntity> lst = dir.listSync();

    for (FileSystemEntity file in lst) {
      if (FileSystemEntity.isFileSync(file.path)) {
        files.add(file);
      } else {
        if (!file.path.contains("/storage/emulated/0/Android")) {
          files.addAll(await getAllFilesInPath(file.path));
        }
      }
    }
    return files;
  }

// to get all files of device
  static Future<List<FileSystemEntity>> getFiles() async {
    List<Directory> storages = await getStoragePaths();
    List<FileSystemEntity> files = [];

    for (Directory dir in storages) {
      List<FileSystemEntity> allFilesInPath = [];
      try {
        allFilesInPath = await getAllFilesInPath(dir.path);
      } catch (err) {
        if (kDebugMode) print(err.toString());
      }
      files.addAll(allFilesInPath);
    }

    return files;
  }
}
