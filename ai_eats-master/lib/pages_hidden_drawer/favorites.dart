import 'package:flutter/material.dart';

import '../home_models/bottom_navigator.dart';
import '../recipe_models/recipe.dart';
import '../theme/theme.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoritesState();
  }
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    List<Recipe> recipes = [
      Recipe(name: 'Spaghetti'),
      Recipe(name: 'Chicken Curry'),
      Recipe(name: 'Chocolate Cake'),
      Recipe(name: 'Onion Soup'),
      Recipe(name: 'Butter Chicken'),
      Recipe(name: 'Burritos'),
      Recipe(name: 'Studi Topf'),
      Recipe(name: 'Avocado Sandwich'),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [green, lightGreen, yellow],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return RecipeCard(recipe: recipes[index]);
            },
          ),
        ),
        bottomNavigationBar: bottomNavigator(context),
      ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showDialog(context);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.0),
            Icon(Icons.fastfood, size: 50.0),
            SizedBox(height: 10.0),
            Text(
              widget.recipe.name,
              style:
                  TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(
                widget.recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: widget.recipe.isFavorite ? red : null,
              onPressed: () {
                setState(() {
                  widget.recipe.isFavorite = !widget.recipe.isFavorite;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recipe Details'),
          content: Text('Add your detailed recipe content here.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
