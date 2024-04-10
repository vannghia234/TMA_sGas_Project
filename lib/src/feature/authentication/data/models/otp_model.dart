// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OTPModel {
  String? data;
  int? code;
  OTPModel({
    this.data,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'code': code,
    };
  }

  factory OTPModel.fromMap(Map<String, dynamic> map) {
    return OTPModel(
      data: map['data'] != null ? map['data'] as String : null,
      code: map['code'] != null ? map['code'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OTPModel.fromJson(String source) =>
      OTPModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
