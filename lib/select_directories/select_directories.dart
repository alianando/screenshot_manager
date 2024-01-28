// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/select_directories/available_directories.dart';
import 'package:screenshot_manager/select_directories/select_directories_utils.dart';

import '../2_root/3_root_provider.dart';

class SelectDerectories extends StatefulWidget {
  const SelectDerectories({super.key});

  @override
  State<SelectDerectories> createState() => _SelectDerectoriesState();
}

class _SelectDerectoriesState extends State<SelectDerectories> {
  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<RootProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Select folders to show photos from',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Divider(),
              const AvailableDirectories(),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 20),
                  child: OutlinedButton(
                    onPressed: () {
                      if (SDU.is_directories_empty(rp.data)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select atleast one folder"),
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      } else {
                        rp.set_data(SDU.set_initial_dir_selected_true(rp.data));
                      }
                    },
                    child: const Text('Done'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
