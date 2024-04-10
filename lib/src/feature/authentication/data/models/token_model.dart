class TokenModel {
  final String accessToken;
  final String refreshToken;

  TokenModel(this.accessToken, this.refreshToken);

  static TokenModel fromJson(dynamic json) {
    return TokenModel(json['accessToken'], json['refreshToken']);
  }
}
