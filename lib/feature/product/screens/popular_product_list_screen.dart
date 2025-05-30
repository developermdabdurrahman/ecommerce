
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/controller/popular_product_list_controller.dart';
import '../../common/widgets/product_card.dart';

class PopularProductListScreen extends StatefulWidget {
  const PopularProductListScreen({super.key});

  static String name = "/PopularProductList";

  @override
  State<PopularProductListScreen> createState() =>
      _PopularProductListScreenState();
}

class _PopularProductListScreenState extends State<PopularProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(pagination);
  }

  void pagination() {
    if (_scrollController.position.extentAfter < 300) {
      Get.find<PopularProductListController>().getProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text('Popular', style: TextStyle(fontSize: 24)),
        forceMaterialTransparency: true,
      ),
      body: GetBuilder<PopularProductListController>(
        builder: (controller) {
          return controller.inProgress
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: () async {
                  Get.find<PopularProductListController>().refrash();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 200,
                          mainAxisSpacing: 20,
                        ),
                        delegate: SliverChildBuilderDelegate(
                                childCount: controller.producvtList.length,
                                (context, index) {
                          return FittedBox(
                            child: ProductCart(
                              products: controller.producvtList[index],
                            ),
                          );
                        }),
                      ),
                      if(controller.paginationInProgress)
                      SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                  ),
                ),
              );
        },
      ),
    );
  }
}
