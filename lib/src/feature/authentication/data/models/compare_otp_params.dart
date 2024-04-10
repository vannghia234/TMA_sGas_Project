// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CompareOTPParams {
  final String username;
  final String oneTimeOtp;

  CompareOTPParams({required this.username, required this.oneTimeOtp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'oneTimeOtp': oneTimeOtp,
    };
  }

  factory CompareOTPParams.fromMap(Map<String, dynamic> map) {
    return CompareOTPParams(
      username: map['username'] as String,
      oneTimeOtp: map['oneTimeOtp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompareOTPParams.fromJson(String source) => CompareOTPParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
