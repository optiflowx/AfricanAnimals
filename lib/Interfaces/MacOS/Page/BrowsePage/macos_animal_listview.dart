import 'package:africa/Core/json_bundle.dart';
import 'package:africa/Interfaces/MacOS/Controller/page_controller.dart';
import 'package:africa/Interfaces/MacOS/Page/BrowsePage/macos_animal_item.dart';
import 'package:africa/Model/animal_model.dart';
import 'package:africa/Screen/Browse/Components/animal_list_item.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MacOsAnimalListView extends StatelessWidget {
  const MacOsAnimalListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ContentAreaController());

    return FutureBuilder(
      future: Bundle.animalList(),
      builder: (context, snapshot) {
        final item = snapshot.data as List<Animal>?;

        if (snapshot.hasData) {
          return SafeArea(
            top: false,
            child: ListView.separated(
              itemCount: item?.length ?? 0,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (ctx, index) {
                return const Divider(height: 0.8);
              },
              itemBuilder: (ctx, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.contentArea.update((val) {
                        val!.itemIndex = index;
                        val.item = item;
                      });
                    },
                    child: FadeInLeft(
                      child: MacOsAnimalItem(
                        assetImage: item![index].image ?? '',
                        title: item[index].name ?? '',
                        subtitle: item[index].headline ?? '',
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center();
      },
    );
  }
}
