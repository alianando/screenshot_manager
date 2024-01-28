// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot_manager/1_permission/1_ask_permission.dart';

class CheckPermission extends StatefulWidget {
  final Widget nextPage;
  const CheckPermission({super.key, required this.nextPage});

  @override
  State<CheckPermission> createState() => _CheckPermissionState();
}

class _CheckPermissionState extends State<CheckPermission> {
  String storage_permission = 'checking';

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<bool> checkPermission() async {
    // this only works for android 13.
    // if 11 or 12 support needed see this youtube video
    // https://www.youtube.com/watch?v=nm19xnXdv2A
    var externalStorageStatus = await Permission.manageExternalStorage.status;
    if (externalStorageStatus.isGranted) {
      setState(() => storage_permission = 'granted');
      return true;
    } else {
      setState(() => storage_permission = 'denied');
    }
    Permission.manageExternalStorage.onGrantedCallback(
      () => setState(() => storage_permission = 'granted'),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (storage_permission == 'checking') return const Loading();
    if (storage_permission == 'granted') return widget.nextPage;
    return const AskPermission();
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Checking permission............')),
    );
  }
}
