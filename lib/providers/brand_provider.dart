import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/brand_model.dart';

class BrandProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final List<BrandModel> _brands = [];

  List<BrandModel> get brands => _brands;

  Stream<List<BrandModel>> streamBrands() {
    return _db.collection('brands').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return BrandModel.fromSnapshot(doc);
      }).toList();
    });
  }
}