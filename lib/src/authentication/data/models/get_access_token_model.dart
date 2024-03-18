class GetAccessTokenModel {
  Data? data;
  int? code;

  GetAccessTokenModel({this.data, this.code});

  GetAccessTokenModel.fromJson(Map<String, dynamic> json) {
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
  dynamic email;
  String? phone;
  String? name;
  String? status;
  String? username;
  List<String>? roles;
  String? avatarUrl;
  dynamic tax;
  Company? company;
  String? companyCode;
  String? permissions;
  PermissionGroup? permissionGroup;
  String? stationId;

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
    email = json["email"];
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
    tax = json["tax"];
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
    if (json["permissionGroup"] is Map) {
      permissionGroup = json["permissionGroup"] == null
          ? null
          : PermissionGroup.fromJson(json["permissionGroup"]);
    }
    if (json["stationId"] is String) {
      stationId = json["stationId"];
    }
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
    if (permissionGroup != null) {
      data["permissionGroup"] = permissionGroup?.toJson();
    }
    data["stationId"] = stationId;
    return data;
  }
}

class PermissionGroup {
  String? id;
  String? name;
  String? description;
  String? status;
  List<String>? permissionIds;

  PermissionGroup(
      {this.id, this.name, this.description, this.status, this.permissionIds});

  PermissionGroup.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["permissionIds"] is List) {
      permissionIds = json["permissionIds"] == null
          ? null
          : List<String>.from(json["permissionIds"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["status"] = status;
    if (permissionIds != null) {
      data["permissionIds"] = permissionIds;
    }
    return data;
  }
}

class Company {
  String? id;
  dynamic avatarUrl;
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
    avatarUrl = json["avatarUrl"];
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
