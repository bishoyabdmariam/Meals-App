class MealsFromCategory {
  final String? strMeal;
  final String? strMealThumb;
  final String? idMeal;

  MealsFromCategory({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  factory MealsFromCategory.fromJson(Map<String, dynamic> json) {
    return MealsFromCategory(
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      idMeal: json['idMeal'],
    );
  }
}
