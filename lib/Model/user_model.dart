// // To parse this JSON data, do
// //
// //     final meal = mealFromJson(jsonString);

// import 'dart:convert';

// Meal mealFromJson(String str) => Meal.fromJson(json.decode(str));

// String mealToJson(Meal data) => json.encode(data.toJson());

// class Meal {
//   Meal({
//     required this.totalMenu,
//     required this.result,
//   });

//   int totalMenu;
//   List<Result> result;

//   factory Meal.fromJson(Map<String, dynamic> json) => Meal(
//         totalMenu: json["Total Menu"],
//         result:
//             List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "Total Menu": totalMenu,
//         "Result": List<dynamic>.from(result.map((x) => x.toJson())),
//       };
// }

// class Result {
//   Result({
//     required this.images,
//     required this.id,
//     required this.menuname,
//     required this.description,
//     required this.v,
//   });

//   List<String> images;
//   String id;
//   String menuname;
//   String description;
//   int v;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         images: List<String>.from(json["images"].map((x) => x)),
//         id: json["_id"],
//         menuname: json["menuname"],
//         description: json["description"],
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "images": List<dynamic>.from(images.map((x) => x)),
//         "_id": id,
//         "menuname": menuname,
//         "description": description,
//         "__v": v,
//       };
// }
// To parse this JSON data, do
//
//     final meal = mealFromJson(jsonString);

import 'dart:convert';

Meal mealFromJson(String str) => Meal.fromJson(json.decode(str));

String mealToJson(Meal data) => json.encode(data.toJson());

class Meal {
  Meal({
    required this.meals,
  });

  List<MealElement> meals;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        meals: List<MealElement>.from(
            json["meals"].map((x) => MealElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class MealElement {
  MealElement({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  String strMeal;
  String strMealThumb;
  String idMeal;

  factory MealElement.fromJson(Map<String, dynamic> json) => MealElement(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
