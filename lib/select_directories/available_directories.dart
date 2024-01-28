// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/select_directories/select_directories_utils.dart';

import '../2_root/1_root_model.dart';
import '../2_root/3_root_provider.dart';

class AvailableDirectories extends StatefulWidget {
  const AvailableDirectories({super.key});

  @override
  State<AvailableDirectories> createState() => _AvailableDirectoriesState();
}

class _AvailableDirectoriesState extends State<AvailableDirectories> {
  List<String> avialable_directories = [];
  List<String> directories_to_look = [
    '/storage/emulated/0/DCIM/Screenshots',
    '/storage/emulated/0/DCIM/Facebook',
    '/storage/emulated/0/Pictures/Messenger',
    '/storage/emulated/0/Pictures/Twitter',
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images'
  ];
  List<String> directory_name_lookup = [
    'Screenshot',
    'Facebook',
    'Messenger',
    'Twitter',
    'WhatsApp'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkDirectories());
  }

  void checkDirectories() async {
    List<String> tempList = await getAvailableDirectories();
    debugPrint('########## checking directories');
    setState(() {
      avialable_directories = tempList;
    });
  }

  Future<List<String>> getAvailableDirectories() async {
    List<String> tempList = [];
    for (String path in directories_to_look) {
      bool exists = await SDU.directoryExists(path);
      if (exists) {
        tempList.add(path);
      }
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<RootProvider>(context, listen: true);
    if (avialable_directories.isEmpty) return Container();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: avialable_directories.length,
      itemBuilder: (_, index) {
        String path = avialable_directories[index];
        String dir_name = path.split('/').last;
        bool is_selected = rp.data?.directories!.contains(path) ?? false;
        return ListTile(
          title: Text(dir_name),
          onTap: () {
            RootModel new_rm = SDU.add_or_remove_location(rp.data, path);
            rp.set_data(new_rm);
          },
          trailing: Icon(
            Icons.select_all,
            color: is_selected ? Colors.amber : Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        );
      },
    );
  }
}
