// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:africa/Constants/colors.dart';
import 'package:africa/Constants/icons.dart';
import 'package:africa/Style/mobile_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/animal_listview.dart';
import 'Widgets/carousel_cover_image.dart';
import 'Widgets/dynamic_gridview.dart';

class BrowseTabView extends StatefulWidget {
  const BrowseTabView({Key? key}) : super(key: key);

  @override
  State<BrowseTabView> createState() => _BrowseTabViewState();
}

class _BrowseTabViewState extends State<BrowseTabView> {
  bool isListView = true;
  int axisCount = 2;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: NestedScrollView(
        scrollBehavior: const ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
        ),
        controller: ScrollController(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withAlpha(180),
            padding: const EdgeInsetsDirectional.only(end: 5),
            border: const Border(),
            largeTitle: Text(
              'Browse',
              style: TextStyle(color: Theme.of(context).textSelectionColor),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isListView = true;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Icon(AppIcons.kListViewIcon,
                      size: 27,
                      color: isListView
                          ? AppColors.kAccentColor
                          : AppColors.kGreyColor),
                ),
                axisCount == 1
                    ? CupertinoButton(
                        onPressed: () {
                          setState(() {
                            isListView = false;
                            axisCount = 2;
                          });
                        },
                        padding: EdgeInsets.zero,
                        child: Icon(
                          AppIcons.kGrid1x1Icon,
                          size: 27,
                          color: isListView
                              ? AppColors.kGreyColor
                              : AppColors.kAccentColor,
                        ),
                      )
                    : axisCount == 2
                        ? CupertinoButton(
                            onPressed: () {
                              setState(() {
                                isListView = false;
                                axisCount = 3;
                              });
                            },
                            padding: EdgeInsets.zero,
                            child: Icon(
                              AppIcons.kGrid2x2Icon,
                              size: 27,
                              color: isListView
                                  ? AppColors.kGreyColor
                                  : AppColors.kAccentColor,
                            ),
                          )
                        : CupertinoButton(
                            onPressed: () {
                              setState(
                                () {
                                  isListView = false;
                                  axisCount = 1;
                                },
                              );
                            },
                            padding: EdgeInsets.zero,
                            child: Icon(
                              AppIcons.kGrid3x2Icon,
                              size: 27,
                              color: isListView
                                  ? AppColors.kGreyColor
                                  : AppColors.kAccentColor,
                            ),
                          ),
              ],
            ),
          ),
        ],
        body: isListView
            ? FadeInUpBig(
                child: ListView(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 8.0),
                  children: [
                    FadeIn(child: const CarouselCoverImage()),
                    const AnimalListView(),
                  ],
                ),
              )
            : DynamicGridView(
                axisCount: axisCount,
              ),
      ),
    );
  }
}
