import 'package:africa/Constants/colors.dart';
import 'package:africa/Constants/icons.dart';
import 'package:africa/Interfaces/MacOS/Controller/page_controller.dart';
import 'package:africa/Screen/Browse/Components/header.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

import 'macos_header.dart';

class BrowseContentArea extends StatefulWidget {
  const BrowseContentArea({Key? key}) : super(key: key);

  @override
  State<BrowseContentArea> createState() => _BrowseContentAreaState();
}

class _BrowseContentAreaState extends State<BrowseContentArea> {
  final carouselController = CarouselController();

  final scrollController = ScrollController();

  final currentPageNotifier = ValueNotifier<int>(0);

  var controller = Get.put(ContentAreaController());

  @override
  Widget build(BuildContext context) {
    // controller.contentArea.value.item
    return Obx(() => controller.contentArea.value.item == null
        ? const Center(
            child: Text('Click on an item to see the details here.'),
          )
        : CupertinoPageScaffold(
            backgroundColor: AppColors.kWhiteColor,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: AppColors.kWhiteColor.withAlpha(180),
              automaticallyImplyLeading: true,
              previousPageTitle: 'Browse',
              leading: Visibility(
                visible: controller.contentArea.value.isFullView == true
                    ? true
                    : false,
                child: CupertinoButton(
                  onPressed: () {
                    MacosWindowScope.of(context).toggleSidebar();
                    controller.contentArea.value.isFullView = false;
                  },
                  padding: const EdgeInsets.only(left: 75),
                  child: const Icon(
                    AppIcons.kSideBarIcon,
                    size: 25,
                    color: AppColors.kGreyColor,
                  ),
                ),
              ),
              middle: Text(
                'Learn about ${controller.contentArea.value.item[controller.contentArea.value.itemIndex].name}',
                style: const TextStyle(color: AppColors.kBlackColor),
              ),
            ),
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.only(bottom: 80),
              children: [
                Image.asset(controller.contentArea.value
                    .item[controller.contentArea.value.itemIndex].image),

                //Animal name widget
                SizedBox(
                  height: 65,
                  child: Center(
                    child: Text(
                      controller.contentArea.value
                          .item[controller.contentArea.value.itemIndex].name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                          color: AppColors.kBlackColor,
                          decorationColor: AppColors.kAccentColor),
                    ),
                  ),
                ),

                //Headline
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 10),
                  child: Text(
                    controller.contentArea.value
                        .item[controller.contentArea.value.itemIndex].headline,
                    style: const TextStyle(
                        fontSize: 17,
                        color: AppColors.kAccentColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none),
                  ),
                ),

                //MacOsHeader
                const MacOsHeader(
                    icon: AppIcons.kGalleryIcon,
                    title: "Wilderness In Pictures"),

                //Carousel Images
                Align(
                  child: CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount: 4,
                    itemBuilder: (context, galleryIndex, pageIndex) {
                      return controller.contentArea.value.item.isEmpty
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                image: DecorationImage(
                                    image: AssetImage(controller
                                        .contentArea
                                        .value
                                        .item[controller
                                            .contentArea.value.itemIndex]
                                        .gallery[galleryIndex]),
                                    fit: BoxFit.cover),
                              ),
                            );
                    },
                    options: CarouselOptions(
                      viewportFraction: 0.93,
                      enableInfiniteScroll: false,
                    ),
                  ),
                ),

                //Facts MacOsHeader
                const MacOsHeader(
                    icon: AppIcons.kQuestionIcon, title: 'Did You Know?'),

                //Facts StackView with Indicator
                Stack(
                  children: [
                    CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: controller
                          .contentArea
                          .value
                          .item[controller.contentArea.value.itemIndex]
                          .fact
                          .length,
                      itemBuilder: (context, factIndex, pageIndex) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: AppColors.kLightBackgroundColor,
                          ),
                          child: Center(
                            child: Text(
                              controller
                                  .contentArea
                                  .value
                                  .item[controller.contentArea.value.itemIndex]
                                  .fact[factIndex],
                              style: const TextStyle(
                                fontSize: 17,
                                color: AppColors.kBlackColor,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                          viewportFraction: 0.9,
                          padEnds: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, cpcr) {
                            setState(() {
                              currentPageNotifier.value = index;
                            });
                          }),
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 20.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CirclePageIndicator(
                          itemCount: controller
                              .contentArea
                              .value
                              .item[controller.contentArea.value.itemIndex]
                              .fact
                              .length,
                          currentPageNotifier: currentPageNotifier,
                        ),
                      ),
                    ),
                  ],
                ),

                //Description MacOsHeader
                MacOsHeader(
                  icon: AppIcons.kInfoIcon,
                  title:
                      'All About ${controller.contentArea.value.item[controller.contentArea.value.itemIndex].name}',
                ),

                //Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    controller
                        .contentArea
                        .value
                        .item[controller.contentArea.value.itemIndex]
                        .description,
                    style: const TextStyle(
                      fontSize: 17,
                      color: AppColors.kBlackColor,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),

                //National Parks MacOsHeader
                const MacOsHeader(
                    icon: AppIcons.kUnfilledMapIcon, title: 'National Parks'),

                //National Parks on MapView
                // Container(
                //   height: 250,
                //   margin: const EdgeInsets.symmetric(horizontal: 20),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(13),
                //     color: AppColors.kLightBackgroundColor,
                //   ),
                //   child: const GoogleMap(
                //       initialCameraPosition:
                //           CameraPosition(
                //  zoom: 14.4746,
                //target: LatLng(-2.3333333, 34.8333333))),
                // ),

                //Learn More MacOsHeader
                const MacOsHeader(
                    icon: AppIcons.kLearnMoreIcon, title: 'Learn More'),

                //Link to animal wikipedia
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: AppColors.kLightBackgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Start View
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            AppIcons.kWorldIcon,
                            color: AppColors.kBlackColor,
                          ),
                          Text(
                            ' Wikipedia',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.kBlackColor,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          final Uri url = Uri.parse(controller
                              .contentArea
                              .value
                              .item[controller.contentArea.value.itemIndex]
                              .link);
                          if (!await launchUrl(url)) {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              AppIcons.kLinkIcon,
                              size: 18,
                              color: AppColors.kAccentColor,
                            ),
                            Text(
                              ' ${controller.contentArea.value.item[controller.contentArea.value.itemIndex].name}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.kAccentColor,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
  }
}
