class LoginModel {
  Data? data;
  int? code;

  LoginModel({this.data, this.code});

  LoginModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
    if (json["code"] is int) {
      code = json["code"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["data"] = this.data?.toJson();
    data["code"] = code;
    return data;
  }
}

class Data {
  UserInfo? userInfo;
  Token? token;

  Data({this.userInfo, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["userInfo"] is Map) {
      userInfo =
          json["userInfo"] == null ? null : UserInfo.fromJson(json["userInfo"]);
    }
    if (json["token"] is Map) {
      token = json["token"] == null ? null : Token.fromJson(json["token"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data["userInfo"] = userInfo?.toJson();
    }
    if (token != null) {
      data["token"] = token?.toJson();
    }
    return data;
  }
}

class Token {
  String? accessToken;
  String? refreshToken;

  Token({this.accessToken, this.refreshToken});

  Token.fromJson(Map<String, dynamic> json) {
    if (json["accessToken"] is String) {
      accessToken = json["accessToken"];
    }
    if (json["refreshToken"] is String) {
      refreshToken = json["refreshToken"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["accessToken"] = accessToken;
    data["refreshToken"] = refreshToken;
    return data;
  }
}

class UserInfo {
  String? id;
  String? email;
  String? phone;
  String? name;
  String? status;
  String? username;
  List<String>? roles;
  String? avatarUrl;
  String? tax;
  Company? company;
  String? companyCode;
  String? permissions;
  dynamic permissionGroup;
  dynamic stationId;

  UserInfo(
      {this.id,
      this.email,
      this.phone,
      this.name,
      this.status,
      this.username,
      this.roles,
      this.avatarUrl,
      this.tax,
      this.company,
      this.companyCode,
      this.permissions,
      this.permissionGroup,
      this.stationId});

  UserInfo.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["username"] is String) {
      username = json["username"];
    }
    if (json["roles"] is List) {
      roles = json["roles"] == null ? null : List<String>.from(json["roles"]);
    }
    if (json["avatarUrl"] is String) {
      avatarUrl = json["avatarUrl"];
    }
    if (json["tax"] is String) {
      tax = json["tax"];
    }
    if (json["company"] is Map) {
      company =
          json["company"] == null ? null : Company.fromJson(json["company"]);
    }
    if (json["companyCode"] is String) {
      companyCode = json["companyCode"];
    }
    if (json["permissions"] is String) {
      permissions = json["permissions"];
    }
    permissionGroup = json["permissionGroup"];
    stationId = json["stationId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["email"] = email;
    data["phone"] = phone;
    data["name"] = name;
    data["status"] = status;
    data["username"] = username;
    if (roles != null) {
      data["roles"] = roles;
    }
    data["avatarUrl"] = avatarUrl;
    data["tax"] = tax;
    if (company != null) {
      data["company"] = company?.toJson();
    }
    data["companyCode"] = companyCode;
    data["permissions"] = permissions;
    data["permissionGroup"] = permissionGroup;
    data["stationId"] = stationId;
    return data;
  }
}

class Company {
  String? id;
  String? avatarUrl;
  String? code;
  String? name;
  String? email;
  String? username;
  String? tax;
  String? phone;
  String? status;
  String? createdAt;

  Company(
      {this.id,
      this.avatarUrl,
      this.code,
      this.name,
      this.email,
      this.username,
      this.tax,
      this.phone,
      this.status,
      this.createdAt});

  Company.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["avatarUrl"] is String) {
      avatarUrl = json["avatarUrl"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["username"] is String) {
      username = json["username"];
    }
    if (json["tax"] is String) {
      tax = json["tax"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["avatarUrl"] = avatarUrl;
    data["code"] = code;
    data["name"] = name;
    data["email"] = email;
    data["username"] = username;
    data["tax"] = tax;
    data["phone"] = phone;
    data["status"] = status;
    data["createdAt"] = createdAt;
    return data;
  }
}