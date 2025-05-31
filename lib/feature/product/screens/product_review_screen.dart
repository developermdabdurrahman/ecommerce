import 'package:ecommerce/app/app_color.dart';
      import 'package:ecommerce/feature/product/controller/review_list_controller.dart';
      import 'package:ecommerce/feature/product/screens/product_add_review_screen.dart';
      import 'package:ecommerce/feature/product/widgets/review_item.dart';
      import 'package:flutter/material.dart';
      import 'package:get/get.dart';

      class ProductReviewScreen extends StatefulWidget {
        const ProductReviewScreen({super.key, required this.productId});
        final String productId;
        static String name = '/ProductReview';

        @override
        State<ProductReviewScreen> createState() => _ProductReviewScreenState();
      }

      class _ProductReviewScreenState extends State<ProductReviewScreen> {
        final ReviewListController _reviewListController = ReviewListController();
        final ScrollController _scrollController = ScrollController();


        @override
        void initState() {
          // TODO: implement initState
          super.initState();
          _reviewListController.getProductReview(widget.productId);
          _scrollController.addListener(pagination);
        }

        void pagination() {
          if (_scrollController.position.extentAfter < 300) {
            _reviewListController.getProductReview(widget.productId);
          }
        }


        @override
        void dispose() {
          _scrollController.dispose();
          super.dispose();
        }

        Future<void> _onRefresh() async {
          _reviewListController.refrash(widget.productId);
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              title: Text('Reviews', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            body: GetBuilder(
              init: _reviewListController,
              builder: (controller) {
                return Visibility(
                  visible: controller.inProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: SafeArea(
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomScrollView(
                              controller: _scrollController,
                              slivers: [
                                SliverPadding(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        if (index < controller.reviewList.length) {
                                          return Column(
                                            children: [
                                              ReviewItem(review: controller.reviewList[index]),
                                              if (index != controller.reviewList.length - 1)
                                                Divider(
                                                  color: Colors.grey.shade200,
                                                  thickness: 1.0,
                                                  height: 24,
                                                ),
                                            ],
                                          );
                                        } else if (controller.paginationInProgress) {
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Center(child: CircularProgressIndicator()),
                                          );
                                        }
                                        return null;
                                      },
                                      childCount: controller.reviewList.length +
                                          (controller.paginationInProgress ? 1 : 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildReviewCountAndAddButton(controller.totalReviewCount ?? 0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }

        Container _buildReviewCountAndAddButton(int count) {
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
                        'Reviews  ($count)',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ProductAddReviewScreen.name,arguments: widget.productId);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.themeColor,
                    fixedSize: Size(80, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 26),
                ),
              ],
            ),
          );
        }
      }