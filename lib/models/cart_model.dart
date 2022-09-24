import 'dart:collection';

import 'package:api/models/product_model.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  List<Product> products = [];

  UnmodifiableListView<Product> get items => UnmodifiableListView(products);

  void addToCart(Product product) {
    products.add(product);
    notifyListeners();
  }

  void removeAll() {
    products.clear();
    notifyListeners();
  }

  double get total {
    double tottal = 0;
    for (var element in products) {
      tottal += element.price;
    }
    return tottal;
  }

  List<Product> get productsList {
    return products;
  }

  int get length {
    return products.length;
  }
}
