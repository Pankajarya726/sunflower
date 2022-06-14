import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:practice/endpoints.dart';
import 'package:practice/home/home_screen.dart';

BaseOptions options = BaseOptions(baseUrl: Endpoints.baseUrl);
Dio dio = Dio(options);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(),
    );
  }
}
