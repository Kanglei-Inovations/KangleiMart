import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

      body: FutureBuilder(
        future: Provider.of<ProductsProvider>(context, listen: false).fetchProducts(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.hasError) {
              // Print the error message to the console
              print(dataSnapshot.error);
              return Center(child: Text('An error occurred!'));
            } else {
              return Consumer<ProductsProvider>(
                builder: (ctx, productsData, child) => GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: productsData.products.length,
                  itemBuilder: (ctx, i) => ProductItem(
                    productsData.products[i].id,
                    productsData.products[i].title,
                    productsData.products[i].imageUrl,
                    productsData.products[i].isFavorite,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              );
            }
          }
        },
      ),

    );
  }
}
