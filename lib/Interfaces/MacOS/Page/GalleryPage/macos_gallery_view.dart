import 'package:africa/Constants/colors.dart';
import 'package:africa/Core/json_bundle.dart';
import 'package:africa/Model/animal_model.dart';
import 'package:flutter/cupertino.dart';

class MacOsGalleryView extends StatefulWidget {
  const MacOsGalleryView({Key? key}) : super(key: key);

  @override
  State<MacOsGalleryView> createState() => _MacOsGalleryViewState();
}

class _MacOsGalleryViewState extends State<MacOsGalleryView> {
  final keys = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int axisCount = 3;
  int selectedIndex = 0;
  double sliverValue = 50;
  // @override

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: const Color(0xFFF2F2F7),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color(0xFFF2F2F7).withAlpha(180),
          middle: const Text(
            'Gallery',
            style: TextStyle(color: AppColors.kBlackColor),
          ),
        ),
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
                padding: const EdgeInsets.only(top: 30, bottom: 55),
                primary: false,
                controller: ScrollController(),
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      height: MediaQuery.of(context).size.width - 550,
                      width: MediaQuery.of(context).size.width - 550,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500),
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: axisCount,
                      mainAxisSpacing: 50.0,
                      crossAxisSpacing: 50.0,
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
                            borderRadius: BorderRadius.circular(400),
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
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ));
  }
}
