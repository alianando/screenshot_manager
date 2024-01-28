import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/2_root/1_root_model.dart';
import 'package:screenshot_manager/3_home/show_recent.dart';

import '../../2_root/3_root_provider.dart';

class SelectedFolderPage extends StatefulWidget {
  final Tag tag;
  const SelectedFolderPage({super.key, required this.tag});

  @override
  State<SelectedFolderPage> createState() => _SelectedFolderPageState();
}

class _SelectedFolderPageState extends State<SelectedFolderPage> {
  @override
  Widget build(BuildContext context) {
    List<String> photos = widget.tag.photos ?? [];
    List<Widget> photoWidgetsList = [];
    for (int i = 0; i < photos.length; i++) {
      photoWidgetsList.add(ImageTile(photos[i]));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.tag.title}'),
        actions: [
          IconButton(
            onPressed: () {
              final rp = Provider.of<RootProvider>(context, listen: false);
              RootModel data = rp.data!;
              List<Tag> tags = data.tags ?? [];
              tags.removeWhere((t) => t.title == widget.tag.title);
              rp.data = data;
              Navigator.pop(context);
              rp.update_data(refresh: true);
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StaggeredGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: photoWidgetsList,
          ),
        ),
      ),
    );
  }
}
