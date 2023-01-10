import 'package:app_pandoro/widgets/app_icon.dart';
import 'package:app_pandoro/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/expandable_text.dart';


class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 85,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
                child: Center(child: BigText(text: product.name!, size: Dimensions.font26)),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableText(text: product.description!),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    icon: Icons.remove,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24),
                BigText(text: "${product.price!}  x  0", color: AppColors.mainBlackColor, size: Dimensions.font26),
                AppIcon(icon: Icons.add,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24)
              ],
            ),
          ),
          Container(
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
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  )
                ),
                // add product to cart container
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  child: BigText(text: "${product.price!} | Añadir al carrito", color: Colors.white),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
