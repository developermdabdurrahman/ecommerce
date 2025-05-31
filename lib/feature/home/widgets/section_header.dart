import 'package:ecommerce/app/app_color.dart';
import 'package:ecommerce/core/extensions/app_localization_extension.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback oneTabSeeAll;
  const SectionHeader({
    super.key, required this.title, required this.oneTabSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: oneTabSeeAll,
            child: Text(context.localization.see_all,style: TextStyle(color: AppColors.themeColor),),
          )
        ],
      ),
    );
  }
}
