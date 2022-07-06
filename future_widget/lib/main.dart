import 'dart:async';
import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class Dog {
  final String name;
  final String image_link;
  final int good_with_other_dogs;
  final int good_with_childrens;

  const Dog({
    required this.name,
    required this.image_link,
    required this.good_with_other_dogs,
    required this.good_with_childrens,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      name: json['name'],
      good_with_other_dogs: json['good_with_other_dogs'],
      image_link: json['image_link'],
      good_with_childrens: json['good_with_children'],
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
  TextEditingController _controller = TextEditingController();
  late Future<List<Dog>> futureDog;

  @override
  void initState() {
    super.initState();
    futureDog = fetchDog("");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  enableInteractiveSelection: false,
                  obscureText: false,
                  decoration: const InputDecoration(
                    hintText: 'Enter your favorite animal',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ElevatedButton(
                child: Text(
                  "submit",
                  style: TextStyle(),
                ),
                onPressed: () {
                  setState(() {
                    futureDog = fetchDog(_controller.text.toString());
                  });
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              FutureBuilder<List<Dog>>(
                future: futureDog,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.length > 0) {
                    return Container(
                      child: Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              for (int i = 0; i < snapshot.data!.length; i++)
                                Column(
                                  children: <Widget>[
                                    Text(snapshot.data![i].name),
                                    OpenContainer(
                                      closedBuilder: (context, action) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Container(
                                          width: size.width,
                                          height: size.height * 0.4,
                                          child: Image.network(
                                            snapshot.data![i].image_link,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      openBuilder: (BuildContext context,
                                          void Function({Object? returnValue})
                                              action) {
                                        return Scaffold(
                                          appBar:
                                              AppBar(title: Text("Details")),
                                          body: Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                      snapshot.data![i].name),
                                                ),
                                                Container(
                                                  width: size.width,
                                                  height: size.height * 0.4,
                                                  child: Image.network(
                                                    snapshot
                                                        .data![i].image_link,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(child: Row(children: [Text("good_with_children"),RatingStar(star: snapshot
                                                        .data![i].good_with_childrens)],),)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingStar extends StatelessWidget {
  int star = 0;
  RatingStar({Key? key, required int star}) : super(key: key)
  {
    this.star = star;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < star; i++)
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
      ],
    );
  }
}
