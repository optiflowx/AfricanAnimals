import 'package:africa/Constants/colors.dart';
import 'package:africa/Constants/icons.dart';
import 'package:africa/Screen/Browse/browse_tabview.dart';
import 'package:africa/Screen/Gallery/gallery_tabview.dart';
import 'package:africa/Screen/Map/map_tabview.dart';
import 'package:africa/Screen/Watch/watch_tabview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AfricaApp extends StatelessWidget {
  const AfricaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List tabs = [
      const BrowseTabView(),
      const WatchTabView(),
      const GalleryTabView(),
      const MapTabView()
    ];

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).backgroundColor.withAlpha(180),
        activeColor: AppColors.kAccentColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(AppIcons.kBrowseIcon), label: 'Browse'),
          BottomNavigationBarItem(
              icon: Icon(AppIcons.kWatchIcon), label: 'Watch'),
          BottomNavigationBarItem(
              icon: Icon(AppIcons.kGalleryIcon), label: 'Gallery'),
          BottomNavigationBarItem(icon: Icon(AppIcons.kMapIcon), label: 'Map'),
        ],
      ),
      tabBuilder: (context, index) {
        return tabs[index];
      },
    );
  }
}
