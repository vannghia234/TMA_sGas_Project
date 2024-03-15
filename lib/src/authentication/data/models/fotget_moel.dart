class ForgetModel {
  String? data;
  int? code;

  ForgetModel({this.data, this.code});

  ForgetModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] is String) {
      data = json["data"];
    }
    if (json["code"] is int) {
      code = json["code"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["data"] = data;
    data["code"] = code;
    return data;
  }
}
