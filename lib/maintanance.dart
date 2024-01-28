// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/2_root/1_root_model.dart';

import '2_root/3_root_provider.dart';

/// use this when something is wrong.
/// or to check for something
class Maintanance extends StatefulWidget {
  const Maintanance({super.key});

  @override
  State<Maintanance> createState() => _MaintananceState();
}

class _MaintananceState extends State<Maintanance> {
  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<RootProvider>(context);
    final Tag tg = rp.data!.tags!.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintanence"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Maintanance',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Divider(),
              OutlinedButton(
                onPressed: () {
                  final Tag tg = Tag(title: 'test', photos: ['1']);
                  final RootModel rm = RootModel();
                  rm.tags = [];
                  rm.tags!.add(tg);
                  var logger = Logger();
                  logger.d(rm.toJson());
                },
                child: const Text('check tag button'),
              ),
              const Divider(),
              Center(child: TestFolderDesign(photo_paths: tg.photos!))
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Padding(
              //     padding: const EdgeInsets.only(right: 30, bottom: 20),
              //     child: OutlinedButton(
              //       onPressed: () {
              //         if (rp.data!.directories!.isEmpty) {}
              //       },
              //       child: const Text('Done'),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class TestFolderDesign extends StatelessWidget {
  final List<String> photo_paths;
  const TestFolderDesign({super.key, required this.photo_paths});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Transform.rotate(
                angle: -math.pi / 12,
                //angle: 0,
                child: Image.file(
                  File(photo_paths.first),
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            // if (photo_paths.length >= 2)
            Positioned(
              top: 30,
              left: 30,
              child: Transform.rotate(
                angle: -math.pi / 10,
                // angle: 0,
                // angle: 0,
                child: Image.file(
                  File(photo_paths[1]),
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            // if (photos.length >= 3)
            //   Transform.rotate(
            //     angle: -math.pi / 3,
            //     child: Image.file(File(photos[2])),
            //   ),
          ],
        ),
      ),
    );
  }
}
