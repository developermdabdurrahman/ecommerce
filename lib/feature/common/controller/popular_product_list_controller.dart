
import 'package:get/get.dart';

import '../../../app/app_urls.dart';
import '../../../core/network_caller/network_caller.dart';
import '../../product/data/product_model.dart';

class PopularProductListController extends GetxController {
  final int _perPageDataCount = 30;
  bool _inProgress = false;
  bool _paginationInProgress = false;
  int _currentPage = 0;
  int? _totalPage;
  String? _errorMassage;
  List<ProductModel> _productList = [];

  bool get inProgress => _inProgress;

  bool get paginationInProgress => _paginationInProgress;

  String? get errorMassage => _errorMassage;

  int get currentPage => _currentPage;

  List<ProductModel> get producvtList => _productList;

  Future<bool> getProduct() async {
    if (_paginationInProgress) {
      return false;
    }

    bool isSuccess = false;

    _currentPage++;
    if (_totalPage != null && _currentPage > _totalPage!) {
      return false;
    }

    if (_currentPage == 1) {
      _inProgress = true;
    } else {
      _paginationInProgress = true;
    }
    update();

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: AppUrls.productListUrl,
      queryParams: {
        'count': _perPageDataCount,
        'page': _currentPage,
        'category': '67c35af85e8a445235de197b',
      },
    );
    if (response.isSuccess) {
      _productList.addAll(
        (response.responseData!['data']['results'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList(),
      );
      _totalPage = response.responseData!['data']['last_page'] ?? _totalPage;
      print(_totalPage);
      isSuccess = true;
      _errorMassage = '';
    } else {
      isSuccess = false;
      _errorMassage = response.errorMessage;
    }

    _inProgress = false;
    _paginationInProgress = false;
    update();
    return isSuccess;
  }

  void refrash() {
    _productList = [];
    _currentPage = 0;
    getProduct();
  }
}
