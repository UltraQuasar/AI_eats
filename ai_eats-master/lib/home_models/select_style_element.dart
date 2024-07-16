
import 'package:ai_eats/prompt_model/cuisines_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../prompt_model/prompt_content.dart';

class SelectStyleElement extends StatefulWidget {
  // contains one food-style
  final String name;

  const SelectStyleElement(
      {super.key, required this.name});

  @override
  State<StatefulWidget> createState() {
    return _SelectStyleElement();
  }
}

class _SelectStyleElement extends State<SelectStyleElement> {
  late final String _name;


  @override
  void initState() {
    super.initState();
    _name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    final PromptGeneration p =
        Provider.of<PromptGeneration>(context);
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        print('Following cuisine "$_name" is selected');
        setState(() {
          p.selectStyle(
              _name, !p.isSelectedStyle[_name]!); // changes the box to green -> indicates selected
        });
      },
      child: Container(
        // rectangle with rounded corners
        height: 100,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color:
          p.isSelectedStyle[_name]!
              ? Colors.lightGreen
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          // contains the icon of the food-style inside of a circle
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                // loads image from local storage, if its already loaded its is taken from cache
                child: p.getImages()[_name] == null ? cuisineLoadedFromStorage(p) : p.getImages()[_name]
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _name,
                    style: const TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  FutureBuilder<Image?> cuisineLoadedFromStorage(PromptGeneration p) {
    return FutureBuilder<Image?>(
      // two seconds delay to make sure after downloading from cloud it is saved locally
      future: Future.delayed(Duration(seconds: 2)).then((v) => CuisinesService.getImage(_name)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            // adding photos into cache -> to access quicker
            p.addNewImages(_name, snapshot.data!);
            return snapshot.data!;
          } else {
            return Image.asset('assets/icons/food_style_selection/error_image.png');
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
