import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/feature/product/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductViewCarouselSlider extends StatefulWidget {
  final ProductModel? productModel;

  const ProductViewCarouselSlider({super.key, required this.productModel});

  @override
  State<ProductViewCarouselSlider> createState() =>
      _ProductViewCarouselSliderState();
}

class _ProductViewCarouselSliderState extends State<ProductViewCarouselSlider> {
  final RxInt _currentItem = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 240,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              _currentItem.value = index;
            },
          ),
          items:
              widget.productModel?.photos.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ColoredBox(
                            color: Colors.grey.withOpacity(0.8),
                            child: SizedBox(
                              width: double.maxFinite,
                              height: double.maxFinite,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(image)),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
        ),
        Obx(
          () =>  Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.productModel!.photos.length; i++)
                    Container(
                      height: 8,
                      width: i == _currentItem.value ? 10 : 10,
                      margin: EdgeInsets.symmetric(horizontal: 1.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            i == _currentItem.value
                                ? AppColors.themeColor
                                : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
