
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/product_card.dart';
import '../controller/product_list_controller.dart';
import '../data/product_get_request_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});

  static String name = "/ProductList";
  final Map<String,dynamic> category;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductListController _productController = ProductListController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productController.getProduct(ProductGetRequestModel(category: widget.category['id']??''));
    _scrollController.addListener(pagination);
  }
  void pagination(){
    if(_scrollController.position.extentAfter < 300){
      _productController.getProduct(ProductGetRequestModel(category: widget.category['id']??''));
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
        title: Text(widget.category['title'], style: TextStyle(fontSize: 24)),
        forceMaterialTransparency: true,
      ),
      body: GetBuilder(
        init: _productController,
          builder: (controller) {
            return controller.inProgress
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
              onRefresh: () async {
                _productController.refrash(ProductGetRequestModel(category: widget.category['id']??''));
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
          }
      ),
    );
  }
}