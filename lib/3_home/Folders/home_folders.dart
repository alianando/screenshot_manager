import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/2_root/1_root_model.dart';
import 'package:screenshot_manager/3_home/Folders/selected_folder_page.dart';

import '../../2_root/3_root_provider.dart';
import '../../6_all_tags_page/0_all_tags_page.dart';

class HomeFolders extends StatelessWidget {
  const HomeFolders({super.key});

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const AllTagPage();
                }));
              },
              child: const Text('See all >'),
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (_, index) {
              return TagFolder(tags[index]);
            },
          ),
        ),
      ],
    );
  }
}

class TagFolder extends StatelessWidget {
  final Tag tag;
  const TagFolder(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SelectedFolderPage(tag: tag);
              }));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                child: Image.asset(
                  'assets/folder_icon/cloud_folder.png',
                  // color: Colors.blue,
                  width: 55,
                  // fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Text(
            '${tag.title}',
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
