import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('products').get();
      final List<Product> loadedProducts = [];
      snapshot.docs.forEach((doc) {
        loadedProducts.add(Product(
          id: doc.id,
          title: doc['title'],
          description: doc['description'],
          price: doc['price'],
          imageUrl: doc['imageUrl'],
          category: doc['category'],
          stock: doc['stock'],
          rating: doc['rating'],
          createdAt: doc['createdAt'].toDate(),
        ));
      });
      _products = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }
}
