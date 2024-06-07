import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class SingleProductScreen extends StatelessWidget {
  final ProductModel product;

  SingleProductScreen({required this.product});

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
                  height: 200, // Adjust the height as needed
                  child: PageView.builder(
                    itemCount: product.images!.length,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(imageUrl: product.images![index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Price: \$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      if (product.salesPrice != null && product.salesPrice! < product.price)
                        Text(
                          'Sale Price: \$${product.salesPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      SizedBox(height: 8),
                      Text(
                        'Stock: ${product.stock}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Brand: ${product.categoryId}', // Replace with actual brand name if available
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Variations:', // You can customize this section according to your model structure
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: product.productVariations!.length,
                        itemBuilder: (context, index) {
                          final variation = product.productVariations![index];
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