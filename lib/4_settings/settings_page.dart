import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/2_root/1_root_model.dart';

import '../2_root/3_root_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              final rp = Provider.of<RootProvider>(context, listen: false);
              final data = rp.data;
              if (data == null) {
                return;
              }
              data.initial_dir_selected = false;
              rp.set_data(data);
              Navigator.pop(context);
            },
            title: const Text('Change locations'),
          ),
          ListTile(
            onTap: () {
              final rp = Provider.of<RootProvider>(context, listen: false);
              rp.set_data(
                RootModel(
                  directories: [],
                  initial_dir_selected: false,
                  photos: [],
                  tags: [],
                ),
              );
              Navigator.pop(context);
            },
            title: const Text('Reset everything'),
          ),
        ],
      ),
    );
  }
}
