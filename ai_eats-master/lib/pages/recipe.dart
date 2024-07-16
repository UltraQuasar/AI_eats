import 'package:ai_eats/recipe_models/appBarRecipe.dart';
import 'package:ai_eats/recipe_models/progress%20bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_models/bottom_navigator.dart';
import '../preferences_models/appBarPreferences.dart';
import '../prompt_model/prompt_content.dart';

class RecipePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    PromptGeneration promptGeneration = Provider.of<PromptGeneration>(context);
    // when creating a recipe: first progress bar and then the finished prompt
    return promptGeneration.promptFinished  ? Scaffold(
        appBar: appBarRecipe(context),
        bottomNavigationBar: bottomNavigator(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              children: [
                Text(Provider.of<PromptGeneration>(context).getRecipe)
              ],
            ),
          ),
        )
    ) : ProgressBar(generation: promptGeneration);
  }
}
