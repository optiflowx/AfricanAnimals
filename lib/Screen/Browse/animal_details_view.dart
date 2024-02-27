// ignore_for_file: deprecated_member_use

import 'package:africa/Constants/colors.dart';
import 'package:africa/Constants/icons.dart';
import 'package:africa/Interfaces/MacOS/Controller/page_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Components/header.dart';

class AnimalDetailsView extends StatefulWidget {
  final dynamic item;
  final int itemIndex;
  AnimalDetailsView({Key? key, required this.itemIndex, required this.item})
      : super(key: key);

  @override
  State<AnimalDetailsView> createState() => _AnimalDetailsViewState();
}

class _AnimalDetailsViewState extends State<AnimalDetailsView> {
  final carouselController = CarouselController();

  final currentPageNotifier = ValueNotifier<int>(0);

  final controller = Get.put(ContentAreaController());

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        previousPageTitle: 'Browse',
        middle: Text(
          'Learn about ${widget.item[widget.itemIndex].name}',
          style: TextStyle(
            color: Theme.of(context).textSelectionColor,
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 30),
        children: [
          Image.asset(widget.item[widget.itemIndex].image),

          //Animal name widget
          SizedBox(
            height: 65,
            child: Center(
              child: Text(
                widget.item[widget.itemIndex].name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    color: Theme.of(context).textSelectionColor,
                    decorationColor: AppColors.kAccentColor),
              ),
            ),
          ),

          //Headline
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10),
            child: Text(
              widget.item[widget.itemIndex].headline,
              style: const TextStyle(
                  fontSize: 17,
                  color: AppColors.kAccentColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none),
            ),
          ),

          //Header
          const Header(
              icon: AppIcons.kGalleryIcon, title: "Wilderness In Pictures"),

          //Carousel Images
          Align(
            child: CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: 4,
              itemBuilder: (context, galleryIndex, pageIndex) {
                return widget.item.isEmpty
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          image: DecorationImage(
                              image: AssetImage(widget.item[widget.itemIndex]
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

          //Facts Header
          const Header(icon: AppIcons.kQuestionIcon, title: 'Did You Know?'),

          //Facts StackView with Indicator
          Stack(
            children: [
              CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: widget.item[widget.itemIndex].fact.length,
                itemBuilder: (context, factIndex, pageIndex) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Center(
                      child: Text(
                        widget.item[widget.itemIndex].fact[factIndex],
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).textSelectionColor,
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
                    itemCount: widget.item[widget.itemIndex].fact.length,
                    currentPageNotifier: currentPageNotifier,
                  ),
                ),
              ),
            ],
          ),

          //Description Header
          Header(
              icon: AppIcons.kInfoIcon,
              title: 'All About ${widget.item[widget.itemIndex].name}'),

          //Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.item[widget.itemIndex].description,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).textSelectionColor,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),

          //National Parks Header
          const Header(
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

          //Learn More Header
          const Header(icon: AppIcons.kLearnMoreIcon, title: 'Learn More'),

          //Link to animal wikipedia
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Theme.of(context).backgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Start View
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      AppIcons.kWorldIcon,
                      color: Theme.of(context).textSelectionColor,
                    ),
                    Text(
                      ' Wikipedia',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {
                      _launchUrl();
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
                          ' ${widget.item[widget.itemIndex].name}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.kAccentColor,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _launchUrl() async {
    final Uri url = Uri.parse(widget.item[widget.itemIndex].link);
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }
}
