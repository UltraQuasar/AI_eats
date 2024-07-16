import 'package:flutter/material.dart';

SizedBox doneButton(BuildContext context) { // button to finish the selection process for preferences
  return SizedBox(
    width: 200,
      height: 40,
      child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        backgroundColor: Colors.lightGreen,
        child: Text(
          'Done',
          style: (TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 18
          )),
        ),
      )
  );
}