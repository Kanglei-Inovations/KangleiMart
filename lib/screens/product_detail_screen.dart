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
        product.price, product.salesPrice);

    return Scaffold(
      appBar: AppBar(
        title: const MyAppText(text: AppStrings.productScreenTitle),
      ),
      body: WillPopScope(
        onWillPop: () async {
          /// Reset the state of the page......................................................
          controller.resetSelectedAttributes();
          return true; // Allow the page to be popped
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
                    ///Price.....................................................................
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
                              child: MyAppText(
                                text: '$salePercentage% OFF',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 10),
                            if (product.productType ==
                                    ProductType.single.toString() &&
                                product.salesPrice > 0)
                              MyAppText(
                                text: '${AppStrings.rupee}${product.price}',

                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                textDecoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            Obx(
                              () {
                                if (controller
                                    .selectedVariation.value.id.isNotEmpty) {
                                  // Show the variation price if a variation is selected
                                  return Row(
                                    children: [
                                      if (controller
                                              .selectedVariation.value.price >
                                          0)
                                        MyAppText(
                                          text: AppStrings.rupee +
                                              controller.getVariationPrice(),
                                          fontSize: 14,
                                          textDecoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      SizedBox(width: 10.sp,),
                                      MyAppText(
                                        text: AppStrings.rupee +
                                            controller.getVariationSalesPrice(),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  );
                                } else {
                                  product.productType ==
                                          ProductType.single.toString() &&
                                      product.salesPrice > 0;
                                }
                                {
                                  // Show the product's single price before any variation is selected
                                  return Column(
                                    children: [
                                      MyAppText(
                                        text:
                                            productController
                                                .getProductPrice(product),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    //Product Title............
                    MyAppText(
                      text: product.title,
                      fontSize: 18,
                    ),
                    SizedBox(height: 8),
                    //Stock.......................
                    Row(
                      children: [
                        const MyAppText(
                          text: AppStrings.productInStock,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MyAppText(
                          text: productController
                              .getProductStockStatus(product.stock),
                          fontSize: 16,
                          color: productController.Status(product.stock),
                        ),
                      ],
                    ),

                    ///Brand ..............................................

                    if (product.brandId!.isNotEmpty) SizedBox(height: 8),
                    if (product.brandId!.isNotEmpty)
                      FutureBuilder<String>(
                        future: productProvider
                            .getBrandImage(product.brandId ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const MyAppText(
                              text: AppStrings.productBrandLoading,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            );
                          } else if (snapshot.hasError) {
                            return const MyAppText(
                              text: AppStrings.productErrorLoadingBrand,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            );
                          } else {
                            // Use CachedNetworkImage to load the brand image
                            return Row(
                              children: [
                                const MyAppText(
                                    text: AppStrings.productBrandText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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

                    ///Category ........................

                    if (product.categoryId!.isNotEmpty) SizedBox(height: 8),
                    if (product.categoryId!.isNotEmpty)
                      FutureBuilder<String>(
                        future: productProvider
                            .getCategoryName(product.categoryId ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const MyAppText(
                                text: AppStrings.productCategoryLoading, fontSize: 18);
                          } else if (snapshot.hasError) {
                            return const MyAppText(
                                text: AppStrings.productErrorLoadingCategory,
                                fontSize: 18);
                          } else {
                            return Row(
                              children: [
                                const MyAppText(
                                    text: AppStrings.productCategoryText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  width: 10,
                                ),
                                MyAppText(
                                  text: '${snapshot.data}',
                                  fontSize: 16,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    SizedBox(height: 16),

                    ///Variant................................................

                    if (product.productType == ProductType.variable.toString())
                      Obx(
                        () => controller.selectedVariation.value.id.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black12,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const MyAppText(
                                            text: AppStrings.productVariant,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  MyAppText(
                                                    text: AppStrings.productPrice,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  SizedBox(width: 5.sp,),

                                                  if (controller
                                                          .selectedVariation
                                                          .value
                                                          .price >
                                                      0)
                                                    MyAppText(
                                                      text:
                                                          '${AppStrings.rupee}${controller.getVariationPrice()}  ',
                                                      fontSize: 14,
                                                      textDecoration:
                                                          TextDecoration
                                                              .lineThrough,
                                                      color: Colors.red,
                                                    ),
                                                  MyAppText(
                                                    text:
                                                        '${AppStrings.rupee} ${controller.getVariationSalesPrice()}',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const MyAppText(
                                                    text: AppStrings.productInStock,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  MyAppText(
                                                    text: controller
                                                        .variationStockStatus
                                                        .value,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const MyAppText(
                                          text:
                                              "This Product variable description. Change function get from firebase this is demo")
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    if (product.productType == ProductType.variable.toString())
                      Column(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: product.productAttributes
                                      ?.map(
                                        (attribute) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyAppText(
                                              text: '${attribute.name}',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Obx(() => Wrap(
                                                  spacing: 8,
                                                  children: attribute.values!
                                                      .map((attributeValue) {
                                                    final isSelected = controller
                                                                .selectedAttributes[
                                                            attribute.name] ==
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
                                                                  controller.onAttributesSelected(
                                                                      product,
                                                                      attribute
                                                                              .name ??
                                                                          '',
                                                                      attributeValue);
                                                                }
                                                              }
                                                            : null);
                                                  }).toList(),
                                                ))
                                          ],
                                        ),
                                      )
                                      .toList() ??
                                  [])
                        ],
                      ),

                    ///Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const MyAppText(text: "Add to Cart"),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const MyAppText(text: "Checkout"),
                      ),
                    ),
                    const MyAppText(
                      text: "Description",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
                      moreStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
