import 'package:africa/Constants/colors.dart';
import 'package:africa/Constants/icons.dart';
import 'package:africa/Core/json_bundle.dart';
import 'package:africa/Interfaces/MacOS/Page/WatchPage/macos_video_item.dart';
import 'package:africa/Model/videos_model.dart';
import 'package:africa/Screen/Watch/Components/video_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class WatchSideBar extends StatefulWidget {
  final ScrollController scrollController;
  const WatchSideBar({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<WatchSideBar> createState() => _WatchSideBarState();
}

class _WatchSideBarState extends State<WatchSideBar> {
  bool isShuffle = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            backgroundColor: const Color(0xFFF2F2F7),
            padding: const EdgeInsetsDirectional.only(end: 5),
            automaticallyImplyLeading: false,
            border: const Border(),
            largeTitle: const Text(
              'Videos',
              style: TextStyle(color: AppColors.kBlackColor),
            ),
            leading: CupertinoButton(
              onPressed: () {
                // controller.contentArea.value.isFullView = true;
                MacosWindowScope.of(context).toggleSidebar();
              },
              padding: EdgeInsets.zero,
              child: const Icon(
                AppIcons.kSideBarIcon,
                size: 25,
                color: AppColors.kAccentColor,
              ),
            ),
            trailing: CupertinoButton(
              onPressed: () {
                if (isShuffle == false) {
                  setState(() {
                    isShuffle = true;
                  });
                }
    
                setState(() {
                  isShuffle = false;
                });
              },
              padding: EdgeInsets.zero,
              child: const Icon(AppIcons.kShuffleIcon,
                  size: 27, color: AppColors.kAccentColor),
            ),
          ),
        ],
        body: FutureBuilder(
            future: Bundle.videosList(),
            builder: (context, snapshot) {
              final items = snapshot.data as List<Video>?;
    
              if (snapshot.hasData) {
                items!.length;
    
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: ListView.separated(
                    controller: widget.scrollController,
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 8.0),
                    itemCount: items.length,
                    shrinkWrap: true,
                    primary: false,
                    separatorBuilder: (context, index) {
                      return const Divider(height: 5);
                    },
                    itemBuilder: (context, index) {
                      final sortedItems =
                          isShuffle ? items.reversed.toList() : items;
    
                      final item = sortedItems[index];
    
                      return Material(
                        surfaceTintColor: Colors.transparent,
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: MacOsVideoItem(
                            title: item.name ?? '',
                            subtitle: item.headline ?? '',
                            assetImage: item.thumbnail ?? '',
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            }),
      ),
    );
  }
}
