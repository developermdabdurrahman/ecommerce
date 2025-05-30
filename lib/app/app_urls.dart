class AppUrls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String signUpUrl = '$_baseUrl/auth/signUp';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String signInUrl = '$_baseUrl/auth/login';
  static const String slidesUrl = '$_baseUrl/slides';
  static const String CategoryUrl = '$_baseUrl/categories';
  static const String productListUrl = '$_baseUrl/products';
  static const String card = '$_baseUrl/cart';
  static const String wishlist = '$_baseUrl/wishlist';

  static String cardById(String id) => '$_baseUrl/cart/$id';

  static String reviewList = '$_baseUrl/reviews';
  static String review = '$_baseUrl/review';

  static String productDetailsUrl(String id) => '$_baseUrl/products/id/$id';
}
