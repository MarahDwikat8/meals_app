import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/area.dart';
import '../models/meal.dart';

class ApiService{

static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  Future<List<Area>> fetchArea() async {
  final response = await http.get(Uri.parse('${baseUrl}list.php?a=list'));

  if (response.statusCode == 200) {
    final List<dynamic> data =json.decode(response.body)['meals'];
    return data.map((json)=>Area.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Area');
  }
}

Future<List<Meal>> fetchMealsByArea(String area) async {
  final response = await http.get(Uri.parse('${baseUrl}filter.php?a=$area'));

  if (response.statusCode == 200) {
    final List<dynamic> data =json.decode(response.body)['meals'];
    return data.map((json) => Meal.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Meal');
  }
}
Future<MealDetails> fetchMealDetails(String mealId) async {
    final response = await http.get(Uri.parse('${baseUrl}lookup.php?i=$mealId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['meals'][0];
      return MealDetails.fromJson(data);
    } else {
      throw Exception('Failed to load meal details');
    }
}

}

// import 'package:dio/dio.dart';
// import '../models/area.dart';
// import '../models/meal.dart';

// class ApiService{
//    final Dio dio;
//    ApiService(this.dio);

// }