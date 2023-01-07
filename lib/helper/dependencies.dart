import 'package:app_pandoro/controllers/popular_product_controller.dart';
import 'package:app_pandoro/data/api/api_client.dart';
import 'package:app_pandoro/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

Future<void> init()async {
  // API client
  Get.lazyPut(() => ApiClient(appBaseUrl: "http://mvs.bslmeiyu.com"));
  // repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  // controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}