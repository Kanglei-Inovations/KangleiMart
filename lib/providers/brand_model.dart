import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
  });

  // Factory constructor to create an empty BrandModel
  factory BrandModel.empty() {
    return BrandModel(
      id: '',
      name: '',
      image: '',
      isFeatured: false,
    );
  }

  // Method to convert a BrandModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
    };
  }

  // Factory constructor to create a BrandModel from a JSON map
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      isFeatured: json['IsFeatured'] ?? false,
    );
  }

  // Factory constructor to create a BrandModel from a Firestore document snapshot
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data != null) {
      return BrandModel(
        id: snapshot.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    }
    return BrandModel.empty();
  }
}
