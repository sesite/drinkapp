import 'package:drinkapp/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); //ыы
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
/*       title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ), */
      home: Wrapper(),
    );
  }
}
