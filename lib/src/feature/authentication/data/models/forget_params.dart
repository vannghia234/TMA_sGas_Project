// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ForgetParams {
  final String username;
  final String phone;

  ForgetParams({required this.username, required this.phone});

  Map<String, String> toMap() {
    return <String, String>{
      'username': username,
      'phone': phone,
    };
  }

  factory ForgetParams.fromMap(Map<String, String> map) {
    return ForgetParams(
      username: map['username'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgetParams.fromJson(String source) =>
      ForgetParams.fromMap(json.decode(source) as Map<String, String>);
}
