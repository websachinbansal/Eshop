import 'package:flutter/material.dart';

import '../models/cart_attribute.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartAttribute> _cartItems = {};
  Map<String, CartAttribute> get getCartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
      // print(value.price);
      // print(value.quantity);
      // print(total);
    });
    return total;
  }

  void addProductToCart(
      String productID, double price, String title, String imgUrl) {
    if (_cartItems.containsKey(productID)) {
      _cartItems.update(
          productID,
          (exitingCartItem) => CartAttribute(
              id: exitingCartItem.id,
              title: exitingCartItem.title,
              quantity: exitingCartItem.quantity + 1,
              price: exitingCartItem.price,
              imageUrl: exitingCartItem.imageUrl));
    } else {
      _cartItems.putIfAbsent(
          productID,
          () => CartAttribute(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              imageUrl: imgUrl));
    }
    notifyListeners();
  }

  void subtractProductToCart(
      String productID,
       //double price, String title, String imgUrl
       ) {
    if (_cartItems.containsKey(productID)) {
      _cartItems.update(
          productID,
          (exitingCartItem) => CartAttribute(
              id: exitingCartItem.id,
              title: exitingCartItem.title,
              quantity: exitingCartItem.quantity - 1,
              price: exitingCartItem.price,
              imageUrl: exitingCartItem.imageUrl));
      notifyListeners();
    }
  }

  void reoveItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
