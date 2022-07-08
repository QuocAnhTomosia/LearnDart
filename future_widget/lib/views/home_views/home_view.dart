
import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:future_widget/views/home_views/dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const.dart';
import '../../models/dog.dart';
import '../../view_models/dogs_view_model.dart';
import '../../widgets/stars_widget.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _DisplayState();
}

class _DisplayState extends State<HomeView> {
  TextEditingController _controller = TextEditingController();
  String? recentImageBase64 = MyConstant.initString;

  Future<void> networkImageToBase64(String imageUrl) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    setState(() {
      recentImageBase64 = (bytes != null ? base64Encode(bytes) : null);
      sharedPreferences.setString("image_link", recentImageBase64!);
    });
  }

  void loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      recentImageBase64 =
          preferences.getString("image_link") ?? MyConstant.initString;
      print(recentImageBase64);
    });
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Image.memory(base64.decode(recentImageBase64!)),
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
                  Provider.of<DogsProvider>(context, listen: false)
                      .fetchData(_controller.text.toString());
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              DisplayCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayCard extends StatelessWidget {
  
  DisplayCard({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Consumer<DogsProvider>(builder: ((context, value, child) {
      return FutureBuilder<List<Dog>>(
          future: value.dogsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length != 0) {
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
                                                InkWell(
                                                  onLongPress: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          MyDiaLog(
                                                              img_link: snapshot
                                                                  .data![i]
                                                                  .image_link,
                                                              parentContext:
                                                                  context),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: size.width,
                                                    height: size.height * 0.4,
                                                    child: Image.network(
                                                      snapshot
                                                          .data![i].image_link,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          "good_with_children"),
                                                      RatingStar(
                                                          star: snapshot
                                                              .data![i]
                                                              .good_with_childrens)
                                                    ],
                                                  ),
                                                ),
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
              }
              else
              {
                return const CircularProgressIndicator();
              }
            }
            else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          });
    }));
  }
}


