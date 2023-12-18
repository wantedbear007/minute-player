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
        // if (!file.path.contains("/storage/emulated/0")) {
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

  static bool isVideo(String filePath) {
    List<String> videoFormats = [
      ".mp4",
      ".avi",
      ".mkv",
      ".wmv",
      ".mov",
      ".flv",
      ".mpeg",
      ".3gp",
      ".webm",
      // Add more video formats as needed
    ];

    String fileExtension = filePath.substring(filePath.length - 4);

    return videoFormats.contains(fileExtension) ? true : false;
  }

//   get folders with video files
  static Map<String, String> getFolders(String filePath) {
    int firstDirectory = 0;
    int secondDirectory = 0;

    for (int i = filePath.length - 1; i >= 0; i--) {
      if (filePath[i] == '/' && firstDirectory == 0) {
        firstDirectory = i;
        continue;
      }
      if (firstDirectory != 0 && filePath[i] == '/') {
        secondDirectory = i;
        break;
      }
    }

    Map<String, String> res = {};
    String folderName = filePath.substring(secondDirectory + 1, firstDirectory);
    String folderPath = filePath.substring(0, secondDirectory + 1);

    res["name"] = folderName;
    res["path"] = folderPath;

    // return filePath.substring(secondDirectory + 1, firstDirectory);

    return res;
  }

// get all video files
  static Future<Map<String, int>> getFoldersWithFiles() async {
    List<String> allVideos = <String>[];
    List<FileSystemEntity> folders = await getFiles();

    for (FileSystemEntity files in folders) {
      if (isVideo(files.path)) {
        allVideos.add(files.path);
        continue;
      }
    }


    // for ()
    Map<String, int> folderWithQuantity = {};


    for (int i = 0; i < allVideos.length; i++) {
      String folderName = getFolders(allVideos[i])["name"]!;

      folderWithQuantity[folderName] =
          (folderWithQuantity[folderName] ?? 0) + 1;
    }

    return folderWithQuantity;
  }
}
