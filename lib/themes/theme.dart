import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:flutter/material.dart';

Color kPrimaryColor = HexColor("#F4F5F7");
Color kPrimaryDark = HexColor('#000000');
Color kPageBackgroundLight = const Color.fromRGBO(244, 245, 247, 1);
Color kPageBackgroundDark = HexColor('#333333');
Color kTextActionBarLight = HexColor("#6E9232");
Color kTextActionBarDark = HexColor("#C9DCED");
Color kIconThemeColorLight = HexColor("#1A2139");
Color kIconThemeColorDark = HexColor("#E8F1D9");
Color kBodyBackgroundLight = Colors.grey[200]!;
Color kBodyBackgroundDark = Colors.grey[900]!;
Color kDarkBannerColor = HexColor('#333333');
Color kInputTitleColor = HexColor("#515151");
Color kTextInputBackgroundColor = HexColor("#F4F5F7");

Color kBtnDarkColor = HexColor('#0B1327');
Color kLightColor = HexColor("#FFFFFF");
Color kAccountCardOptionColor = HexColor('#4D4D4D');
Color kRatingCountTextColor = HexColor('#4C4C4C');

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class AppTheme {
  static ThemeData main(Brightness brightness) {
    bool isDarkMode = brightness == Brightness.dark;

    return ThemeData(
      brightness: brightness,
      primaryColor: isDarkMode ? kPrimaryDark : kPrimaryColor,
      fontFamily: app_font,
      useMaterial3: true,
      primaryColorDark: kPrimaryDark,
      dialogTheme: DialogTheme(
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        //isDarkMode ? kPageBackgroundDark : kPageBackgroundLight,
        toolbarTextStyle: TextStyle(
          color: isDarkMode ? kTextActionBarDark : kTextActionBarLight,
          fontFamily: app_font,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? kIconThemeColorDark : kIconThemeColorLight,
          size: 20,
        ),
        actionsIconTheme: IconThemeData(
          color: isDarkMode ? kIconThemeColorDark : kIconThemeColorLight,
        ),
        centerTitle: false,
      ),
      colorScheme: isDarkMode
          ? ColorScheme.dark(primary: kPrimaryDark)
          : ColorScheme.light(primary: kPrimaryColor),
      buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: isDarkMode ? kPrimaryDark : kPrimaryColor),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black87,
          height: 1.25,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
                isDarkMode ? kPrimaryColor : kPrimaryDark)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            isDarkMode ? kBodyBackgroundDark : kBodyBackgroundLight,
        selectedItemColor: isDarkMode ? kPrimaryColor : kPrimaryDark,
        elevation: 2,
      ),
      dividerColor: isDarkMode ? Colors.grey[700] : kPrimaryColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
      ),
      iconTheme: IconThemeData(color: isDarkMode ? Colors.white : kPrimaryDark),
      scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }
}
