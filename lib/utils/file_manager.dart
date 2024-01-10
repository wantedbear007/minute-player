import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:fc_native_video_thumbnail/fc_native_video_thumbnail.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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

  // convert bytes to MB GB
  static String formatBytes(int bytes, int decimals) {
    if (bytes == 0) return '0.0 Bytes';
    int k = 1024;
    int dm = decimals <= 0 ? 0 : decimals;
    List<String> sizes = [
      'Bytes',
      'KB',
      'MB',
      'GB',
      'TB',
      'PB',
      'EB',
      'ZB',
      'YB'
    ];
    int i = (log(bytes) / log(k)).floor();
    return '${(bytes / pow(k, i)).toStringAsFixed(dm)} ${sizes[i]}';
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

  // static Future<List<FileSystemEntity>> getAllFilesInPath(String path) async {
  //   Directory dir = Directory(path);
  //   List<FileSystemEntity> videoFiles = [];
  //
  //   await for (FileSystemEntity entity in dir.list()) {
  //     if (entity is File && isVideo(entity.path)) {
  //       videoFiles.add(entity);
  //     }
  //   }
  //
  //   return videoFiles;
  // }

  // to get all files in path
  static Future<List<FileSystemEntity>> getAllFilesInPath(String path) async {
    List<FileSystemEntity> files = [];
    Directory dir = Directory(path);
   // print(dir);

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

//   to get video files in a path / folder

  static Future<List<FileSystemEntity>> getVideoFiles(String folderPath) async {
    Directory directory = Directory(folderPath);

    if (await directory.exists()) {
      List<FileSystemEntity> videoFiles =
          directory.listSync().where((file) => isVideo(file.path)).toList();

      return videoFiles;
    } else {
      return [];
    }
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

    return folderWithQuantity;
  }

  static Future<List<FileSystemEntity>> tempGetFiles() async {
    List<Directory> storages = await getStoragePaths();
    List<FileSystemEntity> files = [];

    for (Directory dir in storages) {
      // List<FileSystemEntity> allFilesInPath = [];
      try {
        // if (isVideo(dir.path)) {
        files.addAll(await getAllFilesInPath(dir.path));
        // }
      } catch (err) {
        if (kDebugMode) print(err.toString());
      }
      // files.addAll(allFilesInPath);
    }

    return files;
  }

  static List<String> videos = [];

  // function Optimus Prime
  static Future<List<Map<String, dynamic>>> getAllFoldersWithFiles() async {
    List<FileSystemEntity> files = await tempGetFiles();
    List<String> videoFiles = [];
    for (FileSystemEntity file in files) {
      if (isVideo(file.path.toString())) {
        videoFiles.add(file.path.toString());
      }
    }

    videos = videoFiles;

    List<Map<String, dynamic>> json = [];

    for (var file in videoFiles) {
      Map<String, dynamic> folderBundle = {};
      List<String> pathSegments = file.toString().split('/');
      String folderName = pathSegments[pathSegments.length - 2];
      bool isAvailable = false;

      for (int i = 0; i < json.length; i++) {
        if (json[i]["folderName"] == folderName) {
          isAvailable = true;
          json[i]["filesCount"] = (json[i]["filesCount"] ?? 0) + 1;
          (json[i]["files"] as List<String>).add(file);
          break;
        }
      }

      if (!isAvailable) {
        folderBundle["folderName"] = folderName;
        folderBundle["filesCount"] = 1;
        folderBundle["files"] = [file];
        json.add(folderBundle);
      }
    }
    return json;
  }








  //BY SPS
  //  static Future<List<Directory>> getAllStorageList() async {
  //   if(Platform.isAndroid){
  //     List<Directory> storages = (await getExternalStorageDirectories())!;
  //     storages = storages.map((Directory e) {
  //       final List<String> splittedPath = e.path.split("/");
  //       return Directory(splittedPath
  //           .sublist(
  //           0, splittedPath.indexWhere((element) => element == "Android"))
  //           .join("/"));
  //     }).toList();
  //
  //     return storages;
  //
  //   }
  //   return [];
  //  }
  //   get video thumbnail
  static Future<String?> getThumbnail(String videoPath) async {
    String? _thumbnail = await VideoThumbnail.thumbnailFile(
        // timeMs: 10,
        quality: 20,
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG);

    return _thumbnail;
  }

  static Future<bool> nativeThumbnail(String path) async {
    final plugin = FcNativeVideoThumbnail();
    late bool isSuccess = false;
    String savePath = (await getTemporaryDirectory()).path;
    try {
      final thumbnailGenerate = await plugin.getVideoThumbnail(
          srcFile: path,
          destFile: savePath,
          width: 300,
          height: 300,
          keepAspectRatio: true,
          format: 'jpeg',
          quality: 90);

      isSuccess = thumbnailGenerate;
    } catch (err) {
      print(err.toString());
    }

    return isSuccess;
  }

//   creating thumbnail

  static tempThumbnail() async {
    var data = await getTemporaryDirectory();

    // print(data.toString());
    // print(data.path.toString());

    print("inside function");
    List<Map<String, String>> thumbnailHash = [];

    for (var x in videos) {
      Map<String, String> thumbnail = {};

      thumbnail["fileName"] = x;
      // String? getThumbnail = await FileManager.getThumbnail(x);
      // Uint8List? getThumbnail = await FileManager.getThumbMemory(x);

      bool native = await FileManager.nativeThumbnail(x);
      print(native.toString());
      // thumbnail["cached"] = getThumbnail ?? "null";

      // thumbnailHash.add(thumbnail);
      // print("file: ${path.basename(x)}");

      print("*" * 100);
    }

    for (var x in thumbnailHash) {
      print(x.toString());
      print("-" * 70);
    }

    print("operation completed !!!!");
    print(thumbnailHash.length);
    print(videos.length);
    // print("*" * 50);
  }

// _getData() async {
//   File file = File(widget.file.path);
//   int fileSize = await file.length();
//
//   // var x = await file.stat();
//   videoSize = FileManager.formatBytes(fileSize, 2);
//   String tempPath = widget.file.path;
//   // /storage/emulated/0/Movies/Whatsapp/VID-20231022-WA0000.mp4
//   // print(widget.file.path);
//   thumbnailPath = await FileManager.getThumbnail(tempPath);
//   // setState(() {
//   //   _loading = false;
//   // });
//
//   return thumbnailPath;
// }


// favourites


}
