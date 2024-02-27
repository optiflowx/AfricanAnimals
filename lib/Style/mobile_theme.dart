// ignore_for_file: deprecated_member_use

import 'package:africa/Constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();


  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.kWhiteColor,
    backgroundColor: AppColors.kLightBackgroundColor,
    primaryColor: AppColors.kAccentColor,
    textSelectionColor: AppColors.kBlackColor
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.kBlackColor,
    backgroundColor: AppColors.kDarkBackgroundColor,
    primaryColor: AppColors.kAccentColor,
    textSelectionColor: AppColors.kWhiteColor
  );
}
