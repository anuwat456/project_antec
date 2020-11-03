class UserScanDataModel {
  String message;
  List<Data> data;
  int status;

  UserScanDataModel({this.message, this.data, this.status});

  UserScanDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int userId;
  int qrCodeId;
  String userScanner;
  int id;

  Data({this.userId, this.qrCodeId, this.userScanner, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    qrCodeId = json['qrCodeId'];
    userScanner = json['userScanner'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['qrCodeId'] = this.qrCodeId;
    data['userScanner'] = this.userScanner;
    data['id'] = this.id;
    return data;
  }
}