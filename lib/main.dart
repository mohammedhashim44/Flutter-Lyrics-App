import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lyrics/src/app.dart';
import 'package:flutter_lyrics/src/service_locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await setupServiceLocator();
  runApp(App());
}

