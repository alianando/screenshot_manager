// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:screenshot_manager/2_root/1_root_model.dart';

class SDU {
  static Future<bool> directoryExists(String path) async {
    bool exists = await Directory(path).exists();
    return exists;
  }

  static RootModel add_or_remove_location(RootModel? rm, String location) {
    debugPrint('################# add_or_remove_location');
    if (rm == null) {
      return RootModel(directories: [location]);
    }
    if (rm.directories == null) {
      rm.directories = [location];
      return rm;
    }
    if (rm.directories!.isEmpty) {
      rm.directories = [location];
      return rm;
    }
    if (rm.directories!.contains(location) == false) {
      rm.directories!.add(location);
      debugPrint(rm.toString());
      return rm;
    }
    rm.directories!.remove(location);
    return rm;
  }

  static bool is_directories_empty(RootModel? rm) {
    if (rm == null) {
      return true;
    }
    if (rm.directories == null) {
      return true;
    }
    if (rm.directories!.isEmpty) {
      return true;
    }
    return false;
  }

  static bool is_initial_dir_selected_false(RootModel? rm) {
    debugPrint('######### is_initial_dir_selected_false()');
    if (rm == null) {
      return true;
    }
    if (rm.initial_dir_selected == null) {
      return true;
    }
    if (rm.initial_dir_selected == false) {
      return true;
    }
    return false;
  }

  static RootModel set_initial_dir_selected_true(RootModel? rm) {
    if (rm == null) {
      return RootModel(initial_dir_selected: true);
    }
    rm.initial_dir_selected = true;
    return rm;
  }
}
