// ignore_for_file: deprecated_member_use

import 'package:africa/Constants/colors.dart';
import 'package:africa/Constants/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimalListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetImage;

  const AnimalListItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.assetImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: AssetImage(assetImage), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: AppColors.kAccentColor,
                      fontSize: 22,
                      height: 1.5,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  subtitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          const Icon(
            AppIcons.kChevronRight,
            color: AppColors.kGreyColor,
            size: 18,
          )
        ],
      ),
    );
  }
}
