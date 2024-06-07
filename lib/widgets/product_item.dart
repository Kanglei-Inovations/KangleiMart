import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kangleimart/utils/color_const.dart';
import 'package:provider/provider.dart';
import '../models/brand_model.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/product_screen.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String? title;
  // final String? thumbnail;
  // final double? price;
  // final int? rating;
  //
  // const ProductItem(this.id, this.title, this.thumbnail, bool isFavorite, this.price,
  //     this.rating, {super.key});
  final String id;
  final String title;
  final String price;
  final String thumbnail;
  final String description;
   final String? brandId;


  ProductItem(this.id, this.title, this.price, this.thumbnail, this.description, this.brandId);
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
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        child: Stack(children: [
          Stack(
            children: [
              Column(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 140.h, // Set a height for the container
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(thumbnail!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          title,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                        description,
                        maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          rupee + price.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          brandId ?? 'N/A',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      // RatingBarIndicator(
                      //   rating: rating!.toDouble(),
                      //   itemBuilder: (context, index) => Icon(
                      //     Icons.star,
                      //     color: Colors.amber,
                      //   ),
                      //   itemCount: 5,
                      //   itemSize:18.sp,
                      //   direction: Axis.horizontal,
                      // ),
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
                  child: MaterialButton(
                    height: 30.h,
                    onPressed: () {
                      // Define what happens when the button is pressed
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('MaterialButton pressed!')));
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    splashColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0))),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                Expanded(
                  child: MaterialButton(
                    height: 30.h,
                    onPressed: () {
                      cart.addItem(
                          id, title!, 0); // Provide the price here as needed
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
                            bottomRight: Radius.circular(10.0))),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
