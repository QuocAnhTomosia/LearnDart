import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? selectedId;
  TextEditingController _controller = TextEditingController();
  

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("SQL example"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(height: size.height * 0.1, child: TextFormField(controller: _controller,)),
              Container(child: Center(
            child: FutureBuilder<List<Grocery>>(
                future: DatabaseHelper.instance.getGroceries(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Grocery>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Loading...'));
                  }
                  return snapshot.data!.isEmpty
                      ? Center(child: Text('No Groceries in List.'))
                      : ListView(
                        shrinkWrap: true,
                          children: snapshot.data!.map((grocery) {
                            return Container(
                              child: Center(
                                child: Card(
                                  color: selectedId == grocery.id
                                      ? Colors.white70
                                      : Colors.white,
                                  child: ListTile(
                                    title: Text(grocery.name+grocery.id.toString()),
                                    onTap: () {
                                      setState(() {
                                        if (selectedId == null) {
                                          _controller.text = grocery.name;
                                          selectedId = grocery.id;
                                        } else {
                                          _controller.text = '';
                                          selectedId = null;
                                        }
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        DatabaseHelper.instance.remove(grocery.id!);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                }),
          ),),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            selectedId != null
                ? await DatabaseHelper.instance.update(
                    Grocery(id: selectedId, name: _controller.text),
                  )
                : await DatabaseHelper.instance.add(
                    Grocery(name: _controller.text),
                  );
            setState(() {
              _controller.clear();
              selectedId = null;
            });
          },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
