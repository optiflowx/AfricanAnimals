import 'dart:io';

import 'package:africa/Core/json_bundle.dart';
import 'package:africa/Interfaces/MacOS/Controller/page_controller.dart';
import 'package:africa/Model/animal_model.dart';
import 'package:africa/Screen/Browse/animal_details_view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DynamicGridView extends StatefulWidget {
  final int axisCount;
  const DynamicGridView({Key? key, required this.axisCount}) : super(key: key);

  @override
  State<DynamicGridView> createState() => _DynamicGridViewState();
}

class _DynamicGridViewState extends State<DynamicGridView> {
  var controller = Get.put(ContentAreaController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Bundle.animalList(),
        builder: (ctx, snapshot) {
          final item = snapshot.data as List<Animal>?;

          if (snapshot.hasData) {
            return FadeInUpBig(
              // delay: const Duration(milliseconds: 800),
              child: GridView.builder(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 8, bottom: 60),
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.axisCount,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 14 / 9),
                itemCount: item?.length,
                itemBuilder: (ctx, index) {
                  item!.length;
                  return GestureDetector(
                    onTap: () {
                      Platform.isMacOS
                          ? controller.contentArea.update((val) {
                              val!.itemIndex = index;
                              val.item = item;
                            })
                          : Get.to(
                              () => AnimalDetailsView(
                                    item: item,
                                    itemIndex: index,
                                  ),
                              transition: Transition.cupertino);
                    },
                    child: FadeInDown(
                      delay: const Duration(milliseconds: 250),
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: AssetImage(item[index].image ?? ''),
                              fit: BoxFit.cover),
                        ),
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
        });
  }
}
