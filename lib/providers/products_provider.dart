import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final List<ProductModel> _products = [];
  Map<String, String> _categoryNames = {};
  // Cache category names
  List<ProductModel> get products {
    return [..._products];
  }

  Stream<List<ProductModel>> streamProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList());
  }

  ProductModel findById(String id) {
     return _products.firstWhere((prod) => prod.id == id);
  }

  Future<String> getCategoryName(String categoryId) async {
    if (_categoryNames.containsKey(categoryId)) {
      return _categoryNames[categoryId]!;
    } else {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _db.collection('categories').doc(categoryId).get();
      if (snapshot.exists) {
        CategoryModel category = CategoryModel.fromSnapshot(snapshot);
        _categoryNames[categoryId] = category.name;
        return category.name;
      } else {
        return 'Unknown';
      }
    }
  }
}


// class ProductsProvider with ChangeNotifier {
//   List<Product> _products = [];
//
//   List<Product> get products {
//     return [..._products];
//   }
//
//   // Stream to fetch products from Firestore
//   Stream<List<Product>> productsStream() {
//     return FirebaseFirestore.instance.collection('products').snapshots().map((snapshot) {
//       final List<Product> loadedProducts = [];
//       snapshot.docs.forEach((doc) {
//         loadedProducts.add(Product(
//           id: doc.id,
//           title: doc['title'],
//           description: doc['description'],
//           price: doc['price'].toDouble(),
//           imageUrl: doc['imageUrl'],
//           category: doc['category'],
//           stock: doc['stock'],
//           rating: doc['rating'],
//           createdAt: doc['createdAt'],
//         ));
//       });
//       _products = loadedProducts;
//       notifyListeners();
//       return _products;
//     });
//   }
//
//   Product findById(String id) {
//     return _products.firstWhere((prod) => prod.id == id);
//   }
// }

