import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  // Stream to fetch products from Firestore
  Stream<List<Product>> productsStream() {
    return FirebaseFirestore.instance.collection('products').snapshots().map((snapshot) {
      final List<Product> loadedProducts = [];
      snapshot.docs.forEach((doc) {
        loadedProducts.add(Product(
          id: doc.id,
          title: doc['title'],
          description: doc['description'],
          price: doc['price'].toDouble(),
          imageUrl: doc['imageUrl'],
          category: doc['category'],
          stock: doc['stock'],
          rating: doc['rating'],
          createdAt: doc['createdAt'],
        ));
      });
      _products = loadedProducts;
      notifyListeners();
      return _products;
    });
  }

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }
}
