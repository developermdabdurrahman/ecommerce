class WishListItemModel {
  String? id;
  String? userId;
  String? createdAt;
  WishListProductModel? product;

  WishListItemModel({this.id, this.userId, this.createdAt, this.product});

  WishListItemModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['user'];
    createdAt = json['createdAt'];
    product = json['product'] != null ? WishListProductModel.fromJson(json['product']) : null;
  }
}

class WishListProductModel {
  String? id;
  String? title;
  String? slug;
  List<String>? photos;
  List<String>? colors;
  List<String>? sizes;
  int? regularPrice;
  int? currentPrice;
  int? quantity;
  String? createdAt;

  WishListProductModel({
    this.id,
    this.title,
    this.slug,
    this.photos,
    this.colors,
    this.sizes,
    this.regularPrice,
    this.currentPrice,
    this.quantity,
    this.createdAt,
  });

  WishListProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'] ?? '';
    slug = json['slug'] ?? '';
    photos = List<String>.from(json['photos'] ?? []);
    colors = List<String>.from(json['colors'] ?? []);
    sizes = List<String>.from(json['sizes'] ?? []);
    regularPrice = json['regular_price'] ?? 0;
    currentPrice = json['current_price'] ?? 0;
    quantity = json['quantity'] ?? 0;
    createdAt = json['createdAt'];
  }
}
