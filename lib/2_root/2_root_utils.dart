// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/2_root/1_root_model.dart';
import 'package:screenshot_manager/2_root/3_root_provider.dart';
import 'package:screenshot_manager/select_directories/select_directories_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootUtils {
  static void get_data_from_storage(BuildContext context) async {
    debugPrint('##/RootUtils/get_data_from_storage -> ');
    final rp = Provider.of<RootProvider>(context, listen: false);
    final sp = await SharedPreferences.getInstance();
    final String? sp_data = sp.getString('data');
    if (sp_data == null || sp_data.isEmpty) {
      debugPrint(
        '##/RootUtils/get_data_from_storage -> no data found in storage',
      );
      return;
    }
    RootModel rm_data = RootModel.fromJson(jsonDecode(sp_data));
    rp.set_data(rm_data);
  }

  static void save_data_in_storage(RootModel rm) async {
    debugPrint('##/RootUtils/save_data_in_storage -> start.');
    final sp = await SharedPreferences.getInstance();
    String data = jsonEncode(rm.toJson());
    sp.setString('data', data);
    debugPrint('##/RootUtils/save_data_in_storage -> data :');
    var logger = Logger();
    logger.d(rm.toJson());
    debugPrint('##/RootUtils/save_data_in_storage -> complete.');
  }

  static void refresh_photos_from_directories(BuildContext context) async {
    debugPrint('##/RootUtils/refresh_photos_from_directories -> start');
    List<String> found_photos = [];
    final rp = Provider.of<RootProvider>(context, listen: false);
    final RootModel data = rp.data!;
    if (SDU.is_directories_empty(data)) {
      debugPrint(
        '##/RootUtils/refresh_photos_from_directories -> no directories found',
      );
      return;
    }
    final List<String> directories = rp.data!.directories!;
    for (String path in directories) {
      final dir = Directory(path);
      final List<FileSystemEntity> entities =
          await dir.list(recursive: true, followLinks: true).toList();
      if (entities.isEmpty) {
        debugPrint(
          '##/RootUtils/refresh_photos_from_directories -> No entities at $path',
        );
        continue;
      }
      for (FileSystemEntity entity in entities) {
        if (entity.path.endsWith('.jpg')) {
          found_photos.add(entity.path);
        }
      }
    }
    found_photos.sort((a, b) => b.compareTo(a));
    debugPrint(
      '##/RootUtils/refresh_photos_from_directories -> complete, photos -> ${found_photos.length}',
    );
    data.photos = found_photos;
    rp.set_data(data);
  }
}
