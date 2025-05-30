
import 'package:get/get.dart';

import '../../../app/app_urls.dart';
import '../../../core/network_caller/network_caller.dart';
import '../data/product_model.dart';
class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  ProductModel? _productDetails;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  ProductModel? get productDetails => _productDetails;

  Future<bool> getProductDetails(String id)async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: AppUrls.productDetailsUrl(id));
    if(response.isSuccess){
      _errorMessage = '';
      isSuccess = true;
      _productDetails = ProductModel.fromJson(response.responseData!['data']);
    }else{
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}