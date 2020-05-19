import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'src/screens/my_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Contact App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              textTheme: TextTheme(
                  title: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)))),
      title: appTitle,
      home: MyHomePage(),
    );
  }
}
