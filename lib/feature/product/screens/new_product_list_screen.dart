import 'package:crafty_bay/feature/common/controller/new_product_list_controller.dart';
import 'package:crafty_bay/feature/common/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewProductListScreen extends StatefulWidget {
  const NewProductListScreen({super.key});

  static String name = "/NewProductList";

  @override
  State<NewProductListScreen> createState() => _NewProductListScreenState();
}

class _NewProductListScreenState extends State<NewProductListScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(pagination);
  }
  void pagination(){
    if(_scrollController.position.extentAfter < 300){
      Get.find<NewProductListController>().getProduct();
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
        title: Text('New', style: TextStyle(fontSize: 24)),
        forceMaterialTransparency: true,
      ),
      body: GetBuilder<NewProductListController>(
          builder: (controller) {
            return controller.inProgress
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
              onRefresh: () async {
                Get.find<NewProductListController>().refrash();
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
