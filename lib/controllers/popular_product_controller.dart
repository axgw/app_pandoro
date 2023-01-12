import 'package:app_pandoro/controllers/cart_controller.dart';
import 'package:app_pandoro/data/repository/popular_product_repo.dart';
import 'package:app_pandoro/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController ({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;


  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {

    }
}

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }
  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Cantidad", "No se puede reducir más.",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white
      );
      if (_inCartItems > 0) {
        _quantity = - _inCartItems;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 10) {
      Get.snackbar("Cantidad", "No se puede añadir más.",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white
      );
      return 10;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    //if exist
    // get from storage _inCartItems = 3
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }
  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    /*_cart.items.forEach((key,value) {
    });*/
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}

