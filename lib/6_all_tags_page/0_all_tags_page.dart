// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../2_root/1_root_model.dart';
import '../2_root/3_root_provider.dart';
import '../3_home/Folders/home_folders.dart';

class AllTagPage extends StatelessWidget {
  const AllTagPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<RootProvider>(context, listen: true);
    if (rp.data!.tags == null) {
      return Container();
    }
    if (rp.data!.tags!.isEmpty) {
      return Container();
    }
    final List<Tag> tags = rp.data!.tags!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('all tags'),
      ),
      body: GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: tags.length, // Specify the number of items in the grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.5, // Specify the aspect ratio of each item
        ),
        itemBuilder: (BuildContext context, int index) {
          // Return the desired widget for each item in the grid
          return TagFolder(tags[index]);
        },
      ),
    );
  }
}
