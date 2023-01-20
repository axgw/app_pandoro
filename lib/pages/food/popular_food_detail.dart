import 'package:app_pandoro/controllers/popular_product_controller.dart';
import 'package:app_pandoro/pages/home/food_page_body.dart';
import 'package:app_pandoro/utils/dimensions.dart';
import 'package:app_pandoro/widgets/app_column.dart';
import 'package:app_pandoro/widgets/app_icon.dart';
import 'package:app_pandoro/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../cart/cart_page.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.foodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                  )
                )
              ),
      ),
          ),
          // icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){
                      if (page == "cartpage") {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.arrow_back_rounded)),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1) {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: Stack (
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1?
                        Positioned(
                            right: 0, top: 0,
                            child: GestureDetector(
                                onTap: () {
                                  Get.toNamed( RouteHelper.getCartPage());
                                },
                                child: AppIcon(icon: Icons.circle, size: 20, iconColor: Colors.transparent, backgroundColor: AppColors.mainColor,))):
                          Container(),
                        Get.find<PopularProductController>().totalItems >= 1?
                        Positioned(
                            right: 6, top: 3,
                            child: BigText(text: Get.find<PopularProductController>().totalItems.toString(), size: 12, color: Colors.white)):
                        Container(),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
          // food description
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.foodImgSize-20,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Descripción"),
                  SizedBox(height: Dimensions.height20),
                  Expanded(child: SingleChildScrollView(child: ExpandableText(text: product.description!))),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height15*2, bottom: Dimensions.height15*2, left: Dimensions.width20, right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // increase/decrease items container
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: const Icon(Icons.remove, color: AppColors.signColor)),
                    SizedBox(width: Dimensions.width10/2),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2),
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: const Icon(Icons.add, color: AppColors.signColor)),
                  ],
                ),
              ),
              // add product to cart container
              GestureDetector(
                onTap: () {
                  popularProduct.addItem(product);

                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                  
                      child: BigText(text: "${product.price!} € | Añadir al carrito", color: Colors.white)),
              ),
            ],
          ),
        );
      }),
    );
  }
}
