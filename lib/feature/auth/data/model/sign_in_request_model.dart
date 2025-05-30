class SignInRequestModel {

  final String email;
  final String password;


  SignInRequestModel({
    required this.email,
    required this.password,
  });

  factory SignInRequestModel.toJson(Map<String, dynamic> jsonData) {
    return SignInRequestModel(
      email: jsonData['email'],
      password: jsonData['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
