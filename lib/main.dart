import 'package:app_pandoro/pages/food/food_detail.dart';
import 'package:app_pandoro/pages/food/recommended_food_detail.dart';
import 'package:app_pandoro/pages/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_pandoro/helper/dependencies.dart' as dep;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: RecommendedFoodDetail(),//const MainPage(),//const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
