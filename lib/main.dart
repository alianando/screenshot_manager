import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_manager/maintanance.dart';
import '1_permission/0_check_permission.dart';

import '2_root/0_root.dart';
import '2_root/3_root_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RootProvider>(
            create: (context) => RootProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const CheckPermission(nextPage: AppRoot()),
        // home: const Maintanance(),
      ),
    );
  }
}
