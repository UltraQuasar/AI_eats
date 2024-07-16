import '../preferences_models/interest_option.dart';

class Preferences {
  List<InterestOption> preferences = [
    const InterestOption(typeTmp: 'Easy Cooking', pathTmp: 'easy_cooking.jpg'),
    const InterestOption(typeTmp: 'Gluten-free', pathTmp: 'gluten_free.jpg'),
    const InterestOption(typeTmp: 'Diary-Free', pathTmp: 'diary_free.png'),
    const InterestOption(typeTmp: 'High-Protein', pathTmp: 'high_protein.png'),
    const InterestOption(typeTmp: 'Low-Carb', pathTmp: 'low_carb.png'),
    const InterestOption(typeTmp: 'Nut-Free', pathTmp: 'nut_free.jpg'),
    const InterestOption(typeTmp: 'Vegan', pathTmp: 'vegan.jpg'),
    const InterestOption(typeTmp: 'Vegetarian', pathTmp: 'vegetarian.png')
  ];
}