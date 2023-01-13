import 'package:app_pandoro/controllers/popular_product_controller.dart';
import 'package:app_pandoro/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_pandoro/helper/dependencies.dart' as dep;

import 'controllers/recommended_product_controller.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      Get.find<PopularProductController>().getPopularProductList();
      Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //home: MainPage(),
      initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes,
      //getPages: RouteHelper.routes[].page,
    );
  }
}
