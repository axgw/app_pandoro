import 'package:app_pandoro/controllers/popular_product_controller.dart';
import 'package:app_pandoro/controllers/recommended_product_controller.dart';
import 'package:app_pandoro/models/products_model.dart';
import 'package:app_pandoro/pages/food/popular_food_detail.dart';
import 'package:app_pandoro/routes/route_helper.dart';
import 'package:app_pandoro/utils/dimensions.dart';
import 'package:app_pandoro/widgets/big_text.dart';
import 'package:app_pandoro/widgets/icon_and_text_widget.dart';
import 'package:app_pandoro/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_pandoro/utils/colors.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../../widgets/app_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          if (popularProducts.isLoaded) {
            return SizedBox(
            height: 320,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),
            );
          } else {
            return const CircularProgressIndicator(
            color: AppColors.mainColor,
          );
          }
        }),
        // dots under slider
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              activeColor: AppColors.mainColor,
            ),
          );
        }),
        // popular items
        SizedBox(height: Dimensions.height10*3),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width15*2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recomendado"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3.5),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing", color: Colors.black26),
              ),
            ],
          ),
        ),
        // list of food and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded?ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFoodDetail(index, "home"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        // image section
                        Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                  )
                              )
                          ),
                        ),
                        // text container
                        Expanded(
                          child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding (
                                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: recommendedProduct.recommendedProductList[index].name!, size: 13),
                                    SizedBox(height: Dimensions.height10),
                                    SmallText(text: "Descripción"),
                                    SizedBox(height: Dimensions.height10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        IconAndTextWidget(icon: Icons.spa, text: "Normal", iconColor: AppColors.iconColor1),
                                        IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.mainColor),
                                        IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor2),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }):const CircularProgressIndicator(color: AppColors.mainColor);
        })
      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = Matrix4.identity();
    if(index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index)*(1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor()+1) {
      var currScale = _scaleFactor + (_currPageValue - index + 1)*(1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor()+1) {
      var currScale = 1 - (_currPageValue - index)*(1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getFoodDetail(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven?Color(0xFFffd379):Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width10*3, right: Dimensions.width10*3, bottom: Dimensions.height10*3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 6.0,
                      offset: Offset(0, 5)
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                  ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: 15, right: 15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
