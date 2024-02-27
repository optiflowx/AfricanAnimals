// ignore_for_file: deprecated_member_use
import 'package:africa/Constants/colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final IconData icon;
  final String title;
  const Header({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.kAccentColor,
            size: 28,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textSelectionColor,
                decoration: TextDecoration.none),
          )
        ],
      ),
    );
  }
}
