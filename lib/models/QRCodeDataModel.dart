class QRCodeDataModel {
  String message;
  List<Data> data;
  int status;

  QRCodeDataModel({this.message, this.data, this.status});

  QRCodeDataModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String qrCode;
  String generateQRCode;

  Data({this.id, this.qrCode, this.generateQRCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qrCode = json['qrCode'];
    generateQRCode = json['generateQRCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qrCode'] = this.qrCode;
    data['generateQRCode'] = this.generateQRCode;
    return data;
  }
}