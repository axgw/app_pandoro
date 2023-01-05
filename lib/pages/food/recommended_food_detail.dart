import 'package:app_pandoro/widgets/app_icon.dart';
import 'package:app_pandoro/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/small_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 85,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(
                child: Center(child: BigText(text: "Tarta de Queso Vegana", size: Dimensions.font26)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/vegan_cheesecake.jpg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableText(text: "According to the Sacher Hotel website, the story of the legendary chocolate cake filled with apricot jam began in 1832 in Vienna. Franz Sacher was a 16-year old apprentice at the court of Prince Metternich when he was asked to create an especially delicious dessert for distinguished guests. The guests loved it, and it became known as the Sacher Torte.Our take on this classic chocolate cake is both light and rich at the same time, with an airy cake, a simple apricot jam filling and a decadent bittersweet glaze. As the cake sits to allow the glaze to set, the jam becomes absorbed into the cake and forms a slightly sweet moist layer in the center, an exquisite finish to any holiday or special occasion. According to the Sacher Hotel website, the story of the legendary chocolate cake filled with apricot jam began in 1832 in Vienna. Franz Sacher was a 16-year old apprentice at the court of Prince Metternich when he was asked to create an especially delicious dessert for distinguished guests. The guests loved it, and it became known as the Sacher Torte.Our take on this classic chocolate cake is both light and rich at the same time, with an airy cake, a simple apricot jam filling and a decadent bittersweet glaze. As the cake sits to allow the glaze to set, the jam becomes absorbed into the cake and forms a slightly sweet moist layer in the center, an exquisite finish to any holiday or special occasion. According to the Sacher Hotel website, the story of the legendary chocolate cake filled with apricot jam began in 1832 in Vienna. Franz Sacher was a 16-year old apprentice at the court of Prince Metternich when he was asked to create an especially delicious dessert for distinguished guests. The guests loved it, and it became known as the Sacher Torte.Our take on this classic chocolate cake is both light and rich at the same time, with an airy cake, a simple apricot jam filling and a decadent bittersweet glaze. As the cake sits to allow the glaze to set, the jam becomes absorbed into the cake and forms a slightly sweet moist layer in the center, an exquisite finish to any holiday or special occasion. According to the Sacher Hotel website, the story of the legendary chocolate cake filled with apricot jam began in 1832 in Vienna. Franz Sacher was a 16-year old apprentice at the court of Prince Metternich when he was asked to create an especially delicious dessert for distinguished guests. The guests loved it, and it became known as the Sacher Torte.Our take on this classic chocolate cake is both light and rich at the same time, with an airy cake, a simple apricot jam filling and a decadent bittersweet glaze. As the cake sits to allow the glaze to set, the jam becomes absorbed into the cake and forms a slightly sweet moist layer in the center, an exquisite finish to any holiday or special occasion."),
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
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
                BigText(text: "11.99€ " + " x " + " 0", color: AppColors.mainBlackColor, size: Dimensions.font26),
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
                  child: BigText(text: "11.99€ | Añadir al carrito", color: Colors.white),
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
