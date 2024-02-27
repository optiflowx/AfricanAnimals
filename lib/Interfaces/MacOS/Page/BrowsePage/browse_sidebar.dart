import 'package:africa/Constants/colors.dart';
import 'package:africa/Constants/icons.dart';
import 'package:africa/Interfaces/MacOS/Controller/page_controller.dart';
import 'package:africa/Interfaces/MacOS/Page/BrowsePage/macos_animal_listview.dart';
import 'package:africa/Screen/Browse/Widgets/animal_listview.dart';
import 'package:africa/Screen/Browse/Widgets/carousel_cover_image.dart';
import 'package:africa/Screen/Browse/Widgets/dynamic_gridview.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';

class BrowseSideBar extends StatefulWidget {
  final ScrollController scrollController;
  const BrowseSideBar({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<BrowseSideBar> createState() => _BrowseSideBarState();
}

class _BrowseSideBarState extends State<BrowseSideBar> {
  bool isListView = true;
  int axisCount = 2;
  var controller = Get.put(ContentAreaController());

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      child: NestedScrollView(
        controller: widget.scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            backgroundColor: const Color(0xFFF2F2F7),
            padding: const EdgeInsetsDirectional.only(end: 5),
            border: const Border(),
            largeTitle: const Text(
              'Browse',
              style: TextStyle(color: AppColors.kBlackColor),
            ),
            leading: CupertinoButton(
              onPressed: () {
                controller.contentArea.value.isFullView = true;
                MacosWindowScope.of(context).toggleSidebar();
              },
              padding: EdgeInsets.zero,
              child: const Icon(
                AppIcons.kSideBarIcon,
                size: 25,
                color: AppColors.kGreyColor,
              ),
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
                      size: 25,
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
                          size: 25,
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
                              size: 25,
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
                              size: 25,
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
            ? ListView(
                primary: false,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8.0),
                children: const [
                  CarouselCoverImage(),
                  MacOsAnimalListView(),
                ],
              )
            : DynamicGridView(
                axisCount: axisCount,
              ),
      ),
    );
  }
}
