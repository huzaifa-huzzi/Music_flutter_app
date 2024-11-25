import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_2/lib/Views/Home/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beats',
      theme: ThemeData(
          fontFamily: 'regular',
          appBarTheme:const  AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0
          )
      ),
      home:const  Home(),
    );
  }
}

