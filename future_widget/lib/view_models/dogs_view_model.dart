import 'package:flutter/material.dart';
import 'package:future_widget/data_sources/api_services.dart';
import 'package:future_widget/models/dog.dart';

class DogsProvider with ChangeNotifier {
  void set()
  {
    this.dogsList = ApiService().fetchDog("");
    notifyListeners();
  }
  late Future<List<Dog>> dogsList;
  fetchData(String name) async {
    this.dogsList = ApiService().fetchDog(name);
    notifyListeners();
  }
}
