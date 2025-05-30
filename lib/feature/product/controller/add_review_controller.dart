import 'package:crafty_bay/app/app_urls.dart';
import 'package:crafty_bay/core/network_caller/network_caller.dart';
import 'package:get/get.dart';

class AddReviewController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> apiCall(Map<String,dynamic> addReviewData) async {
    bool isSuccess = false;
    _inProgress = true;

    update();
    NetworkResponse response = await NetworkCaller().postRequest(
      url: AppUrls.review,
      body: addReviewData,
    );

    if(response.isSuccess){
      isSuccess = true;
    }else{
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
