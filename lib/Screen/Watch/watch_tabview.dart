// ignore_for_file: deprecated_member_use

import 'package:africa/Constants/colors.dart';
import 'package:africa/Constants/icons.dart';
import 'package:africa/Core/json_bundle.dart';
import 'package:africa/Model/videos_model.dart';
import 'package:africa/Screen/Watch/Widgets/video_player_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Components/video_list_item.dart';

class WatchTabView extends StatefulWidget {
  const WatchTabView({Key? key}) : super(key: key);

  @override
  State<WatchTabView> createState() => _WatchTabViewState();
}

class _WatchTabViewState extends State<WatchTabView> {
  @override
  Widget build(BuildContext context) {
    bool isShuffle = false;

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withAlpha(180),
            padding: const EdgeInsetsDirectional.only(end: 5),
            automaticallyImplyLeading: false,
            border: const Border(),
            largeTitle: Text(
              'Videos',
              style: TextStyle(color: Theme.of(context).textSelectionColor),
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
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 8.0),
                    itemCount: items.length,
                    shrinkWrap: true,
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
                          onTap: () {
                            Get.to(
                                () => VideoPlayerView(
                                      item: items,
                                      index: index,
                                    ),
                                transition: Transition.cupertino);
                          },
                          child: VideoListItem(
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
