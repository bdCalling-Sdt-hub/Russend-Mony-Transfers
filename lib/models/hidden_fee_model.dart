class HiddenFeesModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  HiddenFeesModel({this.status, this.statusCode, this.message, this.data});

  HiddenFeesModel.fromJson(Map<String, dynamic> json) {
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
  Attributes? attributes;

  Data({this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}

class Attributes {
  String? sId;
  num? otherCountriesFree;
  num? cameroonFee;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  num? iV;

  Attributes(
      {this.sId,
      this.otherCountriesFree,
      this.cameroonFee,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Attributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    otherCountriesFree = json['percentage'];
    cameroonFee = json['cameroonFee'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
