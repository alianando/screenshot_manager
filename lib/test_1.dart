// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  List<FileSystemEntity> entries = [];
  @override
  void initState() {
    super.initState();
    readAllFile();
  }

  void readAllFile() async {
    final dir = Directory('/storage/emulated/0/DCIM/Screenshots');
    final List<FileSystemEntity> entities = await dir
        .list(
          recursive: true,
          followLinks: true,
        )
        .toList();
    debugPrint(entities.length.toString());
    if (entities.isEmpty) {
      debugPrint('No entities found');
      return;
    }
    for (FileSystemEntity f in entities) {
      debugPrint('#######################');
      debugPrint(f.toString());
    }
    List<FileSystemEntity> foundPhotos = [];
    foundPhotos = entities.where((e) => e.path.endsWith('.jpg')).toList();
    foundPhotos.sort((a, b) => b.path.compareTo(a.path));
    setState(() {
      entries = foundPhotos;
    });
  }

  List<Widget> childs = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> imageWidgetList = [];
    for (var item in entries) {
      imageWidgetList.add(_ImageTile(item.path));
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              children: imageWidgetList,
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  final String path;
  const _ImageTile(this.path);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // debugPrint("hello");
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ScreenshotDetailsPage(screenshot_path: path);
        }));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ScreenshotDetailsPage extends StatefulWidget {
  final String screenshot_path;
  const ScreenshotDetailsPage({super.key, required this.screenshot_path});

  @override
  State<ScreenshotDetailsPage> createState() => _ScreenshotDetailsPageState();
}

class _ScreenshotDetailsPageState extends State<ScreenshotDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(widget.screenshot_path),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(widget.screenshot_path),
            const SizedBox(height: 300)
          ],
        ),
      ),
    );
  }
}
