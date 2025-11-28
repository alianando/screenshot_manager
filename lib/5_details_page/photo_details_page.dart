// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/5_details_page/photo_details_utils.dart';

import '../2_root/1_root_model.dart';
import '../2_root/3_root_provider.dart';

class PhotoDetailsPage extends StatelessWidget {
  final String photo_path;
  const PhotoDetailsPage({super.key, required this.photo_path});

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final rp = Provider.of<RootProvider>(context, listen: false);
              RootModel data = rp.data!;
              data.photos!.removeWhere((path) => path == photo_path);
              List<Tag> tags = data.tags ?? [];
              for (int i = 0; i < tags.length; i++) {
                List<String> photoPaths = tags[i].photos ?? [];
                photoPaths.removeWhere((path) => path == photo_path);
                data.tags![i].photos = photoPaths;
              }
              rp.data = data;
              rp.update_data(refresh: false);
              File(photo_path).delete();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Alarm fiture will be added very soon"),
                duration: Duration(milliseconds: 600),
              ));
            },
            icon: const Icon(Icons.alarm),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // const SizedBox(height: 5),
                // SizedBox(height: height * 0.05),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(photo_path),
                    width: width * 0.70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                // name(),
                const AddDescription(),
                const SizedBox(height: 10),
                TagButtons(photo_path: photo_path),
                const SizedBox(height: 300),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget name() {
    String file_name = photo_path.split('/').last;
    return Align(alignment: Alignment.topLeft, child: Text(file_name));
  }
}

class AddDescription extends StatefulWidget {
  const AddDescription({super.key});

  @override
  State<AddDescription> createState() => _AddDescriptionState();
}

class _AddDescriptionState extends State<AddDescription> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Add a description',
      ),
    );
  }
}

class TagButtons extends StatefulWidget {
  final String photo_path;
  const TagButtons({super.key, required this.photo_path});

  @override
  State<TagButtons> createState() => _TagButtonsState();
}

class _TagButtonsState extends State<TagButtons> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<RootProvider>(context);
    final data = rp.data;
    if (data!.tags == null) {
      return addTagButton(context, [], []);
    }
    if (data.tags!.isEmpty) {
      return addTagButton(context, [], []);
    }
    final availabe_tags = data.tags!;
    final tags = PDU.photo_contains_tag(data, widget.photo_path);
    if (tags.isEmpty) {
      return addTagButton(context, availabe_tags, []);
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            showBottomSheet(context, availabe_tags, tags);
          },
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text('Tags : '),
          ),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (_, index) {
              // return Center(child: Text(tags[index].title!));
              return TagWidget(tags[index]);
            },
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     showBottomSheet(context, availabe_tags, tags);
        //   },
        //   child: const Text(' add or edit tags '),
        // )
      ],
    );
  }

  Widget TagWidget(Tag tag) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10),
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Center(child: Text(tag.title!)),
        ),
      ),
    );
  }

  Widget addTagButton(
    BuildContext context,
    List<Tag> availabe_tags,
    List<Tag> applied_tags,
  ) {
    return SizedBox(
      width: 200,
      height: 40,
      child: OutlinedButton(
        onPressed: () {
          showBottomSheet(context, availabe_tags, applied_tags);
        },
        child: const Text('Add or edit tags'),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add tags'),
          content: TextField(
            onChanged: (value) {},
            controller: _controller,
            decoration: const InputDecoration(
              hintText: "tag name",
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                if (_controller.text.isNotEmpty) {
                  final rp = Provider.of<RootProvider>(context, listen: false);
                  rp.data!.tags!.add(
                    Tag(title: _controller.text, photos: [widget.photo_path]),
                  );
                  rp.set_data(rp.data!);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showBottomSheet(
    BuildContext context,
    List<Tag> availabe_tags,
    List<Tag> applied_tags,
  ) {
    String txtFildTxt = '';
    final rp = Provider.of<RootProvider>(context, listen: false);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: StatefulBuilder(
            builder: (context, setBottomSheet) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      onChanged: (value) {
                        setBottomSheet(() {
                          txtFildTxt = value;
                          debugPrint('value changed to $txtFildTxt');
                        });
                      },
                      onEditingComplete: () {
                        setBottomSheet(() {
                          txtFildTxt = _controller.text;
                        });
                      },
                      controller: _controller,
                      decoration: const InputDecoration(hintText: "tag name"),
                    ),
                  ),
                  if (txtFildTxt.isNotEmpty)
                    ListTile(
                      title: Text('+ add $txtFildTxt'),
                      onTap: () {
                        String tagName = txtFildTxt;
                        FocusScope.of(context).unfocus();
                        _controller.clear();
                        Navigator.pop(context);
                        Tag new_tag = Tag(
                          photos: [widget.photo_path],
                          title: tagName,
                        );
                        RootModel rm = rp.data!;
                        if (rm.tags == null) {
                          rm.tags = [new_tag];
                        } else {
                          rm.tags!.add(new_tag);
                        }
                        // debugPrint(
                        //     '##########################################');
                        // debugPrint(rp.data!.tags!.first.toJson().toString());
                        // debugPrint(
                        //     '##########################################');
                        rp.set_data(rp.data!);
                      },
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: availabe_tags.length,
                    itemBuilder: (_, index) {
                      final title = availabe_tags[index].title!;
                      bool active = PDU.list_contains_tag(applied_tags, title);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ListTile(
                          title: Text(title),
                          onTap: () {
                            if (active) {
                              rp.data!.tags![index].photos!.removeWhere(
                                (path) => path == widget.photo_path,
                              );
                            } else {
                              rp.data!.tags![index].photos!.add(
                                widget.photo_path,
                              );
                            }
                            rp.update_data(refresh: true);
                          },
                          trailing: active ? const Icon(Icons.done) : null,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
