// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../2_root/3_root_provider.dart';
import '../5_details_page/photo_details_page.dart';

class ShowRecent extends StatelessWidget {
  const ShowRecent({super.key});

  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<RootProvider>(context);
    if (rp.data!.photos == null || rp.data!.photos!.isEmpty) {
      return Container();
    }
    final List<String> p_paths = rp.data!.photos!;
    // final List<Widget> p_widgets = p_paths.map((e) => ImageTile(e)).toList();
    // return StaggeredGrid.count(
    //   crossAxisCount: 3,
    //   mainAxisSpacing: 10,
    //   crossAxisSpacing: 10,
    //   children: p_widgets,
    // );
    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: p_paths.length, // Specify the number of items in the grid
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.5, // Specify the aspect ratio of each item
      ),
      itemBuilder: (BuildContext context, int index) {
        // Return the desired widget for each item in the grid
        return ImageTile(p_paths[index]);
      },
    );
  }
}

class ImageTile extends StatelessWidget {
  final String path;
  const ImageTile(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return PhotoDetailsPage(photo_path: path);
        }));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(path),
          fit: BoxFit.cover,
          cacheHeight: 1000,
          cacheWidth: 500,
        ),
      ),
    );
  }
}
