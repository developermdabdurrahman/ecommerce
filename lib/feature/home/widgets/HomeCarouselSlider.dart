import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_color.dart';
import '../../common/controller/home_slider_controller.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  List carouselitem = [1, 2, 3, 4, 5];
  final RxInt _currentItem = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSliderController>(
      builder: (controller) {
        return controller.getSlidersInProgress == false
            ? Visibility(
              visible: controller.sliders.isNotEmpty,
              replacement: SizedBox(height: 180),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 180,
                      viewportFraction: 1,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        _currentItem.value = index;
                      },
                    ),
                    items:
                        controller.sliders.map((slider) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(slider.photoUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.teal,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 6),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < controller.sliders.length; i++)
                        Container(
                          height: 8,
                          width: i == _currentItem.value ? 18 : 8,
                          margin: EdgeInsets.symmetric(horizontal: 1.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: i == _currentItem.value
                                ? AppColors.themeColor
                                : Colors.grey.shade300,
                          ),
                        ),
                    ],
                  )),
                ],
              ),
            )
            : SizedBox(
              height: 190,
              width: double.maxFinite,
              child: Center(
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
      },
    );
  }
}
