import 'package:flutter/material.dart';
import 'package:simple_dri3ble/pages/home_page/home_page.dart';
import 'package:simple_dri3ble/pages/login_page/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Dribbble',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xFFFF0081),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Color(0xFFFF0081),
          contentTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
          headline3: TextStyle(color: Colors.black),
          headline6: TextStyle(color: Colors.black38),
          subtitle1: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w500,
          ),
        ),
        buttonColor: Color(0xFFFF0081),
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Color(0xFFFF0081),
          centerTitle: true,
          textTheme: TextTheme(
            headline5: TextStyle(color: Colors.white),
          ),
        ),
        focusColor: Color(0xFFFF0081),
        disabledColor: Colors.black12,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF0081),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      //home: HomePage(),
      home: LoginPage(),
    );
  }
}
