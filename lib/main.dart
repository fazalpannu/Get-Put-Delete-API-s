// import 'package:ch10/example1.dart';
// import 'package:ch10/exampletwo.dart';
// import 'package:ch10/home.dart';
// import 'package:ch10/signup.dart';
import 'package:ch10/upload_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: uploadimage(),
    );
  }
}
