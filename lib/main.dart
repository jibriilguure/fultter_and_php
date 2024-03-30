import 'package:flutter/material.dart';

import 'bottom navbar.dart';
import 'screens/news_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNav1(),
    );
  }
}
