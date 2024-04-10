// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChangePasswordParams {
  final String token;
  final String username;
  final String newPassword;

  ChangePasswordParams(
      {required this.token, required this.username, required this.newPassword});

  Map<String, String> toMap() {
    return <String, String>{
      'token': token,
      'username': username,
      'newPassword': newPassword,
    };
  }

  factory ChangePasswordParams.fromMap(Map<String, String> map) {
    return ChangePasswordParams(
      token: map['token'] as String,
      username: map['username'] as String,
      newPassword: map['newPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordParams.fromJson(String source) =>
      ChangePasswordParams.fromMap(json.decode(source) as Map<String, String>);
}
