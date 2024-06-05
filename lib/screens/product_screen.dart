import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/ProductScreen';

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context)!.settings.arguments as String;
    // final loadedProduct = Provider.of<ProductProvider>(
    //   context,
    //   listen: false,
    // ).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: StreamBuilder<List<ProductModel>>(
        stream: Provider.of<ProductProvider>(context).streamProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${product.price.toStringAsFixed(2)}'),
                      Text('Stock: ${product.stock}'),
                      Text('Brand: ${product.brand?.name ?? 'N/A'}'),
                      Text('Category: ${product.categoryId ?? 'N/A'}'),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.thumbnail),
                  ),
                  onTap: () {
                    // Navigate to product details screen
                  },
                );
              },
            );
          }
        },
      ),

      // SingleChildScrollView(
      //   child: Column(
      //     children: <Widget>[
      //       SizedBox(
      //         height: 300,
      //         width: double.infinity,
      //         child: CachedNetworkImage(
      //           imageUrl: loadedProduct.imageUrl,
      //           imageBuilder: (context, imageProvider) => Container(
      //             decoration: BoxDecoration(
      //               image: DecorationImage(
      //                 image: imageProvider,
      //                 fit: BoxFit.fitHeight,
      //
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       Text(
      //         '${loadedProduct.stock}',
      //         style: const TextStyle(
      //           color: Colors.grey,
      //           fontSize: 20,
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       Container(
      //         padding: const EdgeInsets.symmetric(horizontal: 10),
      //         width: double.infinity,
      //         child: Text(
      //           loadedProduct.description,
      //           textAlign: TextAlign.center,
      //           softWrap: true,
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       ElevatedButton(
      //         onPressed: () {
      //           Provider.of<CartProvider>(context, listen: false).addItem(
      //             loadedProduct.id,
      //             loadedProduct.title,
      //             loadedProduct.price,
      //           );
      //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             SnackBar(
      //               content: const Text('Added item to cart!'),
      //               duration: const Duration(seconds: 2),
      //               action: SnackBarAction(
      //                 label: 'UNDO',
      //                 onPressed: () {
      //                   Provider.of<CartProvider>(context, listen: false)
      //                       .removeSingleItem(loadedProduct.id);
      //                 },
      //               ),
      //             ),
      //           );
      //         },
      //         child: const Text('Add to Cart'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
