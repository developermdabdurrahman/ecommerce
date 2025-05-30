
import 'package:flutter/material.dart';

import '../data/review_model.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 20,
              child: Icon(Icons.person),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < review.rating; i++)
                        Icon(Icons.star, color: Colors.amber, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(review.comment, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
      ],
    );
  }
}
