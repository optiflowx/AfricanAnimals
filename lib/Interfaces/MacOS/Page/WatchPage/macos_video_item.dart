// ignore_for_file: deprecated_member_use

import 'package:africa/Constants/colors.dart';
import 'package:flutter/cupertino.dart';

class MacOsVideoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetImage;

  const MacOsVideoItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.assetImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 72,
                width: 92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.kAccentColor,
                  image: DecorationImage(
                      image: AssetImage(assetImage), fit: BoxFit.cover),
                ),
              ),
              const Icon(
                CupertinoIcons.play_circle,
                size: 30,
                color: AppColors.kWhiteColor,
              ),
            ],
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
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  maxLines: 2,
                  style: const TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
