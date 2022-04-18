enum Complexity {
  Simple,
  Challenging,
  Hard,
}

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  String id;
  List<String> categories;

  String imageUrl;

  int duration;

  bool isGlutenFree;
  bool isLactoseFree;
  bool isVegan;
  bool isVegetarian;

  Meal({
    required this.id,
    required this.categories,
    required this.imageUrl,
    required this.duration,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}
