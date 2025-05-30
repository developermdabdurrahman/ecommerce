
import 'package:ecommerce/app/app_color.dart';
import 'package:ecommerce/app/asset_path.dart';
import 'package:ecommerce/core/widgets/show_snack_Bar.dart';
import 'package:ecommerce/feature/card/model/card_model.dart';
import 'package:ecommerce/feature/card/ui/controller/product_card_controller.dart';
import 'package:ecommerce/feature/product/widgets/increment_decrement_count_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.cardModel,
    required this.quantity,
  });

  final CardModel cardModel;
  final Function(int count) quantity;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  final RxBool _deleteInProgress = false.obs;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 100,
        width: 90,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            '${widget.cardModel.photo}',
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(AssetsPath.noImage),
                ),
              );
            },
          ),
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cardModel.title ?? 'Unknown product',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text('Color: ${widget.cardModel.color}', style: TextStyle(fontSize: 10)),
                    SizedBox(width: 8),
                    Text('Size: ${widget.cardModel.size}', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
          Obx(
            () =>  Visibility(
              visible: _deleteInProgress.value == false,
              replacement: const CircularProgressIndicator(),
              child: IconButton(
                onPressed: () async {
                  _deleteInProgress.value = true;
                  final bool isSuccess = await Get.find<ProductCardController>()
                      .removeFromCart(widget.cardModel);
                  _deleteInProgress.value = false;
                  if (isSuccess == false) {
                    showSnackBarMessage(
                      context,
                      Get.find<ProductCardController>().removeFromCartErrorMessage!,
                      true,
                    );
                  }
                },
                icon: const Icon(Icons.delete_outline,color: Colors.grey,),
              ),
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '৳${widget.cardModel.currentPrice}',
            style: TextStyle(
              color: AppColors.themeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          IncrementDecrementCountWidget(
            count: widget.cardModel.quantity??0,
            quantity: (count) {
              widget.quantity(count);
            },
          ),
        ],
      ),
    );
  }
}
