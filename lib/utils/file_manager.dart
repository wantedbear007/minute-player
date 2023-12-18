import 'dart:io';

import 'package:path/path.dart' as path;
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

    // List<FileSystemEntity> lst = dir.listSync();

    await for (FileSystemEntity file in dir.list()) {
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
      // List<FileSystemEntity> allFilesInPath = [];
      try {
        files.addAll(await getAllFilesInPath(dir.path));
      } catch (err) {
        if (kDebugMode) print(err.toString());
      }
      // files.addAll(allFilesInPath);
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

    // String fileExtension = filePath.substring(filePath.length - 4);
    String fileExtension = path.extension(filePath);
    return videoFormats.contains(fileExtension) ? true : false;
  }

//   get folders with video files
  static Map<String, String> getFolders(String filePath) {
    // int firstDirectory = 0;
    // int secondDirectory = 0;
    //
    // for (int i = filePath.length - 1; i >= 0; i--) {
    //   if (filePath[i] == '/' && firstDirectory == 0) {
    //     firstDirectory = i;
    //     continue;
    //   }
    //   if (firstDirectory != 0 && filePath[i] == '/') {
    //     secondDirectory = i;
    //     break;
    //   }

    String folderName = path.basename(path.dirname(filePath));
    String folderPath = path.dirname(filePath);

    return {"name": folderName, "path": folderPath};
  }

  // Map<String, String> res = {};
  // String folderName = filePath.substring(secondDirectory + 1, firstDirectory);
  // String folderPath = filePath.substring(0, secondDirectory + 1);
  //
  // res["name"] = folderName;
  // res["path"] = folderPath;
  //
  // // return filePath.substring(secondDirectory + 1, firstDirectory);
  //
  // return res;
  // }

// get all video files
  static Future<List<Map<String, dynamic>>> getFoldersWithFiles() async {
    List<String> allVideos = <String>[];
    List<FileSystemEntity> folders = await getFiles();

    for (FileSystemEntity files in folders) {
      if (isVideo(files.path)) {
        allVideos.add(files.path);
      }
    }

    List<Map<String, dynamic>> folderWithQuantity = [];

    // Map<String, dynamic> folderWithQuantity = {};
    for (int i = 0; i < allVideos.length; i++) {
      Map<String, String> folderInfo = getFolders(allVideos[i]);
      String folderName = folderInfo["name"]!;
      String folderPath = folderInfo["path"]!;

      bool folderExists = false;
      for (int j = 0; j < folderWithQuantity.length; j++) {
        if (folderWithQuantity[j]["folderName"] == folderName &&
            folderWithQuantity[j]["folderPath"] == folderPath) {
          folderExists = true;
          folderWithQuantity[j]["fileCount"] =
              (folderWithQuantity[j]["fileCount"] ?? 0) + 1;
          break;
        }
      }

      if (!folderExists) {
        folderWithQuantity.add({
          "folderName": folderName,
          "folderPath": folderPath,
          "fileCount": 1,
        });
      }
    }

    // for (int i = 0; i < allVideos.length; i++) {
    //   // String folderName = getFolders(allVideos[i])["name"]!;
    //   Map<String, String> folderInfo = getFolders(allVideos[i]);
    //
    //   String folderName = folderInfo["name"]!;
    //   String folderPath = folderInfo["path"]!;
    //   folderWithQuantity[folderName] =
    //       ((folderWithQuantity[folderName] ?? 0) + 1);
    //   folderWithQuantity["path"] = folderPath;
    // }

    return folderWithQuantity;
  }
}
