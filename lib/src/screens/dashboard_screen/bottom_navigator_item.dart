import 'package:flutter/material.dart';
import 'package:flutter_lyrics/src/screens/search_screen/search_screen.dart';

import '../saved_songs_screen.dart';
import '../settings_screen.dart';

class BottomNavigatorItem {
  final int index;
  final String label;
  final IconData iconData;
  final Widget screen;

  BottomNavigatorItem(this.index, this.label, this.iconData, this.screen);
}

List<BottomNavigatorItem> navigatorItems = [
  BottomNavigatorItem(
    0,
    "Search",
    Icons.image_search_sharp,
    SearchScreen(),
  ),
  BottomNavigatorItem(
    1,
    "Saved",
    Icons.bookmark,
    SavedSongsScreen(),
  ),
  BottomNavigatorItem(
    2,
    "Settings",
    Icons.settings,
    SettingsScreen(),
  ),
];
