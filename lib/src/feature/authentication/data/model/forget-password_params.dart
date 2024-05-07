// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ForgetPasswordParams {
  final String username;
  final String phone;

  ForgetPasswordParams({required this.username, required this.phone});

  Map<String, String> toMap() {
    return <String, String>{
      'username': username,
      'phone': phone,
    };
  }

  factory ForgetPasswordParams.fromMap(Map<String, String> map) {
    return ForgetPasswordParams(
      username: map['username'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgetPasswordParams.fromJson(String source) =>
      ForgetPasswordParams.fromMap(json.decode(source) as Map<String, String>);
}
