import 'package:mockito/mockito.dart';
import 'package:first_flutter_app/meal_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

Future<List<Meal>> searchMeal(http.Client client) async{
  String api="https://www.themealdb.com/api/json/v1/1/search.php?s=";
  var result = await http.get(api);
  var jsonResult=json.decode(result.body);
  List<dynamic> listMeal= (jsonResult as Map <String,dynamic>)['meals'];
  List<Meal> meals=[];

  for(int i=0; i < listMeal.length;i++){
    meals.add(Meal.createMeal(listMeal[i]));
  }
  return meals;
}

Future<List<Meal>> getDessert(http.Client client) async{
  String api="https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert";
  var result = await http.get(api);
  var jsonResult=json.decode(result.body);
  List<dynamic> listMeal= (jsonResult as Map <String,dynamic>)['meals'];
  List<Meal> meals=[];

  for(int i=0; i < listMeal.length;i++){
    meals.add(Meal.createMeal(listMeal[i]));
  }
  return meals;
}

Future<List<Meal>> getSeafood(http.Client client) async{
  String api="https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";
  var result = await http.get(api);
  var jsonResult=json.decode(result.body);
  List<dynamic> listMeal= (jsonResult as Map <String,dynamic>)['meals'];
  List<Meal> meals=[];

  for(int i=0; i < listMeal.length;i++){
    meals.add(Meal.createMeal(listMeal[i]));
  }
  return meals;
}

Future<List<MealDetail>> getMealDetail(http.Client client) async{
  String api="https://www.themealdb.com/api/json/v1/1/lookup.php?i=52977";
  var result = await http.get(api);
  var jsonResult=json.decode(result.body);
  List<dynamic> listMeal= (jsonResult as Map <String,dynamic>)['meals'];
  List<MealDetail> meals=[];

  meals.add(MealDetail.createMealDetail(listMeal[0]));

  return meals;
}

main() {
  group('MealTest', () {
    test('mendapatkan hasil Search Meal dari server', () async {
      final client = MockClient();

      when(client.get('https://www.themealdb.com/api/json/v1/1/search.php?s='))
          .thenAnswer((_) async => http.Response('{meals[{strMeal : Corba}]}', 200));
      expect(await searchMeal(client), isInstanceOf<List<Meal>>());
    });
    test('mendapatkan hasil List Dessert dari server', () async {
      final client = MockClient();

      when(client.get('https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert'))
          .thenAnswer((_) async => http.Response('{meals[{strMeal : Corba}]}', 200));
      expect(await getDessert(client), isInstanceOf<List<Meal>>());
    });
    test('mendapatkan hasil List Seafppd dari server', () async {
      final client = MockClient();

      when(client.get('https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood'))
          .thenAnswer((_) async => http.Response('{meals[{strMeal : Corba}]}', 200));
      expect(await getSeafood(client), isInstanceOf<List<Meal>>());
    });
    test('mendapatkan hasil Detail Meal dari server', () async {
      final client = MockClient();

      when(client.get('https://www.themealdb.com/api/json/v1/1/lookup.php?i=52977'))
          .thenAnswer((_) async => http.Response('{meals[{strMeal : Corba}]}', 200));
      expect(await getMealDetail(client), isInstanceOf<List<MealDetail>>());
    });
  });
}