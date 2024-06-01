import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<OrderProduct> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class OrderProduct {
  final String id;
  final String title;
  final double price;
  final int quantity;

  OrderProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}
