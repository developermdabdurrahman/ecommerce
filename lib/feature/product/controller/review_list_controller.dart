
import 'package:get/get.dart';

import '../../../app/app_urls.dart';
import '../../../core/network_caller/network_caller.dart';
import '../data/review_model.dart';

class ReviewListController extends GetxController {
  final int _perPageDataCount = 30;
  bool _inProgress = false;
  bool _paginationInProgress = false;
  int _currentPage = 0;
  int? _totalPage;
  String? _errorMassage;
  int? _totalReviewCount;
  List<ReviewModel> _reviewList = [];

  bool get inProgress => _inProgress;

  bool get paginationInProgress => _paginationInProgress;

  String? get errorMassage => _errorMassage;

  int get currentPage => _currentPage;

  List<ReviewModel> get reviewList => _reviewList;
  int? get totalReviewCount => _totalReviewCount;



  Future<bool> getProductReview(String id) async {
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
      url: AppUrls.reviewList,queryParams: {
        'count': _perPageDataCount,
        'page': _currentPage,
        'product': id,
      },
    );
    if (response.isSuccess) {
      _reviewList.addAll(
        (response.responseData!['data']['results'] as List)
            .map((e) => ReviewModel.fromJson(e))
            .toList(),
      );
      _totalPage = response.responseData!['data']['last_page'] ?? _totalPage;
      _totalReviewCount = response.responseData!['data']['total'] ?? _totalReviewCount;
      isSuccess = true;
      _errorMassage = '';
      print(_reviewList.length);
      print(_totalReviewCount);
    } else {
      isSuccess = false;
      _errorMassage = response.errorMessage;
    }

    _inProgress = false;
    _paginationInProgress = false;
    update();
    return isSuccess;
  }

  refrash(String id) {
    _currentPage = 0;
    _reviewList =[];
    getProductReview(id);
    update();
  }

}
