import 'package:flutter/material.dart';

void goToScreen(BuildContext context, Widget screen, {Function? onReturn}) {
  Duration animationDuration = Duration(milliseconds: 500);

  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: animationDuration,
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondsAnimation, Widget child) {
        animation = CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
        );

        return ScaleTransition(
          scale: animation,
          child: child,
          alignment: Alignment.center,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondsAnimation) {
        return screen;
      },
    ),
  ).then((value) {
    if (onReturn != null) {
      onReturn.call();
    }
  });
}
