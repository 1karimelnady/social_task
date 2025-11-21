import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_task/core/utils/colors_manager.dart';
import 'package:social_task/core/utils/text_style_manager.dart';

class ThemeManager {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyleManager.fontSize24FontWeight500(),
      displayMedium: TextStyleManager.fontSize22FontWeight500(),
      displaySmall: TextStyleManager.fontSize206FontWeight500(),
      titleMedium: TextStyleManager.fontSize16FontWeight500(),
      titleSmall: TextStyleManager.fontSize16FontWeight600(),
      bodyLarge: TextStyleManager.fontSize14FontWeight600(),
      bodyMedium: TextStyleManager.fontSize14FontWeight700(),
      bodySmall: TextStyleManager.fontSize12FontWeight500(),
    ),
    useMaterial3: false,
    fontFamily: GoogleFonts.cairo().fontFamily,

    appBarTheme: AppBarTheme(
      toolbarHeight: 200,
      color: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsManager.black, size: 24.sp),
      actionsIconTheme: const IconThemeData(color: ColorsManager.black),
      titleTextStyle: TextStyle(
        color: ColorsManager.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    tabBarTheme: const TabBarThemeData(
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
    ),
    scaffoldBackgroundColor: Colors.white,
    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(color: ColorsManager.primaryColor, width: .2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.all(ColorsManager.primaryColor),
      fillColor: WidgetStateProperty.all(ColorsManager.white),
    ),

    primaryColor: ColorsManager.primaryColor,
    inputDecorationTheme: _inputDecorationTheme,
    elevatedButtonTheme: _elevatedButtonTheme(context),
  );
}

final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10),
  prefixIconColor: ColorsManager.iconColor,
  suffixIconColor: ColorsManager.iconColor,
  hintStyle: TextStyleManager.fontSize14FontWeight600(
    color: ColorsManager.iconColor,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.r),
    borderSide: const BorderSide(color: ColorsManager.textFieldBorderColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.r),
    borderSide: const BorderSide(color: ColorsManager.textFieldBorderColor),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: const BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: const BorderSide(
      color: ColorsManager.textFieldActiveBorderColor,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: const BorderSide(color: ColorsManager.primaryColor),
  ),
);

ElevatedButtonThemeData _elevatedButtonTheme(BuildContext context) =>
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primaryColor,
        fixedSize: Size(343.w, 40.h),
        textStyle: TextStyleManager.fontSize16FontWeight600(
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
