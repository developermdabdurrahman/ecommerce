import 'package:crafty_bay/app/app_urls.dart';
import 'package:crafty_bay/core/network_caller/network_caller.dart';
import 'package:get/get.dart';

class AddToCardController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> apiCall(String productId) async {
    bool isSuccess = false;
    _inProgress = true;

    update();
    NetworkResponse response = await NetworkCaller().postRequest(
      url: AppUrls.card,
      body: {"product": productId},
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
