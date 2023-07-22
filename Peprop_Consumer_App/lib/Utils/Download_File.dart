


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Download_File {
  String url="";
  var  _localPath;
  Download_File(String url) {
    this.url=url;

    download(url);


  }
  download(String url) async {
    var ios=await getApplicationDocumentsDirectory();
    var android=await getExternalStorageDirectory();

    bool _permissionReady = await checkPermission();
    if (_permissionReady) {
      try {
        await Dio().download(url,Platform.isAndroid ?android:ios.path + "/" + "filename.pdf");
        print("Download Completed.");
      } catch (e) {
        print("Download Failed.\n\n" + e.toString());
      }
    }

  }

  Future<bool>checkPermission() async {
    if (TargetPlatform.android == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
  _localPath = (await _findLocalPath())!;


    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (TargetPlatform.android  == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

}