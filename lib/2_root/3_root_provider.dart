// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:screenshot_manager/2_root/1_root_model.dart';
import 'package:screenshot_manager/2_root/2_root_utils.dart';

class RootProvider extends ChangeNotifier {
  RootModel? data;
  void set_data(RootModel rm) {
    data = rm;
    debugPrint(data!.toJson().toString());
    notifyListeners();
    save_data();
    debugPrint('#############/RootProvider/set_data -> complete.');
  }

  void update_data({bool refresh = true}) {
    save_data();
    if (refresh) {
      notifyListeners();
    }
  }

  void save_data() {
    if (data == null) return;
    RootUtils.save_data_in_storage(data!);
  }
}
