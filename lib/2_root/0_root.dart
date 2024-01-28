// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/2_root/2_root_utils.dart';
import 'package:screenshot_manager/maintanance.dart';
import 'package:screenshot_manager/select_directories/select_directories_utils.dart';

import '../3_home/home.dart';
import '../select_directories/select_directories.dart';
import '3_root_provider.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    super.initState();
    RootUtils.get_data_from_storage(context);
  }

  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<RootProvider>(context, listen: true);
    if (SDU.is_initial_dir_selected_false(rp.data)) {
      return const SelectDerectories();
    }
    if (SDU.is_directories_empty(rp.data)) return const SelectDerectories();
    return const Home();
    // return const Maintanance();
  }
}
