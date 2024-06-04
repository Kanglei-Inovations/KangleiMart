import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kangleimart/utils/color_const.dart';
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
  final int rating;

  ProductItem(this.id, this.title, this.imageUrl, bool isFavorite, this.price,
      this.rating);

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
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: Stack( children: [
          Stack(
            children: [
              Column(
                children: <Widget>[
                  Flexible(
                    flex:2,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 200, // Set a height for the container
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(imageUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(

                      child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'To create a rating star widget in Flutter, you can use the SmoothStarRating package or build a custom widget. ',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        rupee + price.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      RatingBarIndicator(
                        rating: rating.toDouble(),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 25.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ))
                  // SizedBox(height: 5),
                ],
              ),

            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Expanded(
                  child:  MaterialButton(
                    onPressed: () {
                      // Define what happens when the button is pressed
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('MaterialButton pressed!'))
                      );
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    splashColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0))
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 1,),
                Expanded(
                  child:  MaterialButton(
                    onPressed: () {
                      cart.addItem(
                          id, title, 0); // Provide the price here as needed
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
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    splashColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.0))
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),              ],
            ),
          )
        ]),
      ),
    );
  }
}
