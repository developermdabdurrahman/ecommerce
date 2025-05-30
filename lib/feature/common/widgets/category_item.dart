
import 'package:flutter/material.dart';

import '../../../app/app_color.dart';
import '../../../app/asset_path.dart';
import '../../product/screens/product_list_screen.dart';
import '../model/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryItem({
    super.key,
    required this.categoryModel
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductListScreen.name,arguments: {
          'id':categoryModel.id,
          'title':categoryModel.title
        });
      },
      child: SizedBox(
        width: 90,
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: AppColors.themeColor.withOpacity(0.1),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  categoryModel.icon,
                  width: 48,
                  height: 48,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(AssetsPath.noImage,width: 32,);
                  },
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(
              categoryModel.title, // example long text
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center, // centers under the icon
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
