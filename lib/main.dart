import 'package:flutter/material.dart';
import 'package:flutter_application/views/screens/home_screen.dart';
import 'package:get/route_manager.dart';

void main(List<String> args) {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}