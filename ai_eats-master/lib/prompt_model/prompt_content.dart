import 'dart:collection';

import 'package:ai_eats/ingredients_selection/food.dart';
import 'package:ai_eats/preferences_models/interest_option.dart';
import 'package:ai_eats/prompt_model/preferences.dart';
import 'package:flutter/cupertino.dart';


import '../recipe_models/prompt.dart';
import 'categories.dart';



class PromptGeneration extends ChangeNotifier {
  late API api = API(this);

  //ingredients categories:
  Categories categories = Categories();




  //cuisines
  // cuisineHelper: saves the name of the cuisine, is stored locally (Methode in cuisine_service), name needed to build the cuisine widget
  List<String> _cuisineHelper = [];
  List<String> getCuisineHelper() => _cuisineHelper;
  void setCuisineHelper (List<String> elm) {
    _cuisineHelper = [];
    _cuisineHelper.addAll(elm);
    notifyListeners();
  }
  void resetCuisineHelper() {
    _cuisineHelper = [];
    notifyListeners();
  }
  late int _lengthCuisine = _cuisineHelper.length;
  int getLengthCuisine() => _lengthCuisine;
  void setLengthCuisine(int i) {
    _lengthCuisine = i;
  }


// 'cache' : loaded to improve performance
  Map<String, Image> _images = Map();
  Map<String, Image> getImages() => _images;
  void resetImages() {
    _images = Map();
    notifyListeners();
  }
  void addNewImages(String s, Image i) {
    _images[s] = i;
  }
  void mapIsComplete(int i) {
    if (_images.length == i) {
      notifyListeners();
    }
  }





  //preferences:
  Preferences preferences = Preferences();

  /*Specification about Person, Premium abonnement related
  age:
  Integer age = age();

  health-related:
  Health health = Health();

  Allergies allergies = allergies();

  //openness towards the unconventional on a scale from 1-10
  Openness openness = Openness();

  //available time enum (short - up to 20, medium-40, long-more than 1h)
  Time time = Time();
  */

  // every SelectStyleElement is linked to the state if it is selected
  late HashMap<String, bool> isSelectedStyle = HashMap.fromIterable(
      _cuisineHelper,
      key: (elm) => elm,
      value: (elm) => false);

//setter
  void selectStyle(String elm, bool state) {
    isSelectedStyle[elm] = state;
    notifyListeners();
  }



// every InterestOption is linked to the state if it is selected
  late HashMap<InterestOption, bool> isSelectedPreferences =
  HashMap.fromIterable(preferences.preferences,
      key: (object) => object, value: (object) => false);

// setter for isSelected for preferences
  void selectPreferences(InterestOption typ, bool state) {
    isSelectedPreferences[typ] = state;
    notifyListeners();
  }

  // Getter für selectedIngredients
  List<String> getSelectedIngredients() {
    return FoodList.all_items
        .where((ingredient) => ingredient.isSelected)
        .map((ingredient) => ingredient.name)
        .toList();
  }

  String createPrompt() {
    // text for chat gpt
    // return'';
    StringBuffer buffer = StringBuffer();
    // String listItems = items.join(", "); //list of available items

    List<String> styles = []; // list of all selected styles
    if (isSelectedStyle.isNotEmpty) {
      for (String style in _cuisineHelper) {
        if (isSelectedStyle[style]!) {
          styles.add(style);
        }
      }
    }


    List<String> preferencesTmp = []; // list of all selected preferences
    if (isSelectedPreferences.isNotEmpty) {
      for (InterestOption preference in  preferences.preferences) {
        if (isSelectedPreferences[preference]!) {
          preferencesTmp.add(preference.typeTmp);
        }
      }
    }
    String listPreferences = preferences.preferences.join(" and");
    buffer.write( //6 part prompt
      //task - start with action verb, "generate", compare with existing recipes on the internet most popular.
       "Generate a step-by-step recipe with the following ingredients at hand: ${getSelectedIngredients()}"
           "in one of the cuisines of this list: ${styles}, depending on which fits most."
            "The chosen recipe should contain as many ingredients from the list as possible."

           //context - user background, define good result, environment -> derivable by age
    /* "Take into account that you are a 50 year old person with the following allergies: peanuts, that wants to follow the recipe."
       "Consider the following health specifications in the recipe: gluten-free."
       "When choosing, consider the openness towards unconventional recipes on a scale from 1-10, whereas 10 is the most open."
       "The user has an openness of 5." */
   
   /*
      //context - user background, define good result, environment -> derivable by age
       "Take into account that you are a ${null} year old person with the following allergies: ${null}, that wants to follow the recipe."
       "Consider the following health specifications in the recipe: ${null}."
       "When choosing, consider the openness towards unconventional recipes on a scale from 1-10, whereas 10 is the most open."
       "The user has an openness of ${null}."
 */

      //example
    );

    return buffer.toString();
  }

  //Prompt will be send to the Api
  String _recipe = '';
  get getRecipe => _recipe;
  void setRecipe(String s) {
    _recipe = s;
    notifyListeners();
  }

  //setter and getter to get notified if the recipe generation is finished
  bool _promptingFinished = false;
  get promptFinished => _promptingFinished;
  void setPromptFinished(bool elm) {
    _promptingFinished = elm;
    notifyListeners();
  }

  //setter and getter to get notified if the recipe generation failed
  bool _promptingFailed = false;
  get promptingFailed => _promptingFailed;
  void setPromptFailed(bool elm) {
    _promptingFailed = elm;
    notifyListeners();
  }

  //function waits either 10 Seconds (Duration of ProgressBar) or if the prompt takes longer until the prompt is finished
  void generatePrompt() {
    Future<dynamic> sixSecWait = Future.delayed(Duration(seconds: 10));
    // Prompting is finished to recipe is ready to show
    Future.wait([sixSecWait, api.generatePromptFunction()]).whenComplete(() => setPromptFinished(true));
  }
}
