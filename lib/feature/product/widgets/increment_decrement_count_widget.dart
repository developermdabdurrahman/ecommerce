import 'package:crafty_bay/app/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class IncrementDecrementCountWidget extends StatefulWidget {
   IncrementDecrementCountWidget({super.key, required this.quantity, required this.count});
  final Function(int) quantity;
  int count;


  @override
  State<IncrementDecrementCountWidget> createState() =>
      _IncrementDecrementCountWidgetState();
}

class _IncrementDecrementCountWidgetState
    extends State<IncrementDecrementCountWidget> {

  RxInt count = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count.value = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            count.value++;
            widget.quantity(count.value);
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.themeColor,
            ),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
        SizedBox(width: 8),
        Obx(
          () =>  Text(
            '${count.value}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            switch (count.value) {
              case > 1:
                count.value--;
              widget.quantity(count.value);
            }
          },
          child: Obx(
            () =>  Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color:
                count.value < 2
                        ? AppColors.themeColor.withOpacity(0.6)
                        : AppColors.themeColor,
              ),
              child: Icon(Icons.remove, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
