import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SizedBox leftInMyFridge(BuildContext context) {
  return SizedBox(
    height: 30,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'What\' is left in my fridge?',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/Preferences');
          }, // Navigation to preferences
          icon: const Icon(Icons.tune_sharp),
          splashRadius: 1,
        ),
      ],
    ),
  );
}
