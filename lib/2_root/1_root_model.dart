// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class RootModel {
  List<String>? directories;
  bool? initial_dir_selected;
  List<String>? photos;
  List<Tag>? tags;
  RootModel({
    this.directories,
    this.initial_dir_selected,
    this.photos,
    this.tags,
  });

  factory RootModel.fromJson(Map<String, dynamic> json) {
    List<String> dir = [];
    if (json.containsKey('directories')) {
      for (var i in json['directories']) {
        dir.add(i.toString());
      }
    }

    List<String> pho = [];
    if (json.containsKey('photos')) {
      for (var i in json['photos']) {
        pho.add(i.toString());
      }
    }
    List<Tag> tags = [];
    if (json.containsKey('tags')) {
      for (var i in json['tags']) {
        debugPrint('############################################### 1');
        debugPrint(i.runtimeType.toString());
        tags.add(Tag.fromJson(i));
        debugPrint('############################################### 2');
      }
    }
    return RootModel(
      directories: dir,
      initial_dir_selected: json['initial_dir_selected'] ?? false,
      photos: pho,
      tags: tags,
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    List<Map<String, dynamic>> tgs = [];
    if (tags != null) {
      for (int i = 0; i < tags!.length; i++) {
        tgs.add(tags![i].toJson());
      }
    }
    data['directories'] = directories ?? [];
    data['initial_dir_selected'] = initial_dir_selected ?? false;
    data['photos'] = photos ?? [];
    data['tags'] = tgs;
    return data;
  }
}

class Tag {
  String? title;
  List<String>? photos;
  Tag({this.title, this.photos});

  factory Tag.fromJson(Map<String, dynamic> json) {
    List<String> pho = [];
    if (json.containsKey('photos')) {
      for (var i in json['photos']) {
        pho.add(i.toString());
      }
    }
    return Tag(title: json['title'] ?? '', photos: pho);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title ?? '';
    json['photos'] = photos ?? [];
    return json;
  }
}

List<String> dynamic_to_string_list(List<dynamic> dynamic_list) {
  List<String> string_list = [];
  for (var i in dynamic_list) {
    string_list.add(i.toString());
  }
  return string_list;
}
