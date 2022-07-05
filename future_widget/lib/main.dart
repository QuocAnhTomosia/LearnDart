import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Dog> fetchDog() async {
  final response =
      await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Dog.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Dog {
  final String message;
  final String status;

  const Dog({
    required this.message,
    required this.status,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      message: json['message'],
      status: json['status'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Dog> futureDog;

  @override
  void initState() {
    super.initState();
    futureDog = fetchDog();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Dog>(
            future: futureDog,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container( child: Column(children: <Widget>[
                  Text(snapshot.data!.status),
                  Container(child: Image.network(snapshot.data!.message,fit: BoxFit.cover,),)],));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
