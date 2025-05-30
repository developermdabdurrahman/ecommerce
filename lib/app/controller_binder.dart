import 'package:crafty_bay/feature/auth/ui/controller/auth_controller.dart';
import 'package:crafty_bay/feature/auth/ui/controller/otp_veriffication_controller.dart';
import 'package:crafty_bay/feature/auth/ui/controller/sign_in_controller.dart';
import 'package:crafty_bay/feature/auth/ui/controller/sign_up_controller.dart';
import 'package:crafty_bay/feature/card/ui/controller/product_card_controller.dart';
import 'package:crafty_bay/feature/common/controller/category_controller.dart';
import 'package:crafty_bay/feature/common/controller/home_slider_controller.dart';
import 'package:crafty_bay/feature/common/controller/main_bottom_nav_index_controller.dart';
import 'package:crafty_bay/core/network_caller/network_caller.dart';
import 'package:crafty_bay/feature/common/controller/new_product_list_controller.dart';
import 'package:crafty_bay/feature/common/controller/popular_product_list_controller.dart';
import 'package:crafty_bay/feature/common/controller/special_product_list_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomNavIndexController());
    Get.put(NetworkCaller());
    Get.put(AuthController());
    Get.put(SignInController());
    Get.lazyPut(() =>  SignUpController());
    Get.lazyPut(() =>  OtpVerifyicationController());
    Get.put(HomeSliderController());
    Get.put(CategoryController());
    Get.put(PopularProductListController());
    Get.put(SpecialProductListController());
    Get.put(NewProductListController());
    Get.put(ProductCardController());
  }
}