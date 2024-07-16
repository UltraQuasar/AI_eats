import 'dart:async';

import 'package:ai_eats/prompt_model/prompt_content.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final PromptGeneration generation;

  ProgressBar({required this.generation});

  @override
  State<ProgressBar> createState() {
    return _ProgressBar();
  }}

class _ProgressBar extends State<ProgressBar> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late PromptGeneration promptGeneration;


  final List<double> speed = [
    0.1,
    0.3,
    0.1,
    0.25,
    0.15,
    0.1
  ]; // sum must be 1.0

  int _textIndex = 0;
  List<String> text = [
    "Generating Prompt",
    "ChatGPT is thinking ...",
    "ChatGPT is thinking ...",
    "Waiting for Response",
    "Formatting",
    "Finalizing!"
  ];

  @override
   initState()   {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
          waitOneSec();
        }
      })
      ..forward();
    _startTextTimer();
  }

  Future<dynamic> waitOneSec() {
   return Future.delayed(Duration(seconds: 1), () async {
    });
  }

  void _startTextTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_textIndex < 5) {
        _textIndex++;
      } else {
        timer.cancel();
        _textIndex = 5;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (Theme.of(context).brightness == Brightness.light)
          Image.asset(
            'assets/icons/logo/Logo.png',
            width: 400,
            height: 400,
          ),
          if ((Theme.of(context).brightness == Brightness.dark))
            Image.asset(
              'assets/icons/logo/Logo_darkmode.png',
              width: 400,
              height: 400,
            ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text[_textIndex],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 250,
                  height: 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: _calculateProgress(),
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '${(_calculateProgress() * 100).toStringAsFixed(0)}%',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateProgress() {
    double progress = 0;
    double animationValue = _animation.value;

    for (int i = 0; i < speed.length; i++) {
      if (animationValue < (i + 1) / speed.length) {
        progress +=
            speed[i] * (animationValue - i / speed.length) / (1 / speed.length);
        break;
      } else {
        progress += speed[i];
      }
    }


    return progress;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
