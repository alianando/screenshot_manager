// ignore_for_file: non_constant_identifier_names

import 'package:screenshot_manager/2_root/1_root_model.dart';

class PDU {
  static List<Tag> photo_contains_tag(RootModel? rm, String photo_path) {
    if (rm == null) {
      return [];
    }
    if (rm.tags == null) {
      return [];
    }
    if (rm.tags!.isEmpty) {
      return [];
    }
    List<Tag> tags = [];
    for (Tag t in rm.tags!) {
      if (t.photos == null) {
        continue;
      }
      if (t.photos!.isEmpty) {
        continue;
      }
      if (t.photos!.contains(photo_path)) {
        tags.add(t);
      }
    }
    return tags;
  }

  static bool list_contains_tag(List<Tag> tagList, String title) {
    bool contains = false;
    for (Tag t in tagList) {
      if (t.title == title) {
        contains = true;
      }
    }
    return contains;
  }
}
