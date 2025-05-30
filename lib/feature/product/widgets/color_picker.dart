import 'package:crafty_bay/app/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colors, required this.onChange});
  final List<String> colors;
  final Function(String) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final RxString _colorIndex=''.obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.colors.length,
        itemBuilder: (context, index) {
          String color = widget.colors[index];
          return GestureDetector(
            onTap: () {
              _colorIndex.value = color;
              widget.onChange(color);
            },
            child: Obx(
              () =>  Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: _colorIndex.value == color ? AppColors.themeColor : AppColors.themeColor.withOpacity(0.4),
                ),
                child: Center(
                  child: Text(
                    color,
                    style: TextStyle(
                      fontSize: 9,
                      color: _colorIndex.value == color ? Colors.white : Colors.black,
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
