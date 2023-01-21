import 'package:app_pandoro/controllers/cart_controller.dart';
import 'package:app_pandoro/controllers/popular_product_controller.dart';
import 'package:app_pandoro/utils/app_constants.dart';
import 'package:app_pandoro/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.width20*3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24),
                SizedBox(width: Dimensions.width20*5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24),
                ),
                AppIcon(icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24)
              ],

              )
          ),
          GetBuilder<CartController>(builder: (_cartController){
            if (_cartController.getItems.isNotEmpty) {
              return Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    //color: Colors.red,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (cartController) {
                        var _cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return SizedBox(
                                  height: Dimensions.height20*5,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(_cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(RouteHelper.getFoodDetail(popularIndex, "home"));
                                            } else {
                                              var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList
                                                  .indexOf(_cartList[index].product!);
                                              if(recommendedIndex<0) {
                                                Get.snackbar("Historial", "El producto ya está no disponible.",
                                                    backgroundColor: AppColors.mainColor,
                                                    colorText: Colors.white
                                                );
                                              } else {
                                                Get.toNamed(RouteHelper.getRecommendedFoodDetail(recommendedIndex, "home"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20*5,
                                            height: Dimensions.height20*5,
                                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                                    )
                                                )
                                            ),
                                          )
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      Expanded(child: Container(
                                        height: Dimensions.height20*5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(text: cartController.getItems[index].name!, color: Colors.black54),
                                            SmallText(text: "Spicy"),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(text: "${cartController.getItems[index].price!} €", color: Colors.redAccent),
                                                Container(
                                                  padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width20, right: Dimensions.width20),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                      color: Colors.white
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(_cartList[index].product!, -1);
                                                          },
                                                          child: const Icon(Icons.remove, color: AppColors.signColor)),
                                                      SizedBox(width: Dimensions.width10/2),
                                                      BigText(text: _cartList[index].quantity!.toString()),//popularProduct.inCartItems.toString()),
                                                      SizedBox(width: Dimensions.width10/2),
                                                      GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(_cartList[index].product!, 1);
                                                          },
                                                          child: const Icon(Icons.add, color: AppColors.signColor)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ));
                            });
                      }),
                    ),
                ));
            } else {
              return const NoDataPage(text: "Tu cesta está vacía");
            }
          })
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
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
            child: cartController.getItems.isNotEmpty?Row(
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
                      SizedBox(width: Dimensions.width10/2),
                      BigText(text: "${cartController.totalAmount} €"),
                      SizedBox(width: Dimensions.width10/2),
                    ],
                  ),
                ),
                // add product to cart container
                GestureDetector(
                  onTap: () {
                    //popularProduct.addItem(product);
                    cartController.addToHistory();
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20/1.25, left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                      child: BigText(text: "Pagar", color: Colors.white,)),
                ),
              ],
            ):Container(),
          );
        }),
    );
  }
}
