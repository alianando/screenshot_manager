// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AskPermission extends StatelessWidget {
  const AskPermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('This app requires storage permission to work'),
              const SizedBox(height: 50),
              OutlinedButton(
                onPressed: () async {
                  await Permission.manageExternalStorage.request();
                },
                child: const Text('Grant Permission'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
