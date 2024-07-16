import 'package:flutter/material.dart';

AppBar appBarPreferences(BuildContext context) {
  return AppBar(
      title: const Text('Select Interest'),
      titleTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      centerTitle: true,
      automaticallyImplyLeading: true,
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
  );
}
