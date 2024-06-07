import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class SingleProductScreen extends StatefulWidget {
  final ProductModel product;

  SingleProductScreen({required this.product});

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  Future<String> getCategoryName(String categoryId) async {
    final categoryDoc = await FirebaseFirestore.instance.collection('categories').doc(categoryId).get();
    return categoryDoc.data()?['Name'] ?? 'N/A';
  }

  Future<String> getBrandName(String brandId) async {
    final brandDoc = await FirebaseFirestore.instance.collection('brands').doc(brandId).get();
    return brandDoc.data()?['Name'] ?? 'N/A';
  }
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 400, // Adjust the height as needed
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl:  widget.product.images![_selectedIndex],
                          //widget.product.images!.first,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100, // Adjust the height as needed
                    child: ListView.separated(
                      itemCount: widget.product.images?.length ?? 0, // Ensure itemCount matches the number of images
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, __) => const SizedBox(width: 5),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: CachedNetworkImage(
                            imageUrl: widget.product.images![index],
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: \$${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                  if (widget.product.salesPrice != null && widget.product.salesPrice! < widget.product.price)
                    Text(
                      'Sale Price: \$${widget.product.salesPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  SizedBox(height: 8),
                  Text(
                    'Stock: ${widget.product.stock}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  FutureBuilder<String>(
                    future: getBrandName(widget.product.brandId ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Brand: Loading...',
                          style: TextStyle(fontSize: 18),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Brand: Error loading brand',
                          style: TextStyle(fontSize: 18),
                        );
                      } else {
                        return Text(
                          'Brand: ${snapshot.data}',
                          style: TextStyle(fontSize: 18),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  FutureBuilder<String>(
                    future: getCategoryName(widget.product.categoryId ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Category: Loading...',
                          style: TextStyle(fontSize: 18),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Category: Error loading category',
                          style: TextStyle(fontSize: 18),
                        );
                      } else {
                        return Text(
                          'Category: ${snapshot.data}',
                          style: TextStyle(fontSize: 18),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Variations:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.product.productVariations?.length ?? 0,
                    itemBuilder: (context, index) {
                      final variation = widget.product.productVariations![index];
                      return ListTile(
                        title: Text('SKU: ${variation.sku}'),
                        subtitle: Text('Price: \$${variation.price.toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}