import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';
import '../widgets/order_item.dart'; // Adjusted import statement
import '../widgets/custom_drawer.dart';
import '../models/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/OrdersScreen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),

      body:
      ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItemWidget(orderData.orders[i]),
      ),
    );
  }
}
