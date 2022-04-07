import 'package:currency_converter/screens/detail.dart';
import 'package:currency_converter/screens/home.dart';
import 'package:currency_converter/screens/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/detail': (context) => Detail(),
      },
    );
  }
}
