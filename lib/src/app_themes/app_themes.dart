import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

const FONT_FAMILY = "Poppins";

TextTheme textTheme = TextTheme(
  bodyText1: TextStyle(),
  bodyText2: TextStyle(),
  subtitle1: TextStyle(),
  headline6: TextStyle(
    fontWeight: FontWeight.normal,
  ),
  headline5: TextStyle(
    fontWeight: FontWeight.bold,
  ),
);

ThemeData baseThemeData = ThemeData(
  fontFamily: FONT_FAMILY,
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: textTheme,
);

List<AppTheme> appThemes = [
  AppTheme(
    id: "0",
    description: "0",
    data: getThemeDataFromColors(
      scaffoldBackgroundColor: Color(0xff00132d),
      primaryColor: Color(0xff00377e),
      accentColor: Colors.white,
    ),
  ),
  AppTheme(
    id: "1",
    description: "1",
    data: getThemeDataFromColors(
      scaffoldBackgroundColor: Color(0xff1A1A2E),
      primaryColor: Color(0xff0F3460),
      accentColor: Colors.white,
    ),
  ),
];

ThemeData getThemeDataFromColors({
  Color? primaryColor,
  required Color accentColor,
  Color? scaffoldBackgroundColor,
}) {
  return baseThemeData.copyWith(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: accentColor.withOpacity(0.5),
    ),
    canvasColor: primaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
    ),
    iconTheme: IconThemeData(
      color: accentColor,
    ),
  );
}
