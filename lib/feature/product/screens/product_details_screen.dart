import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/core/extensions/app_localization_extension.dart';
import 'package:crafty_bay/core/widgets/show_snack_Bar.dart';
import 'package:crafty_bay/feature/auth/ui/controller/auth_controller.dart';
import 'package:crafty_bay/feature/auth/ui/screens/sign_in_screen.dart';
import 'package:crafty_bay/feature/common/controller/add_to_wish_controller.dart';
import 'package:crafty_bay/feature/product/controller/add_to_card_controller.dart';
import 'package:crafty_bay/feature/product/controller/product_details_controller.dart';
import 'package:crafty_bay/feature/product/data/product_model.dart';
import 'package:crafty_bay/feature/product/screens/product_review_screen.dart';
import 'package:crafty_bay/feature/product/widgets/color_picker.dart';
import 'package:crafty_bay/feature/product/widgets/increment_decrement_count_widget.dart';
import 'package:crafty_bay/feature/product/widgets/product_view_carousel_slider.dart';
import 'package:crafty_bay/feature/product/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String id;

  const ProductDetailsScreen({super.key, required this.id});

  static String name = '/productDetails';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _detailsController =
      ProductDetailsController();

  final AddToCardController _addToCardController = AddToCardController();

  String? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailsController.getProductDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: GetBuilder(
          init: _detailsController,
          builder: (controller) {
            return controller.inProgress == true
                ? Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 240,
                                  color: Colors.grey.shade100,
                                  child: ProductViewCarouselSlider(
                                    productModel: controller.productDetails,
                                  ),
                                ),
                                _buildCustomAppBar(),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTitleAndIncrementDecrement(controller),
                                  _buildReviewSection(context),
                                  if (controller
                                      .productDetails!
                                      .colors
                                      .isNotEmpty)
                                    _buildColorSection(
                                      controller.productDetails!.colors,
                                    ),
                                  if (controller
                                      .productDetails!
                                      .sizes
                                      .isNotEmpty)
                                    _buildSizeSection(
                                      controller.productDetails!.sizes,
                                    ),
                                  _buildDescriptionSection(controller),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildPriceAndAddToCard(controller.productDetails),
                  ],
                );
          },
        ),
      ),
    );
  }

  Column _buildDescriptionSection(ProductDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(context.localization.description, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Text(
          controller.productDetails?.description ?? '',
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
        ),
      ],
    );
  }

  Row _buildReviewSection(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star_rounded, color: Colors.amberAccent),
        Text('4.5'),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductReviewScreen.name, arguments: widget.id);
          },
          child: Text(
            context.localization.review,
            style: TextStyle(
              color: AppColors.themeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Row _buildTitleAndIncrementDecrement(ProductDetailsController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            controller.productDetails?.title ?? "",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(width: 16),
        IncrementDecrementCountWidget(
          quantity: (count) {

          }, count: controller.productDetails!.availableQuantity,
        ),
      ],
    );
  }

  Column _buildSizeSection(List<String>? sizes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(context.localization.size, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        SizePicker(
          sizes: sizes ?? [],
          onChange: (size) {
            _selectedSize = size;
          },
        ),
      ],
    );
  }

  Column _buildColorSection(List<String>? colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Text(context.localization.color, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        ColorPicker(
          colors: colors ?? [],
          onChange: (color) {
            _selectedColor = color;
          },
        ),
      ],
    );
  }

  Positioned _buildCustomAppBar() {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black54),
            ),
          ),
          GetBuilder(
            init: AddToWishController(),
            builder: (controller) {
              return CircleAvatar(
                backgroundColor: Colors.white,
                child:
                    controller.inProgress == true
                        ? CircularProgressIndicator()
                        : IconButton(
                          onPressed: () async {

                            bool isValid = Get.find<AuthController>().isValid();
                            if (isValid == false) {
                              Get.to(SignInScreen());
                              return;
                            }

                            bool isSuccess = await controller.apiCall(
                              widget.id,
                            );
                            if (isSuccess) {
                              showSnackBarMessage(
                                context,
                                'Add to wish Successfully',
                              );
                            } else {
                              showSnackBarMessage(
                                context,
                                controller.errorMessage,
                                true,
                              );
                            }
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: AppColors.themeColor,
                          ),
                        ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndAddToCard(ProductModel? product) {
    return GetBuilder(
      init: _addToCardController,
      builder: (controller) {
        return Container(
          height: 70,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.localization.price,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '৳${product!.currentPrice}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.inProgress == false,
                replacement: CircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: () async {
                    if (product.colors.isNotEmpty && _selectedColor == null) {
                      showSnackBarMessage(context, 'Select color', true);
                      return;
                    }

                    if (product.sizes.isNotEmpty && _selectedSize == null) {
                      showSnackBarMessage(context, 'Select size', true);
                      return;
                    }

                    bool isValid = Get.find<AuthController>().isValid();
                    if (isValid == false) {
                      Get.to(SignInScreen());
                      return;
                    }
                    bool isSuccess = await controller.apiCall(product.id);
                    if (isSuccess) {
                      showSnackBarMessage(context, 'add successfully');
                    } else {
                      showSnackBarMessage(
                        context,
                        controller.errorMessage,
                        true,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.themeColor,
                    fixedSize: Size(130, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(context.localization.addToCard),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
