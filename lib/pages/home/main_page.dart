import 'package:app_pandoro/pages/home/food_page_body.dart';
import 'package:app_pandoro/utils/colors.dart';
import 'package:app_pandoro/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_pandoro/widgets/big_text.dart';
import 'package:app_pandoro/widgets/small_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "España", color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: "Alicante", color: Colors.black54, size: 10),
                          const Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.width45,
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,

                      ),
                      child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24)
                    ),
                  )
                ],
              ),
            )
          ),
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          )),
        ],
      )
    ); //
  }
}
