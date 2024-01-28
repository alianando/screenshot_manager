// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../2_root/1_root_model.dart';
import '../2_root/3_root_provider.dart';
import 'select_directories_utils.dart';

class AddDirectory extends StatefulWidget {
  const AddDirectory({super.key});

  @override
  State<AddDirectory> createState() => _AddDirectoryState();
}

class _AddDirectoryState extends State<AddDirectory> {
  List<FileSystemEntity> directories = [];
  Directory currentDirectory = Directory('/storage/emulated/0');
  @override
  void initState() {
    super.initState();
    readCurrentDirectory();
  }

  void readCurrentDirectory() async {
    final List<FileSystemEntity> entities = await currentDirectory
        .list(
            // recursive: true,
            // followLinks: true,
            )
        .toList();
    if (entities.isEmpty) {
      debugPrint('No entities found');
      return;
    }

    List<FileSystemEntity> temporaryEntities = entities.where((element) {
      return !(element.path.endsWith('.jpg') ||
          element.path.endsWith('.jpeg') ||
          element.path.endsWith('.png') ||
          element.path.endsWith('.mp4') ||
          element.path.endsWith('.mkv') ||
          element.path.endsWith('.mp3') ||
          element.path.endsWith('.torrent') ||
          element.path.endsWith('.apk') ||
          element.path.endsWith('.pdf') ||
          element.path.endsWith('.otf'));
    }).toList();

    setState(() {
      directories = temporaryEntities;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<RootProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: directories.length,
            itemBuilder: (_, index) {
              String path = directories[index].path;
              String only_path = path.split('/').last;
              bool selected = rp.data?.directories!.contains(path) ?? false;
              return ListTile(
                onTap: () {
                  currentDirectory = Directory(path);
                  readCurrentDirectory();
                },
                title: Text(only_path),
                trailing: IconButton(
                  icon: Icon(
                    Icons.select_all,
                    color: selected ? Colors.amber : Colors.white,
                  ),
                  onPressed: () {
                    RootModel new_rm = SDU.add_or_remove_location(
                      rp.data,
                      path,
                    );
                    rp.set_data(new_rm);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
