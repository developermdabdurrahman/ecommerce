
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_color.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onChange});
  final List<String> sizes;
  final Function(String) onChange;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {


  final RxString _size=''.obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.sizes.length,
        itemBuilder: (context, index) {
          String size = widget.sizes[index];
          return GestureDetector(
            onTap: () {
              widget.onChange(size);
              _size.value = size;
            },
            child: Obx(
              () =>
               Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: _size.value ==size ? AppColors.themeColor :Colors.white,
                    border: Border.all(
                        color: _size.value != size ?Colors.grey : Colors.transparent
                    )
                ),
                child: Center(
                  child: Text(
                    size,
                    style: TextStyle(
                      fontSize: 11,
                      color: _size.value == size ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


