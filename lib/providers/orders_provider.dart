import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_item.dart';
import '../models/order_item.dart';
// Import the OrderProduct class

class OrdersProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try {
      final List<OrderItem> loadedOrders = [];
      final ordersSnapshot = await _firestore.collection('orders').get();
      for (var orderDoc in ordersSnapshot.docs) {
        final List<CartItem> cartProducts = (orderDoc.data()['products'] as List<dynamic>).map((item) {
          return CartItem(
            id: item['id'],
            title: item['title'],
            quantity: item['quantity'],
            price: item['price'],
          );
        }).toList();

        final List<OrderProduct> orderProducts = cartProducts.map((cartItem) {
          return OrderProduct(
            id: cartItem.id,
            title: cartItem.title,
            quantity: cartItem.quantity,
            price: cartItem.price,
          );
        }).toList();

        final order = OrderItem(
          id: orderDoc.id,
          amount: orderDoc.data()['amount'],
          dateTime: (orderDoc.data()['dateTime'] as Timestamp).toDate(),
          products: orderProducts,
        );

        loadedOrders.add(order);
      }

      _orders = loadedOrders;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double totalAmount) async {
    try {
      final timestamp = Timestamp.now();
      final response = await _firestore.collection('orders').add({
        'amount': totalAmount,
        'dateTime': timestamp,
        'products': cartProducts.map((product) => product.toMap()).toList(),
      });

      final List<OrderProduct> orderProducts = cartProducts.map((cartItem) {
        return OrderProduct(
          id: cartItem.id,
          title: cartItem.title,
          quantity: cartItem.quantity,
          price: cartItem.price,
        );
      }).toList();

      final newOrder = OrderItem(
        id: response.id,
        amount: totalAmount,
        dateTime: timestamp.toDate(),
        products: orderProducts,
      );

      _orders.insert(0, newOrder);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
