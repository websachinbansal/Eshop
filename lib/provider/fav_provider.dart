import 'package:flutter/material.dart';
import '../models/favs_attr.dart';

class FavsProvider with ChangeNotifier {
  final Map<String, FavsAttr> _favsItems = {};
  Map<String, FavsAttr> get getFavsItems {
    return {..._favsItems};
  }

  void addAndRemoveFromFav(
      String productID, double price, String title, String imgUrl) {
    if (_favsItems.containsKey(productID)) {
      removeItem(productID);
    } else {
      _favsItems.putIfAbsent(
          productID,
          () => FavsAttr(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              imageUrl: imgUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _favsItems.remove(productId);
    notifyListeners();
  }

  void clearFavs() {
    _favsItems.clear();
    notifyListeners();
  }
}
