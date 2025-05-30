class CardModel {
  String? cid;
  String? id;
  String? title;
  String? photo;
  String? color;
  String? size;
  double? regularPrice;
  double? currentPrice;
  int? quantity;

  CardModel({
    this.cid,
    this.id,
    this.title,
    this.photo,
    this.color,
    this.size,
    this.regularPrice,
    this.currentPrice,
    this.quantity,
  });

  CardModel.fromJson(Map<String, dynamic> json) {
    cid = json['_id'];
    quantity = json['quantity'] ?? 0;
    final productJson = json['product'];
    if (productJson != null) {
      id = productJson['_id'];
      title = productJson['title'] ?? '';
      photo = (productJson['photos'] as List?)?.firstOrNull;
      color = (productJson['colors'] as List?)?.firstOrNull;
      size = (productJson['sizes'] as List?)?.firstOrNull;
      regularPrice = (productJson['regular_price'] ?? 0).toDouble();
      currentPrice = (productJson['current_price'] ?? 0).toDouble();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'cid': cid,
      'product': {
        '_id': id,
        'title': title,
        'photos': [photo], // store as list again
        'colors': [color],
        'sizes': [size],
        'regular_price': regularPrice,
        'current_price': currentPrice,
        'quantity': quantity,
      }
    };
  }
}
