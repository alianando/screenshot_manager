import 'package:flutter/material.dart';
import 'package:screenshot_manager/2_root/2_root_utils.dart';
import 'package:screenshot_manager/3_home/show_recent.dart';

import '../4_settings/settings_page.dart';
import 'Folders/home_folders.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    RootUtils.refresh_photos_from_directories(context);
  }

  @override
  Widget build(BuildContext context) {
    // final rp = Provider.of<RootProvider>(context);
    // final RootModel data = rp.data!;
    return Scaffold(
      // appBar: AppBar(
      //   title: searchBox(),
      //   actions: const [SettingButton()],
      // ),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight * 1.2),
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // searchBox(),
                  const Spacer(),
                  searchBox(),
                  const Spacer(),
                  const SettingButton(),
                ],
              )),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Divider(),
              HomeFolders(),
              Divider(),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Recents'),
              ),
              SizedBox(height: 10),
              ShowRecent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return SizedBox(
      // height: 80,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextField(
          // controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: const TextStyle(fontSize: 14),
            // Add a clear button to the search bar
            // suffixIcon: IconButton(
            //   icon: const Icon(Icons.clear),
            //   onPressed: () {},
            //   // onPressed: () => _searchController.clear(),
            // ),
            // Add a search icon or button to the search bar
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Perform the search here
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const SettingsPage();
        }));
      },
      icon: const Icon(Icons.settings),
    );
  }
}
