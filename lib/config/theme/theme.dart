// ignore_for_file: deprecated_member_use
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  static ThemeData light() => ThemeData(
        visualDensity: visualDensity,
        primaryColor: MyColor.bluePrimary,
        scaffoldBackgroundColor: MyColor.homeBodyColor,
        cardColor: MyColor.cardBackgroundColor,
        iconTheme: const IconThemeData(color: MyColor.textColor),
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: MyColor.textColor, size: 20.w),
          backgroundColor: MyColor.cardBackgroundColor,
          titleTextStyle: TextStyle(
            color: MyColor.textColor,
            fontSize: 16.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: MyColor.vibrantPurple,
          secondary: MyColor.skyPrimary,
          surface: MyColor.cardBackgroundColor,
          background: MyColor.homeBodyColor,
          onPrimary: MyColor.homeText2Color,
          onSecondary: MyColor.homeText2Color,
          onSurface: MyColor.textColor,
          onBackground: MyColor.textColor,
          error: MyColor.calorieRed,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: MyColor.textColor,
            fontFamily: MyString.poppinsMedium,
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
          ),
          displayMedium: TextStyle(
            color: MyColor.textColor,
            fontFamily: MyString.poppinsMedium,
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
            color: MyColor.textColor,
            fontFamily: MyString.poppinsMedium,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: MyColor.textColor,
            fontFamily: MyString.poppinsMedium,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            color: MyColor.textColor,
            fontSize: 16.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            fontSize: 14.sp,
            color: MyColor.textColor,
            fontFamily: MyString.poppinsRegular,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.sp,
            color: MyColor.textColor,
            fontFamily: MyString.rubikRegular,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.sp,
            color: MyColor.textColor,
            fontFamily: MyString.rubikRegular,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontSize: 12.sp,
            color: MyColor.textThird,
            fontFamily: MyString.rubikRegular,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontSize: 14.sp,
            color: MyColor.textThird,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
          labelMedium: TextStyle(
            fontSize: 12.sp,
            color: MyColor.textThird,
            fontFamily: MyString.poppinsRegular,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            fontSize: 10.sp,
            color: MyColor.inActiveColor,
            fontFamily: MyString.poppinsRegular,
            fontWeight: FontWeight.w400,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontSize: 14.sp,
            color: MyColor.textThird,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: MyColor.inActiveColor,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          filled: true,
          prefixIconColor: MyColor.skyPrimary,
          fillColor: MyColor.cardBackgroundColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: MyColor.vibrantPurple, width: 2.0.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: MyColor.dividerColor, width: 1.0.w),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: MyColor.calorieRed, width: 1.5.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: MyColor.calorieRed, width: 2.0.w),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            ),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return MyColor.inActiveColor;
              }
              return MyColor.vibrantPurple;
            }),
            foregroundColor: WidgetStateProperty.all(MyColor.homeText2Color),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: 16.sp,
                fontFamily: MyString.poppinsMedium,
                fontWeight: FontWeight.w600,
              ),
            ),
            elevation: WidgetStateProperty.all(0),
            shadowColor: WidgetStateProperty.all(MyColor.shadowMedium),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(MyColor.vibrantPurple),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: 14.sp,
                fontFamily: MyString.poppinsMedium,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: MyColor.dividerColor,
          thickness: 1.0.w,
          space: 1.0.h,
        ),
      );

  /// Dark theme and its settings.
  static ThemeData dark() => ThemeData.dark().copyWith(
        visualDensity: visualDensity,
        primaryColor: MyColor.homeText2Color,
        scaffoldBackgroundColor: MyColor.logBackColor,
        cardColor: MyColor.darkCardBackground,
        iconTheme: const IconThemeData(color: MyColor.homeText1Color),
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: MyColor.homeText1Color, size: 20.w),
          backgroundColor: MyColor.logBackColor,
          titleTextStyle: TextStyle(
            color: MyColor.homeText2Color,
            fontSize: 16.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: MyColor.vibrantPurple,
          secondary: MyColor.skyPrimary,
          surface: MyColor.darkCardBackground,
          background: MyColor.logBackColor,
          onPrimary: MyColor.homeText2Color,
          onSecondary: MyColor.homeText2Color,
          onSurface: MyColor.homeText1Color,
          onBackground: MyColor.homeText1Color,
          error: MyColor.calorieRed,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: MyColor.homeText2Color,
            fontFamily: MyString.poppinsMedium,
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
          ),
          displayMedium: TextStyle(
            color: MyColor.homeText2Color,
            fontFamily: MyString.poppinsMedium,
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
            color: MyColor.homeText2Color,
            fontFamily: MyString.poppinsMedium,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: MyColor.homeText2Color,
            fontFamily: MyString.poppinsMedium,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            color: MyColor.homeText2Color,
            fontSize: 16.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            fontSize: 14.sp,
            color: MyColor.homeText1Color,
            fontFamily: MyString.poppinsRegular,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.sp,
            color: MyColor.homeText1Color,
            fontFamily: MyString.rubikRegular,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.sp,
            color: MyColor.textSecondary,
            fontFamily: MyString.rubikRegular,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontSize: 12.sp,
            color: MyColor.textThird,
            fontFamily: MyString.rubikRegular,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontSize: 14.sp,
            color: MyColor.textThird,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
          labelMedium: TextStyle(
            fontSize: 12.sp,
            color: MyColor.inActiveColor,
            fontFamily: MyString.poppinsRegular,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            fontSize: 10.sp,
            color: MyColor.inActiveColor,
            fontFamily: MyString.poppinsRegular,
            fontWeight: FontWeight.w400,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontSize: 14.sp,
            color: MyColor.homeText1Color,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: MyColor.textThird,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          filled: true,
          prefixIconColor: MyColor.skyPrimary,
          fillColor: MyColor.darkCardBackground,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: MyColor.vibrantPurple, width: 2.0.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: MyColor.textThird, width: 1.0.w),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: MyColor.calorieRed, width: 1.5.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: MyColor.calorieRed, width: 2.0.w),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            ),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return MyColor.inActiveColor;
              }
              return MyColor.vibrantPurple;
            }),
            foregroundColor: WidgetStateProperty.all(MyColor.homeText2Color),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: 16.sp,
                fontFamily: MyString.poppinsMedium,
                fontWeight: FontWeight.w600,
              ),
            ),
            elevation: WidgetStateProperty.all(0),
            shadowColor: WidgetStateProperty.all(MyColor.shadowMedium),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(MyColor.skyPrimary),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: 14.sp,
                fontFamily: MyString.poppinsMedium,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: MyColor.textThird,
          thickness: 1.0.w,
          space: 1.0.h,
        ),
      );
}
