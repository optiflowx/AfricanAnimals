import 'dart:io';
import 'package:africa/Style/mobile_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Apps/africa_app.dart';
import 'Apps/mac_app.dart';

void main() {
  runApp(
    WidgetsApp(
      color: Colors.white,
      builder: (ctx, widget) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isMacOS ||
            //iPadOS (Works!)
            (Platform.isIOS && MediaQuery.of(context).size.width > 450)
        ? MacOSApp()
        // Mobile Application(iPhone and Android)
        : GetMaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: const AfricaApp(),
          );
  }
}
