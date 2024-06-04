import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/product_screen.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  ProductItem(this.id, this.title, this.imageUrl, bool isFavorite, this.price);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final auth = Provider.of<AuthProviders>(context, listen: false);

    return GestureDetector(
      onTap: () {
        // Navigate to product details screen
        Navigator.of(context).pushNamed('/ProductScreen', arguments: id);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 10,
                top: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite ,
                    color: Colors.red,
                  ),
                  onPressed: () {},
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: imageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 5),
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    price.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle buy action
                          },
                          child: Text('Buy'),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                          ),
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () {
                            cart.addItem(id, title, 0); // Provide the price here as needed
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added item to cart!'),
                                duration: Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () {
                                    cart.removeSingleItem(id);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]
        ),
      ),
    );

  }
}
