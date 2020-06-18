import 'package:enamazonas/src/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'enAmazonas radio',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
    );
  }
}
