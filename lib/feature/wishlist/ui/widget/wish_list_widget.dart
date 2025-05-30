
import 'package:flutter/material.dart';

import '../../../../app/app_color.dart';
import '../../../../app/asset_path.dart';
import '../../../product/screens/product_details_screen.dart';
import '../../model/wish_list_model.dart';

class WishListWidget extends StatelessWidget {
  final WishListProductModel? products;
  const WishListWidget({super.key,required this.products});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.name,arguments: products?.id);
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  SizedBox(
                    height: 124,
                    width: double.maxFinite,
                    child: Image.network(
                      products!.photos!.isNotEmpty ? products!.photos!.first:'',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: SizedBox(
                              width: 60,
                              height: 60,
                              child: Image.asset(AssetsPath.noImage)),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.themeColor,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 14),
                Icon(Icons.star, color: Colors.amber, size: 14),
                Icon(Icons.star, color: Colors.amber, size: 14),
                Icon(Icons.star, color: Colors.amber, size: 14),
                Icon(Icons.star, color: Colors.grey.shade300, size: 16),
              ],
            ),
            Text(
              products!.title??'',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87, height: 1.3),
            ),
            SizedBox(height: 2),
            Text(
              '৳${products!.currentPrice} ',
              style: TextStyle(
                color: AppColors.themeColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
