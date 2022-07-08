import '../models/dog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService
{
  Future<List<Dog>> fetchDog(String name) async {
  if (name == "") {
    return [];
  } else {
    final response = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/dogs?name=$name'),
        headers: {'X-Api-Key': 'qfs8GBcn4feHo1bGfdvpTw==u91Tne4T8znAkTqa'});

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> data = jsonDecode(response.body);
      List<Dog> dogs = [];
      data.forEach((element) {
        dogs.add(Dog.fromJson(element));
      });

      return dogs;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}
}