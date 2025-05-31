import 'package:ecommerce/app/app_urls.dart';
import 'package:ecommerce/feature/card/model/card_model.dart';
import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:get/get.dart';

class ProductCardController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _removeFromCartListInProgress = false;

  bool get removeFromCartListInProgress => _removeFromCartListInProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  String? _removeFromCartErrorMessage;

  String? get removeFromCartErrorMessage => _removeFromCartErrorMessage;

  List<CardModel> _cardList = [];

  List<CardModel> get cardList => _cardList;

  Future<bool> getCards() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    _cardList.clear();

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: AppUrls.card,
    );
    if (response.isSuccess) {
      _cardList.addAll(
        (response.responseData!['data']['results'] as List)
            .map((e) => CardModel.fromJson(e))
            .toList(),
      );
      isSuccess = true;
      _errorMassage = '';
    } else {
      isSuccess = false;
      _errorMassage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  double get totalPrice {
    double total = 0;
    for (CardModel cartItem in _cardList) {
      total += (cartItem.currentPrice! * cartItem.quantity!);
    }
    return total;
  }

  Future<void> updateProduct(CardModel cardModel, int quantity) async {
    for (CardModel cartItem in _cardList) {
      if (cartItem.id == cardModel.id) {
        cartItem.quantity = quantity;
        break;
      }
    }
    update();
    await NetworkCaller().patchRequest(
      url: AppUrls.cardById(cardModel.cid ?? ''),
      body: {'quantity': quantity},
    );
  }

  Future<bool> removeFromCart(CardModel cardModel) async {
    bool isSuccess = false;
    _removeFromCartListInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .deleteRequest(url: AppUrls.cardById(cardModel.cid ?? ''));
    if (response.isSuccess) {
      _cardList.removeWhere((e) => e.id == cardModel.id);
      isSuccess = true;
    } else {
      _removeFromCartErrorMessage = response.errorMessage;
    }
    _removeFromCartListInProgress = false;
    update();
    return isSuccess;
  }
}
