class UserDataModel {
  String message;
  Data data;
  int status;

  UserDataModel({this.message, this.data, this.status});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int id;
  String userName;
  String passWord;
  String createDate;

  Data({this.id, this.userName, this.passWord, this.createDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    passWord = json['passWord'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['passWord'] = this.passWord;
    data['createDate'] = this.createDate;
    return data;
  }
}