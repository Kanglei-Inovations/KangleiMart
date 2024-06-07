import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kangleimart/models/product.dart';
import 'package:kangleimart/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';
import 'SingleProductScreen.dart';

class HomeScreen extends StatefulWidget {
 static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available.'));
          } else {
            final products = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.all(4.sp),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2/3 // Adjust based on your design
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                double discountPercentage = 0;
                if (product.price > 0) {
                  discountPercentage =
                      ((product.price - product.salesPrice) / product.price) * 100;
                }

                return FutureBuilder<String>(
                  future: Provider.of<ProductProvider>(context, listen: false)
                      .getCategoryName(product.categoryId ?? ''),
                  builder: (context, categorySnapshot) {
                    if (categorySnapshot.connectionState == ConnectionState.waiting) {
                      return GridTile(
                        header: Text(product.title),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (categorySnapshot.hasError) {
                      return GridTile(
                        header: Text(product.title),
                        child: Center(child: Text('Error loading category')),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleProductScreen(product: product),
                            ),
                          );
                        },
                        child:ProductItem(
                          product.id,
                          product.title,
                          product.salesPrice.toStringAsFixed(2),
                          product.images?.first ?? '', // assuming there's always an image
                          product.stock,
                          categorySnapshot.data,
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
