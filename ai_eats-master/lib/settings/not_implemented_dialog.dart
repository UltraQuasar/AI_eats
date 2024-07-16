import 'package:flutter/material.dart';

import '../theme/theme.dart';

SimpleDialog NotImplementedDialog(BuildContext context) {
  return SimpleDialog(
    title: Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipOval(
            child: Container(
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/icons/logo/Logo_withoutTitle.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Icon(
            Icons.block_outlined,
            size: 150,
            color: Colors.red, // Assuming `red` is a Color variable
          ),
        ],
      ),
    ),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'This feature is not yet available...\nBut stay tuned, we are working on it!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      SizedBox(height: 16.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK', style: TextStyle(color: green)),
        ),
      ),
    ],
  );
}
