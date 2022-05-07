import 'package:flutter/material.dart';
import 'package:flutter_lyrics/src/repositories/local_storage_repository.dart';
import 'package:flutter_lyrics/src/service_locator.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  LocalStorageRepository _localStorageRepo =
      serviceLocator.get<LocalStorageRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                settingsLabel("Theme:"),
                SizedBox(height: 20),
                _buildThemeSection(context),
                SizedBox(height: 40),
                Divider(thickness: 0.2, color: Colors.white),
                SizedBox(height: 10),
                settingsLabel("Font Size:"),
                _buildChangeFontSizeSection(context),
                SizedBox(height: 20),
                Divider(thickness: 0.2, color: Colors.white),
                SizedBox(height: 10),
                settingsLabel("About:"),
                SizedBox(height: 20),
                _buildAboutSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget settingsLabel(String text) {
    return Opacity(
      opacity: 0.8,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ThemeProvider.controllerOf(context).allThemes.map((e) {
        String selectedThemeId = ThemeProvider.themeOf(context).id;
        String currentThemeId = e.id;
        bool isThemeSelected = e.id == selectedThemeId;
        return GestureDetector(
            onTap: () {
              if (!isThemeSelected) {
                ThemeProvider.controllerOf(context).setTheme(currentThemeId);
              }
            },
            child: CircleAvatar(
              backgroundColor: isThemeSelected ? Colors.yellow : Colors.black38,
              radius: 30,
              child: CircleAvatar(
                backgroundColor: e.data.primaryColor,
                radius: 25,
              ),
            ));
      }).toList(),
    );
  }

  Widget _buildChangeFontSizeSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIconButton(Icons.remove, decrementFont),
          ValueListenableBuilder(
            valueListenable: serviceLocator
                .get<LocalStorageRepository>()
                .fontFactorListenable,
            builder: (context, double? fontFactor, child) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Text(
                      fontFactor!.toStringAsFixed(1),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
          _buildIconButton(Icons.add, incrementFont),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAboutDataText("Developed By", fontSize: 16),
          _buildLinkText("Mohammed Hashim",
              "https://www.linkedin.com/in/mohammed-hashim-25764b1b2/"),
          SizedBox(
            height: 20,
          ),
          _buildAboutDataText("Source Code", fontSize: 16),
          _buildLinkText("Github",
              "https://github.com/mohammedhashim44/Flutter-Lyrics-App"),
        ],
      ),
    );
  }

  Widget _buildAboutDataText(String text, {double fontSize = 18}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize),
    );
  }

  Widget _buildLinkText(String text, String url) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          color: Colors.white,
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void incrementFont() {
    double value = _localStorageRepo.fontFactorListenable.value!;
    _localStorageRepo.setFontFactor(value + 0.1);
  }

  void decrementFont() {
    double value = _localStorageRepo.fontFactorListenable.value!;
    _localStorageRepo.setFontFactor(value - 0.1);
  }

  Widget _buildIconButton(IconData icon, Function onClicked) {
    return GestureDetector(
      onTap: onClicked as void Function()?,
      child: Icon(
        icon,
        size: 40,
      ),
    );
  }
}
