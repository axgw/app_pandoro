import 'package:app_pandoro/pages/food/popular_food_detail.dart';
import 'package:app_pandoro/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/food/recommended_food_detail.dart';
import '../pages/home/home_page.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String initial = "/";
  static const String foodDetail = "/food_detail";
  static const String recommendedFoodDetail = "/recommended_food_detail";
  static const String cartPage = "/cart_page";

  static String getSplashScreen() => splashScreen;
  static String getInitial() => initial;
  static String getFoodDetail(int pageId, String page) => '$foodDetail?pageId=$pageId&page=$page';
  static String getRecommendedFoodDetail(int pageId, String page) => '$recommendedFoodDetail?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () {
      return const SplashScreen();
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: initial, page: () {
    return const HomePage();
  },
    transition: Transition.fadeIn,
  ),
    GetPage(name: foodDetail, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return PopularFoodDetail(pageId:int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: recommendedFoodDetail, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return RecommendedFoodDetail(pageId:int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: cartPage, page: () {
      return const CartPage();
    },
      transition: Transition.fadeIn,
    ),
  ];
}