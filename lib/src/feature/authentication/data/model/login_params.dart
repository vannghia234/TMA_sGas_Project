class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});

  Map<String, String> toJson() {
    return {
      "username": username,
      "password": password,
    };
  }
}
