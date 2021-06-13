import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyrics/src/repositories/local_storage_repository.dart';
import 'package:flutter_lyrics/src/screens/dashboard_screen/dashboard_screen.dart';
import 'package:flutter_lyrics/src/service_locator.dart';
import 'package:theme_provider/theme_provider.dart';

import 'app_themes/app_themes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: appThemes,
      loadThemeOnInit: true,
      saveThemesOnChange: true,
      child: ThemeConsumer(
          child: Builder(
        builder: (context) => MaterialApp(
          builder: (context, child) {
            return ValueListenableBuilder(
              valueListenable: serviceLocator
                  .get<LocalStorageRepository>()
                  .fontFactorListenable,
              builder: (context, fontFactor, _) {
                return MediaQuery(
                  child: child,
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: fontFactor,
                  ),
                );
              },
            );
          },
          theme: ThemeProvider.themeOf(context).data,
          home: Scaffold(
            body: DashboardScreen(),
          ),
        ),
      )),
    );
  }
}
