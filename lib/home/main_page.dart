import 'package:app_pandoro/home/food_page_body.dart';
import 'package:app_pandoro/utils/colors.dart';
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
              margin: EdgeInsets.only(top: 45, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
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
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.mainColor,

                      ),
                      child: const Icon(Icons.search, color: Colors.white)
                    ),
                  )
                ],
              ),
            )
          ),
          FoodPageBody(),
        ],
      )
    ); //
  }
}
