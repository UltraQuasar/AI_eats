import 'package:ai_eats/prompt_model/cuisines_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_models/bottom_navigator.dart';
import '../home_models/create_recipes.dart';
import '../home_models/ingredients_category_selection.dart';
import '../home_models/left_in_my_fridge.dart';
import '../home_models/select_style_bar.dart';
import '../prompt_model/prompt_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  bool localStorageEmpty = true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
  PromptGeneration p = Provider.of<PromptGeneration>(context);

    return Scaffold(
      extendBodyBehindAppBar: false,
      // appBar: topAppBar(context),    // hier nicht benötigt wegen HiddenDrawer
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SelectStyleBar(p: p,
          ),
          // ListView at the top -> Select the style direction
          leftInMyFridge(context),
          // Click to set preferences
          const SizedBox(
            height: 10,
          ),
          IngredientsCategorySelection(
            categories: context.read<PromptGeneration>().categories.categories,
          ),
          // Ingredient Selection
        ],
      ),
      bottomNavigationBar: bottomNavigator(context),
      floatingActionButton: createRecipesButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
