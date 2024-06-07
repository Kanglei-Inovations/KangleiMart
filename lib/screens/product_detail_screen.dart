import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product_model.dart';
import '../widgets/photo_view_gallery_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  ProductDetailScreen({required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<String> getCategoryName(String categoryId) async {
    final categoryDoc = await FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId)
        .get();
    return categoryDoc.data()?['Name'] ?? 'N/A';
  }

  Future<String> getBrandName(String brandId) async {
    final brandDoc = await FirebaseFirestore.instance
        .collection('brands')
        .doc(brandId)
        .get();
    return brandDoc.data()?['Name'] ?? 'N/A';
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Product Details'),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.product.title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stock: ${widget.product.stock}',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                FutureBuilder<String>(
                  future: getBrandName(widget.product.brandId ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        'Brand: Loading...',
                        style: TextStyle(fontSize: 14.sp),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Brand: Error loading brand',
                        style: TextStyle(fontSize: 14.sp, color: Colors.red),
                      );
                    } else {
                      return Text(
                        'Brand: ${snapshot.data}',
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      );
                    }
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 300.sp, // Adjust the height as needed
              child: Row(
                children: [
                  Container(
                    width: 60.sp, // Adjust the height as needed
                    child: ListView.separated(
                      itemCount: widget.product.images?.length ??
                          0, // Ensure itemCount matches the number of images
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (_, __) => const SizedBox(width: 5),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.product.images![index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () =>
                              _openPhotoViewer(context, _selectedIndex),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.images![_selectedIndex],
                            //widget.product.images!.first,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  'Price: \$${widget.product.price.toStringAsFixed(2)}',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                if (widget.product.salesPrice != null &&
                    widget.product.salesPrice! < widget.product.price)
                  Text(
                    'Sale Price: \$${widget.product.salesPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
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
                      subtitle: Text(
                          'Price: \$${variation.price.toStringAsFixed(2)}'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openPhotoViewer(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewGalleryScreen(
          images: widget.product.images!,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}
