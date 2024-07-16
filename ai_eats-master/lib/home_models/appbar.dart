import 'package:flutter/material.dart';

AppBar topAppBar(BuildContext context) {
  Brightness currentBrightness = Theme.of(context).brightness;
  String path = currentBrightness == Brightness.light
      ? 'assets/icons/logo/Title_light.png'
      : 'assets/icons/logo/Title_dark.png';

  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    surfaceTintColor: Colors.transparent,
    leading: IconButton(
      splashRadius: 30,
      alignment: Alignment.center,
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).primaryColor,
      ),
    ),
    title: Image.asset(
      path,
      height: 25,
    ),
    centerTitle: true,
  );
}
