import 'package:flutter/material.dart';
import 'package:weatherapp/pages/home_page.dart'; // Importing HomePage from the home_page.dart file

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(), // Using HomePage as the home screen
    );
  }
}
