import 'package:flutter/material.dart';
import 'package:todolist/homepage.dart';
import 'package:todolist/loginpage.dart';

void main() {
  runApp(const MyApp());
}

String username = '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage(),
      // routes: <String, WidgetBuilder>{
      //   '/HomePage': (BuildContext context) => new HomePage()
      // },
    );
  }
}
