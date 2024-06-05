import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
///import 'package:firebase_storage/firebase_storage.dart';
import '../models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  ///final FirebaseStorage _storage = FirebaseStorage.instance;
  final List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  Stream<List<CategoryModel>> streamCategories() {
    return _db.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CategoryModel.fromSnapshot(doc);
      }).toList();
    });
  }

}