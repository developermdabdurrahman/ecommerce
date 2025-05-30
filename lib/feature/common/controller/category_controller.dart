import 'package:crafty_bay/app/app_urls.dart';
import 'package:crafty_bay/feature/common/model/category_model.dart';
import 'package:crafty_bay/core/network_caller/network_caller.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

  final int _perPageDataCount = 30;
  bool _inProgress = false;
  bool _paginationInProgress = false;
  int _currentPage = 0;
  int _totalPage = 0;
  String? _errorMassage;
  List<CategoryModel> _categoryList =[];

  bool get inProgress => _inProgress;
  bool get paginationInProgress => _paginationInProgress;
  String? get errorMassage => _errorMassage;
  int get currentPage => _currentPage;
  List<CategoryModel> get categoryList => _categoryList;

  Future<bool> getCategory() async {
    if (_paginationInProgress) {
      return false;
    }

    bool isSuccess = false;

    _currentPage++;
    if(_totalPage != 0 && _currentPage > _totalPage){
      return false;
    }

    if(_currentPage ==1){
      _inProgress = true;
    }else{
      _paginationInProgress = true;
    }
    update();

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: AppUrls.CategoryUrl,queryParams: {
      'count': _perPageDataCount,
      'page': _currentPage,
    },);
    if(response.isSuccess){
      _categoryList.addAll(
          (response.responseData!['data']['results'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
      );
      _totalPage = response.responseData!['data']['last_page']??_totalPage;
      print(_totalPage);
      isSuccess = true;
      _errorMassage ='';
    }else{
      isSuccess = false;
      _errorMassage = response.errorMessage;
    }

    _inProgress = false;
    _paginationInProgress = false;
    update();
    return isSuccess;
  }

  void refrash(){
    _categoryList = [];
    _currentPage = 0;
    getCategory();
  }

}