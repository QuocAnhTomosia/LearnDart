import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/view_models/note_view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.build))],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "To Do App",
        ),
      ),
      body: Column(
        children: <Widget>[
          Consumer<NotesProvider>(
            builder: (context, value, child) => FutureBuilder<List<Note>>(
              future: value.fetchAllNotes(),
              builder: (context, snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  
                  return Flexible(
                    child: ReorderableListView(
                        scrollDirection: Axis.vertical,
                        onReorder: (int oldIndex, int newIndex) {},
                        children: snapshot.data!
                            .map((e) => OpenContainer(
                                key: Key('$e.id'),
                                closedBuilder: (context, action) => Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.title,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(e.start),
                                            Text(e.end),
                                            const Divider(
                                              height: 1,
                                              thickness: 1,
                                              indent: 1,
                                              endIndent: 0,
                                              color: Colors.black,
                                            ),
                                          ]),
                                    ),
                                openBuilder: (context, action) => Scaffold(
                                    floatingActionButton: FloatingActionButton(
                                        child: Icon(Icons.delete),
                                        onPressed: () async {
                                          value.delete(e.id!);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        }),
                                    appBar: AppBar(),
                                    body: Container(
                                      child: Column(children: [
                                        Text(e.title),
                                        Text(e.details),
                                        Text(e.start),
                                        Text(e.end),
                                      ]),
                                    ))))
                            .toList()),
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pushNamed(context, '/add');
          },
          child: Icon(Icons
              .add)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
