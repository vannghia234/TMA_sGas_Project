class ChangePasswordModel {
  String? data;
  int? code;

  ChangePasswordModel({this.data, this.code});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
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
