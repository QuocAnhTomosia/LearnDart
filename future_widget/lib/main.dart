import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Dog> fetchDog() async {
  final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/dogs?name=shiba'),
      headers: {'X-Api-Key': 'qfs8GBcn4feHo1bGfdvpTw==u91Tne4T8znAkTqa'});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Dog.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ');
  }
}

class Dog {
  final String name;
  final String image_link;
  final int good_with_other_dogs;

  const Dog({
    required this.name,
    required this.image_link,
    required this.good_with_other_dogs,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      name: json['name'],
      good_with_other_dogs: json['good_with_other_dogs'],
      image_link: json['image_link'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Display(),
    );
  }
}

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  late Future<Dog> futureDog;

  @override
  void initState() {
    super.initState();
    futureDog = fetchDog();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Dog>(
          future: futureDog,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: Column(
                children: <Widget>[
                  
TextField(
  keyboardType: TextInputType.number,
),

                  Text(
                    snapshot.data!.name,
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                    width: size.width,
                    height: size.height*0.4,
                    child: Image.network(
                      snapshot.data!.image_link,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
