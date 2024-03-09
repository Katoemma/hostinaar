import 'dart:core';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ProfilePicHelper {
  //Function save image locally fro supabase
  Future<File> downloadImage(String url) async {
    final cacheManager = DefaultCacheManager();
    File file = await cacheManager.getSingleFile(url);
    return file;
  }
}
