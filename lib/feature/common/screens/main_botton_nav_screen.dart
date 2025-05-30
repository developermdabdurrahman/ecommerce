import 'package:crafty_bay/feature/auth/ui/controller/auth_controller.dart';
import 'package:crafty_bay/feature/auth/ui/screens/sign_in_screen.dart';
import 'package:crafty_bay/feature/card/ui/screens/card_screen.dart';
import 'package:crafty_bay/feature/caregory/screens/category_list_screen.dart';
import 'package:crafty_bay/feature/common/controller/category_controller.dart';
import 'package:crafty_bay/feature/common/controller/home_slider_controller.dart';
import 'package:crafty_bay/feature/common/controller/main_bottom_nav_index_controller.dart';
import 'package:crafty_bay/core/extensions/app_localization_extension.dart';
import 'package:crafty_bay/feature/common/controller/new_product_list_controller.dart';
import 'package:crafty_bay/feature/common/controller/popular_product_list_controller.dart';
import 'package:crafty_bay/feature/common/controller/special_product_list_controller.dart';
import 'package:crafty_bay/feature/home/screens/home_screen.dart';
import 'package:crafty_bay/feature/wishlist/ui/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static String name = '/MainBottomNav';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  AuthController authController = Get.find<AuthController>();

  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    CardScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<HomeSliderController>().getSliders();
    Get.find<CategoryController>().getCategory();
    Get.find<PopularProductListController>().getProduct();
    Get.find<NewProductListController>().getProduct();
    Get.find<SpecialProductListController>().getProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainBottomNavIndexController>(
        builder: (controller) {
          return _screens[controller.currentIndex];
        }
      ),
      bottomNavigationBar: GetBuilder<MainBottomNavIndexController>(
        builder: (controller) {
          return BottomNavigationBar(
            currentIndex: controller.currentIndex,
              onTap: (index) {
                if (controller.shouldNavigate(index)) {
                  controller.changeIndex(index);
                } else {
                  Get.to(() => const SignInScreen());
                }
              },
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),activeIcon: Icon(Icons.home),label: context.localization.home),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize_outlined),activeIcon: Icon(Icons.dashboard_customize_rounded),label: context.localization.category),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),activeIcon: Icon(Icons.shopping_cart),label: context.localization.card),
            BottomNavigationBarItem(icon: Icon(Icons.wallet_giftcard),label: context.localization.wish),
          ]);
        }
      ),
    );
  }
}
