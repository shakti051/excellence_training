import 'package:flutter/material.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'app_colors.dart';
import 'dimensions.dart';

class VlccThemeData {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      brightness: Brightness.light,
      fontFamily: FontName.frutinger,
      primaryColor: VlccColor.primaryTheme,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: VlccColor.primaryTheme,
          shadowColor: Colors.black12,
          primary: VlccColor.themeOrange,
        ),
      ),
      primaryIconTheme: IconThemeData(
        color: VlccColor.themeOrange,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: VlccColor.themeOrange,
        elevation: 4.0,
        focusElevation: 5.0,
        foregroundColor: Colors.white,
        splashColor: VlccColor.themeOrange.withOpacity(0.5),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xffF6F6F6),
        space: 20,
        thickness: 2,
      ),
      cardTheme: CardTheme(
        elevation: 5.0,
        color: Colors.white,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: FontName.frutinger,
          color: VlccColor.textColor,
          fontWeight: FontWeight.bold,
          fontSize: FontSize.extraLarge,
        ),
        color: VlccColor.primaryTheme,
        // backgroundColor: VlccColor.themeOrange,
        elevation: 0.0,
        actionsIconTheme: IconThemeData(
          color: VlccColor.themeOrange,
          size: 20,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: VlccColor.themeOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: FontSize.small,
          fontWeight: FontWeight.bold,
          color: VlccColor.lightOrange,
          fontFamily: FontName.frutinger,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: FontSize.small,
          fontWeight: FontWeight.w600,
          fontFamily: FontName.frutinger,
        ),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: VlccColor.themeOrange,
        elevation: 6.0,
        unselectedItemColor: Colors.grey,
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AppColors.profileEnabled,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
            color: AppColors.profileEnabled, fontWeight: FontWeight.w600),
        labelStyle: TextStyle(
          fontFamily: FontName.frutinger,
          color: AppColors.profileEnabled,
          fontWeight: FontWeight.bold,
        ),
      ));
}

class VlccColor {
  static Color themeOrange = Color(0xffFF6924);
  static Color primaryTheme = Color(0xffFAFAFA);
  static Color? darkGreyDivider = Colors.grey[600];
  static Color? lightGreyDivider = Colors.grey[300];
  static Color textColor = Color(0xff1E1F20);
  static Color lightOrange = Color(0xffF3972F);
}
