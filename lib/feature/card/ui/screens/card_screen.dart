
import 'package:ecommerce/app/app_color.dart';
import 'package:ecommerce/core/extensions/app_localization_extension.dart';
import 'package:ecommerce/feature/auth/ui/controller/auth_controller.dart';
import 'package:ecommerce/feature/card/ui/controller/product_card_controller.dart';
import 'package:ecommerce/feature/card/ui/controller/ssl_getway.dart';
import 'package:ecommerce/feature/card/ui/widget/card_widget.dart';
import 'package:ecommerce/feature/common/controller/main_bottom_nav_index_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final ProductCardController _cardController = Get.find<ProductCardController>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cardController.getCards();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Get.find<MainBottomNavIndexController>().backHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavIndexController>().backHome();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(context.localization.card, style: TextStyle(fontSize: 24)),
          forceMaterialTransparency: true,
        ),
        body: GetBuilder(
          init: _cardController,
          builder: (controller) {
            return controller.inProgress == true
                ? Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: controller.cardList.length,
                        padding: EdgeInsets.only(bottom: 40),
                        itemBuilder: (context, index) {
                          return CardWidget(
                            cardModel: controller.cardList[index],
                            quantity: (count) {
                              controller.updateProduct(
                                controller.cardList[index],
                                count,
                              );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(color: Colors.grey.shade100);
                        },
                      ),
                    ),
                    _buildPriceAndChackOut(controller.totalPrice),
                  ],
                );
          },
        ),
      ),
    );
  }

  Widget _buildPriceAndChackOut(double totalPrice) {
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
                  context.localization.totalPrice,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$totalPrice',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              sslProcess(
                context: context,
                storeId: 'ntech681f8c458e695',
                storePassword: 'ntech681f8c458e695@ssl',
                amount: totalPrice,
                customerName: _authController.user!.firstName,
                customerEmail: _authController.user!.email,
                customerPhone: _authController.user!.phone,
                customerAddress: _authController.user!.city,
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.themeColor,
              fixedSize: Size(120, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(context.localization.checkOut),
          ),
        ],
      ),
    );
  }
}
