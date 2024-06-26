import 'package:flutter/material.dart';
import 'package:practic/page.dart';
import 'package:practic/database.dart'; 


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context)=>AuthPage(),
        '/home': (context)=>HomePage(),
      },
    );
  }
}