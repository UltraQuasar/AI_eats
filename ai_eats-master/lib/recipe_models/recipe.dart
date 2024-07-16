class Recipe {
  String name;
  String? content;
  bool isFavorite;

  Recipe({required this.name, this.content, this.isFavorite = true});
}