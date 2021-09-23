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
      scaffoldBackgroundColor: Color(0xFF162447),
      primaryColor: Color(0xFF1f4068),
      accentColor: Color(0xffe43f5a),
    ),
  ),
  AppTheme(
    id: "1",
    description: "1",
    data: getThemeDataFromColors(
      scaffoldBackgroundColor: Color(0xff16213e),
      primaryColor: Color(0xffe94560),
      accentColor: Colors.white,
    ),
  ),
  AppTheme(
    id: "2",
    description: "2",
    data: getThemeDataFromColors(
      scaffoldBackgroundColor: Color(0xff182952),
      primaryColor: Color(0xff2b3595),
      accentColor: Colors.white,
    ),
  ),
  AppTheme(
    id: "3",
    description: "3",
    data: getThemeDataFromColors(
      scaffoldBackgroundColor: Color(0xff171717),
      primaryColor: Color(0xff444444),
      accentColor: Colors.white,
    ),
  ),
];

ThemeData getThemeDataFromColors({
  Color primaryColor,
  Color accentColor,
  Color scaffoldBackgroundColor,
}) {
  return baseThemeData.copyWith(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      accentColor: accentColor,
      primaryColor: primaryColor,
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
      ));
}
