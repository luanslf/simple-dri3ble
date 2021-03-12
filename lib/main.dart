import 'package:flutter/material.dart';
import 'package:simple_dri3ble/pages/login_page/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
          headline3: TextStyle(color: Colors.black),
        ),
        buttonColor: Color(0xFFFF0081),
        backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
