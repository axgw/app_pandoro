import 'package:app_pandoro/data/api/api_client.dart';
import 'package:app_pandoro/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    // endpoint
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}