// ignore_for_file: import_of_legacy_library_into_null_safe, deprecated_member_use

import 'package:africa/Constants/colors.dart';
import 'package:africa/Core/json_bundle.dart';
import 'package:africa/Model/animal_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryTabView extends StatefulWidget {
  const GalleryTabView({Key? key}) : super(key: key);

  @override
  State<GalleryTabView> createState() => _GalleryTabViewState();
}

class _GalleryTabViewState extends State<GalleryTabView> {
  final keys = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int axisCount = 3;
  int selectedIndex = 0;
  double sliverValue = 50;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withAlpha(180),
            middle: Text(
              'Gallery',
              style: TextStyle(color: Theme.of(context).textSelectionColor),
            )),
        child: FutureBuilder(
          future: Bundle.animalList(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final item = snapshot.data as List<Animal>?;
              return ListView(
                padding: const EdgeInsets.only(top: 65, bottom: 85),
                primary: false,
                controller: ScrollController(keepScrollOffset: false),
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 25),
                      height: MediaQuery.of(context).size.width - 100,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border: Border.all(
                            width: 5, color: AppColors.kLightBackgroundColor),
                        image: DecorationImage(
                            image: AssetImage(item![selectedIndex].image ?? ''),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  CupertinoSlider(
                    value: sliverValue,
                    min: 1,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        sliverValue = value;
                      });

                      if (sliverValue < 10) {
                        setState(() {
                          axisCount = 2;
                        });
                      } else if (sliverValue >= 40 && sliverValue <= 60) {
                        setState(() {
                          axisCount = 3;
                        });
                      } else if (sliverValue > 90) {
                        setState(() {
                          axisCount = 4;
                        });
                      }
                    },
                    divisions: 2,
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: axisCount,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                    ),
                    itemCount: item.length,
                    itemBuilder: (ctx, index) {
                      // item!.length;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 5,
                                color: AppColors.kLightBackgroundColor),
                            image: DecorationImage(
                                image: AssetImage(item[index].image ?? ''),
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );

              /// []
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ));
  }
}
