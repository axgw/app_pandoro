import 'package:app_pandoro/pages/food/popular_food_detail.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/food/recommended_food_detail.dart';
import '../pages/home/main_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String foodDetail = "/food_detail";
  static const String recommendedFoodDetail = "/recommended_food_detail";
  static const String cartPage = "/cart_page";


  static String getInitial() => initial;
  static String getFoodDetail(int pageId) => '$foodDetail?pageId=$pageId';
  static String getRecommendedFoodDetail(int pageId) => '$recommendedFoodDetail?pageId=$pageId';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () {
    return const MainPage();
  },
    transition: Transition.fadeIn,
  ),
    GetPage(name: foodDetail, page: () {
      var pageId = Get.parameters['pageId'];
      return PopularFoodDetail(pageId:int.parse(pageId!));
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: recommendedFoodDetail, page: () {
      var pageId = Get.parameters['pageId'];
      return RecommendedFoodDetail(pageId:int.parse(pageId!));
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: cartPage, page: () {
      return CartPage();
    },
      transition: Transition.fadeIn,
    ),
  ];
}