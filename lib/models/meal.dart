class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  Meal({required this.idMeal, required this.strMeal, required this.strMealThumb});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
    );
  }
}

class MealDetails {
  final String strMeal;
  final String strCategory;
  final String strMealThumb;
  final String strInstructions;
  final String strArea;
  final String strYoutube;

  MealDetails({
    required this.strMeal,
    required this.strCategory,
    required this.strMealThumb,
    required this.strInstructions,
    required this.strArea,
    required this.strYoutube,
  });

  factory MealDetails.fromJson(Map<String, dynamic> json) {
    return MealDetails(
      strMeal: json['strMeal'],
      strCategory: json['strCategory'],
      strMealThumb: json['strMealThumb'],
      strInstructions: json['strInstructions'],
      strArea: json['strArea'],
      strYoutube: json['strYoutube'],
    );
  }
}
