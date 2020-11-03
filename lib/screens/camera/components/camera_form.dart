import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_antec/models/QRCodeDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:project_antec/configuration/config.dart';
import 'package:project_antec/constants.dart';

class CameraForm extends StatefulWidget {
  @override
  _CameraFormState createState() => _CameraFormState();
}

class _CameraFormState extends State<CameraForm> {
  List<Data> _qrCodeModelDb = List<Data>();
  int _userId;
  int _qrCodeId;

  String _qrCodeResult = "Not Yet Scanned";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setQrCode();
    getUserPreference();
  }
  
  void setQrCode() {
    http.post('${Config.API_BASE_URL}/qrcode/findallqrcodes').then((res) {
      Map<String, dynamic> qrcMap = jsonDecode(res.body) as Map;
      QRCodeDataModel qrCodeModel = QRCodeDataModel.fromJson(qrcMap);
      setState(() {
        _qrCodeModelDb.addAll(qrCodeModel.data);
      });
    });
  }

  Future getUserPreference() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefer.getInt('userId');
    });
  }
  
  void onCheckQRCode() {
    Map params = Map();
    params['userId'] = _userId.toString();
    params['qrCodeId'] = _qrCodeId.toString();

    for (var i = 0; i < _qrCodeModelDb.length; i++) {
      // print(_qrCodeModelDb[i].qrCode);

      if (_qrCodeModelDb[i].qrCode.toString() == _qrCodeResult) {
        _qrCodeId = _qrCodeModelDb[i].id;
        // print(_qrCodeId.toString());

        http.post('${Config.API_BASE_URL}/scanqrcode/userscan', body: params).then((res) {
          Map _scanMap = jsonDecode(res.body) as Map;
          print(_scanMap);
        });
        _qrCodeResult = 'Scan QR-Code success.';
        return null;
      }
    }

    _qrCodeResult = 'Scan QR-Code fail.';
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Result",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            _qrCodeResult,
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
            padding: EdgeInsets.all(15.0),
            onPressed: () async {
              String codeScanner = await BarcodeScanner.scan();//barcode scanner
              setState(() {
                _qrCodeResult = codeScanner;
                onCheckQRCode();
              });

            },
            child: Text(
              "Open Scanner",
              style:
              TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold
              ),
            ),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: kPrimaryColor, width: 3.0),
                borderRadius: BorderRadius.circular(20.0)
            ),
          )
        ],
      ),
    );
  }
}
