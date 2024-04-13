// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResetPasswordParams {
  final String token;
  final String username;
  final String newPassword;

  ResetPasswordParams(
      {required this.token, required this.username, required this.newPassword});

  Map<String, String> toMap() {
    return <String, String>{
      'token': token,
      'username': username,
      'newPassword': newPassword,
    };
  }

  factory ResetPasswordParams.fromMap(Map<String, String> map) {
    return ResetPasswordParams(
      token: map['token'] as String,
      username: map['username'] as String,
      newPassword: map['newPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordParams.fromJson(String source) =>
      ResetPasswordParams.fromMap(json.decode(source) as Map<String, String>);
}
