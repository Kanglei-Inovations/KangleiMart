import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../utils/app_string_constant.dart';
import '../utils/text_const.dart';
import '../Controllers/variation_controller.dart';
import '../controllers/image_controller_product_screen.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';
import '../providers/products_provider.dart';
import '../utils/enums.dart';
import '../widgets/choice_clip.dart';
import '../widgets/product_detail_image_slider.dart';
import '../widgets/ratings_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final controller = Get.put(VariationController());
    final productController = Get.put(ProductController());
    final imageController = Get.put(ImageControllerProductScreen());

    final salePercentage = productController.calculateSalePercentage(
        product);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          controller.resetSelectedAttributes();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductDetailImageSlider(
                product: product,
                selectedProductImage: imageController.selectedProductImage,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Price.............
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.greenAccent,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                '${salePercentage}% OFF',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                            SizedBox(width: 10),
                            if (product.productType ==
                                ProductType.single.toString() &&
                                product.salesPrice > 0)
                              Text(
                                '₹${product.price}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey),
                              ),
                            Obx(() {
                              if (controller
                                  .selectedVariation.value.id.isNotEmpty) {
                                // Show the variation price if a variation is selected
                                return Row(
                                  children: [
                                    if (controller
                                        .selectedVariation.value.price >
                                        0)
                                      Text(
                                        'Rs. ${controller.getVariationPrice()}  ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            decoration:
                                            TextDecoration.lineThrough),
                                      ),
                                    Text(
                                      'Rs. ${controller.getVariationSalesPrice()}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              } else
                                product.productType ==
                                    ProductType.single.toString() &&
                                    product.salesPrice > 0;
                              {
                                // Show the product's single price before any variation is selected
                                return Column(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      'Rs. ${productController.getProductPrice(product)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    //Product Title............
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    //Stock.......................
                    Row(
                      children: [
                        Text('Stock:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          productController.getProductStockStatus(product),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: productController.Status(product)),
                        ),
                      ],
                    ),
                    //Brand ..............................................
                    if (product.brandId!.isNotEmpty) SizedBox(height: 8),
                    if (product.brandId!.isNotEmpty)
                      FutureBuilder<String>(
                        future: productProvider
                            .getBrandImage(product.brandId ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text('Brand: Loading...',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold));
                          } else if (snapshot.hasError) {
                            return Text('Brand: Error loading brand',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold));
                          } else {
                            // Use CachedNetworkImage to load the brand image
                            return Row(
                              children: [
                                Text(
                                  "Brand:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CachedNetworkImage(
                                  imageUrl: snapshot.data!,
                                  width: 30,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    if (product.brandId!.isNotEmpty)
                      SizedBox(height: 10),


                    if (product.productType == ProductType.variable.toString())
                      Column(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: product.productAttributes
                                  ?.map((attribute) => Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${attribute.name}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Obx(() => Wrap(
                                    spacing: 8,
                                    children: attribute.values!
                                        .map((attributeValue) {
                                      final isSelected =
                                          controller.selectedAttributes[
                                          attribute
                                              .name] ==
                                              attributeValue;
                                      final available = controller
                                          .getAttributesAvailabilityInVariation(
                                          product
                                              .productVariations!,
                                          attribute.name!)
                                          .contains(
                                          attributeValue);
                                      return KChoiceClip(
                                          text: attributeValue,
                                          selected: isSelected,
                                          onSelected: available
                                              ? (selected) {
                                            if (selected &&
                                                available) {
                                              controller.onAttributesSelected(product,attribute.name ??'', attributeValue);
                                              // Update imagecontroller.selectProductImage
                                              imageController.selectedProductImage.value = controller.selectedVariation.value.image;

                                            }
                                          }
                                              : null);
                                    }).toList(),
                                  ))
                                ],
                              ))
                                  .toList() ??
                                  [])
                        ],
                      ),

                    //Checkout Buttoom
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Add to Cart"),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Checkout"),
                      ),
                    ),
                    Text(
                      "Description",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      product.description!,
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show More',
                      trimExpandedText: 'Less',
                      moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              ),
              RatingsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
