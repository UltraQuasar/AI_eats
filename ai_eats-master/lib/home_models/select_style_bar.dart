import 'package:ai_eats/home_models/select_style_element.dart';
import 'package:ai_eats/prompt_model/cuisines_service.dart';
import 'package:ai_eats/prompt_model/prompt_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../prompt_model/cuisine.dart';

class SelectStyleBar extends StatefulWidget {
  // displays the style option of the recipes
  //final List<String> cuisines;
  final PromptGeneration p;

  const SelectStyleBar({super.key, required this.p});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectStyleBarState();
  }
}

class _SelectStyleBarState extends State<SelectStyleBar> {
  late PromptGeneration _p;
  late List<String> cuisineHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _p = widget.p;
   CuisinesService.updateCuisineHelper(_p);

  }



  @override
  Widget build(BuildContext context) {
    _p.setLengthCuisine(_p.getCuisineHelper().length);
    PromptGeneration p = Provider.of<PromptGeneration>(context);
      if (p.getCuisineHelper().isNotEmpty) {
         return cuisineBar(p);
      } else {
        return loadingButton(p);
      }
  }



  SizedBox cuisineBar(PromptGeneration p) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        // builds the complete bar based on the input,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(
              left: 15, right: 15, top: 5, bottom: 10),
          itemCount: p.getLengthCuisine(),
          itemBuilder: (context, index) {
            return Row(
              children: [
                SelectStyleElement(
                  name: p.getCuisineHelper()[index],
                ),
                SizedBox(width: 20),
              ],
            );
          }),
    );
  }

  SizedBox loadingButton(PromptGeneration p) {
   return SizedBox(
      height: 120,
      child: IconButton(
          onPressed: () async {
            //first load the names and the image path from the cloud database
            await CuisinesService.updateCuisinesNameInLocalStorage()
                .whenComplete(() =>
            // second load the images from cloud storage with the given image path
                CuisinesService.updateCuisinesImagesInLocalStorage()
                    .whenComplete(() =>
            // third load all the names into a list to build the cuisine bar
                    CuisinesService.updateCuisineHelper(p)));
          },
          icon: Icon(Icons.cloud_download)),
    );
  }
}
