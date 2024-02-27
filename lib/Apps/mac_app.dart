import 'package:africa/Constants/colors.dart';
import 'package:africa/Constants/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import '../Interfaces/MacOS/Page/BrowsePage/macos_browse_view.dart';
import '../Interfaces/MacOS/Page/GalleryPage/macos_gallery_view.dart';
import '../Interfaces/MacOS/Page/WatchPage/macos_watch_view.dart';


class MacOSApp extends StatelessWidget {
   MacOSApp({Key? key}) : super(key: key);

  final List tabs = [
      const MacOSBrowseView(),
      const MacOsWatchView(),
      const MacOsGalleryView(),
    ];

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      theme: MacosThemeData.light(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: AppColors.kWhiteColor.withAlpha(180),
        activeColor: AppColors.kAccentColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(AppIcons.kBrowseIcon), label: 'Browse'),
          BottomNavigationBarItem(
              icon: Icon(AppIcons.kWatchIcon), label: 'Watch'),
          BottomNavigationBarItem(
              icon: Icon(AppIcons.kGalleryIcon), label: 'Gallery'),
          // BottomNavigationBarItem(icon: Icon(AppIcons.kMapIcon), label: 'Map'),
        ],
      ),
      tabBuilder: (context, index) {
        return tabs[index];
      },
    ),
    );
  }
}

