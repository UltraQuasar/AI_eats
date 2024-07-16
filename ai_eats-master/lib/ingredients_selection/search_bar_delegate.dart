import 'package:ai_eats/ingredients_selection/food.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  List<Food> searchResults = FoodList.all_items;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (!query.isEmpty) {
              query = '';
            } else {
              close(context, null);
            }
          },
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(fontSize: 60),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Food> suggestions = searchResults.where((searchResult) {
      final result = searchResult.name.toUpperCase();
      final input = query.toUpperCase();

      return result.contains(input);
    }).toList();

    // Sortiere die Vorschläge nach dem Index des Suchbegriffs im Wort
    suggestions.sort((a, b) {
      final indexA = a.name.toUpperCase().indexOf(query.toUpperCase());
      final indexB = b.name.toUpperCase().indexOf(query.toUpperCase());

      return indexA.compareTo(indexB);
    });

    if (query.isEmpty) {
      return const Placeholder(
        color: Colors.transparent,
      );
    } else {
      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return _buildListItem(suggestion, context);
        },
      );
    }
  }

  Widget _buildListItem(Food item, BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.only(right: 16),
        child: ListTile(
          title: Text(item.name),
          leading: Image.asset(
            item.imagePath,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          onTap: () => {
            // query = item.name,
            item.isSelected = !item.isSelected,
            close(context, null),
          },
          tileColor: item.isSelected ? Colors.lightGreen : null,
        ),
      ),
    ]);
  }
}
