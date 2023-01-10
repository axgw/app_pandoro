import 'package:app_pandoro/utils/app_constants.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    // endpoint
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}