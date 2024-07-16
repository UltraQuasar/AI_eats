import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../pages/recipe.dart';
import '../prompt_model/prompt_content.dart';

SizedBox createRecipesButton(BuildContext context) {
  PromptGeneration promptGeneration = Provider.of<PromptGeneration>(context);
  return SizedBox(
    width: 180,
    height: 50,
    child: FloatingActionButton(
      onPressed: () {
        promptGeneration.generatePrompt();
        // first go to recipe page, back gesture is disabled through fullscreenDialog
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipePage(), fullscreenDialog: true),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      backgroundColor: Colors.lightGreen,
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Center(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor,
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/icons/bottom_navigator/prompt.svg',
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Create recipes',
            style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
