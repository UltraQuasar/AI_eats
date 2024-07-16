import 'package:ai_eats/home_models/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../theme/theme.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final TextEditingController _textController = TextEditingController();
  double textFieldHeight = 75.0; // Initial height of TextField
  int maxLinesEnforced = 10;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tastatur zu minimieren
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 265,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [lightGreen, yellow],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -70,
                    right: 25,
                    child: Image.asset(
                      'assets/icons/hidden_menu_pages/MeatTheTeam.png',
                      height: 250,
                      width: 250,
                    ),
                  ),
                  const Positioned(
                    top: 90,
                    left: 25,
                    child: Text('Feedback',
                        style: TextStyle(
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Positioned(
                    top: 125,
                    left: 25,
                    child: Text(
                        'Hi! We are the developers of AI Eats and \nwe are really looking forward to your \nopinion about our app!',
                        style: TextStyle(color: black, fontSize: 15)),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Tell us how we can improve the app:',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16.0),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                          height: textFieldHeight,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            controller: _textController,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: Colors.black,
                            onChanged: (text) {
                              // Update der Höhe basierend auf dem Inhalt
                              setState(() {
                                textFieldHeight = calculateTextFieldHeight();
                              });
                            },
                            inputFormatters: [MaxLinesTextInputFormatter(10)],
                            maxLines: null,
                            maxLength: 500,
                            decoration: InputDecoration(
                              hintText: 'Write here...',
                              hintStyle: TextStyle(fontSize: 16),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      'How would you rate our app?',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar(
                        initialRating: 3,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: gold),
                          half: Icon(Icons.star_half, color: gold),
                          empty: Icon(Icons.star_border, color: lightGrey),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        onRatingUpdate: (rating) {
                          print('New Rating $rating');
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: green,
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: const Text(
                        'SEND NOW',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  RotatedBox(
                    quarterTurns: 2,
                    child: ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:
                                Theme.of(context).brightness == Brightness.light
                                    ? [lightGreen, yellow]
                                    : [darkBrown, brown],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 25,
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? 'assets/icons/logo/Logo_braun.png'
                          : 'assets/icons/logo/Logo_withoutTitle_alpha.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigator(context),
      ),
    );
  }

  // Function to calculate the height of the TextField based on content
  double calculateTextFieldHeight() {
    final double minHeight = 75.0;
    final double maxHeight = 500;

    double newHeight = minHeight +
        (_textController.text.split('\n').length.toDouble() - 1) * 16.0;

    // Ensure the height stays within the specified range
    return newHeight.clamp(minHeight, maxHeight);
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 175);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MaxLinesTextInputFormatter extends TextInputFormatter {
  final int maxLines;

  MaxLinesTextInputFormatter(this.maxLines);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newLineCount = '\n'.allMatches(newValue.text).length + 1;

    if (newLineCount > maxLines) {
      return oldValue;
    }
    return newValue;
  }
}
