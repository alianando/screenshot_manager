// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class PermissionProvider extends ChangeNotifier {
  bool storage_permission = false;
  void setStoragePermission(bool state) {
    if (storage_permission != state) {
      storage_permission = state;
      notifyListeners();
    }
  }
}
