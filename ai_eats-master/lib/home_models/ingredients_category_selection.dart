import 'package:flutter/material.dart';

import 'ingredient_category_widget_v2.dart';

class IngredientsCategorySelection extends StatelessWidget {
  final List<IngredientCategoryV2> categories;
  const IngredientsCategorySelection({super.key, required this.categories});

  Widget _buildRow(IngredientCategoryV2 firstElm, IngredientCategoryV2 secondElm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        firstElm,
        // checks edge case
        if (secondElm.type != 'null')
          secondElm,
      ],
    );
  }

  Widget _buildIngredientsCategories(List<IngredientCategoryV2> categories) {
    return ListView.builder(
        itemCount: (categories.length / 2).ceil(),
        scrollDirection: Axis.vertical,
        itemExtent: 120,
        itemBuilder: (context, index) {
          // puts to widgets in one row
          final firstElm = categories[index * 2];
          final secondElm =(index * 2 + 1 < categories.length) ? categories[index * 2 + 1] : null;
          return _buildRow(firstElm, secondElm != null ? secondElm : IngredientCategoryV2('null', 'null')); // edge case if categories are uneven
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: _buildIngredientsCategories(categories)
    );
  }
}
