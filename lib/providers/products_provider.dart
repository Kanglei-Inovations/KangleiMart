import 'package:flutter/material.dart';
import '../models/product.dart';


class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async {

  }

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }
}
