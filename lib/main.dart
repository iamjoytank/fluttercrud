import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'SignUpPage.dart';
import 'homepage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firabase sanple app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context) => new MyApp(),
        '/signup': (BuildContext context) => new SignUpPage(),
        '/homepage' : (BuildContext context) => new HomePage()
      },
    );
  }
}
