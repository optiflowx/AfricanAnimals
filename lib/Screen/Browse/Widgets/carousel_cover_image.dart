import 'dart:io';

import 'package:africa/Core/json_bundle.dart';
import 'package:africa/Model/cover_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class CarouselCoverImage extends StatefulWidget {
  const CarouselCoverImage({
    Key? key,
  }) : super(key: key);

  @override
  State<CarouselCoverImage> createState() => _CarouselCoverImageState();
}

class _CarouselCoverImageState extends State<CarouselCoverImage> {
  final carouselController = CarouselController();

  final pageController = PageController();

  final currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Bundle.coverImages(),
      builder: (context, snapshot) {
        //
        final item = snapshot.data as List<CoverImage>?;

        if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          item!.length;
          return Stack(
            children: [
              CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: item.length,
                itemBuilder: (context, index, pageIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(
                          image: AssetImage(item[index].name),
                          fit: BoxFit.cover),
                    ),
                    width: MediaQuery.of(context).size.width,
                  );
                },
                options: CarouselOptions(
                    viewportFraction: 1.0,
                    height: Platform.isMacOS ? 210 : 250,
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
                bottom: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CirclePageIndicator(
                    itemCount: item.length,
                    currentPageNotifier: currentPageNotifier,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            heightFactor: 10,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
