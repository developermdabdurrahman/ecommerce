class ReviewModel {
  final String id;
  final String uid;
  final String userName;
  final int rating;
  final String comment;

  ReviewModel({
    required this.id,
    required this.uid,
    required this.userName,
    required this.rating,
    required this.comment,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'],
      uid:  json['user']['_id'],
      userName: "${json['user']['first_name']} ${json['user']['last_name']}",
      comment: json['comment']??'',
        rating: (json['rating'] ?? 0).toDouble().toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'userName': userName,
      'comment': comment,
      'rating':rating,
    };
  }
}

