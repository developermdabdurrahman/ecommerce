import 'package:crafty_bay/feature/auth/ui/controller/auth_controller.dart';
import 'package:get/get.dart';

class MainBottomNavIndexController extends GetxController {
  int _index = 0;
  int get currentIndex => _index;

  void changeIndex(int index){
    _index = index;
    update();
  }

  bool shouldNavigate(int index) {
    if (index == 2 || index == 3) {
      return Get.find<AuthController>().isValid();
    }
    return true;
  }

  void moveToCategory(){
    changeIndex(1);
  }

  void backHome(){
    changeIndex(0);
  }
}