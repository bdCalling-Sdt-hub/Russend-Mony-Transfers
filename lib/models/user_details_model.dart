class UserDetailsModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  UserDetailsModel(
      {this.status, this.statusCode, this.message, this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? type;
  Attributes? attributes;

  Data({this.type, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? sId;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? password;
  Image? image;
  String? role;
  String? passcode;
  bool? isBlocked;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Attributes(
      {this.sId,
        this.fullName,
        this.email,
        this.phoneNumber,
        this.password,
        this.image,
        this.role,
        this.passcode,
        this.isBlocked,
        this.iV,
        this.createdAt,
        this.updatedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    role = json['role'];
    passcode = json['passcode'];
    isBlocked = json['isBlocked'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['role'] = this.role;
    data['passcode'] = this.passcode;
    data['isBlocked'] = this.isBlocked;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Image {
  String? publicFileUrl;
  String? path;

  Image({this.publicFileUrl, this.path});

  Image.fromJson(Map<String, dynamic> json) {
    publicFileUrl = json['publicFileUrl'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicFileUrl'] = this.publicFileUrl;
    data['path'] = this.path;
    return data;
  }
}