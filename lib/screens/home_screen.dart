import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kangleimart/models/product.dart';
import 'package:kangleimart/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KangleiMart'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed('/CartPage');
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: StreamBuilder<List<ProductModel>>(
        stream: Provider.of<ProductProvider>(context).streamProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Print the error message to the console
            print(snapshot.error);
            return const Center(child: Text('An error occurred!'));
          } else {
            final products = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductItem(
                  product.id, product.title,
                  product.price.toStringAsFixed(2), product.thumbnail,
                  product.description.toString(),
                  product.brand
                  //product.thumbnail.toString()
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
          }
        },
      ),
    );
  }
}
