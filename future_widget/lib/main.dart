import 'dart:async';
import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:future_widget/const.dart';
import 'package:future_widget/models/dog.dart';
import 'package:future_widget/view_models/dogs_view_model.dart';
import 'package:future_widget/views/home_views/home_view.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_sources/api_services.dart';
import 'widgets/stars_widget.dart';

void main()  => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DogsProvider()..set(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fetch Data Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeView(),
      ),
    );
  }
}

