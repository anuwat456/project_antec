import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_antec/configuration/config.dart';


import 'package:project_antec/models/UserScanDataModel.dart';
import 'package:project_antec/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _xOffset = 0;
  double _yOffset = 0;
  double _scaleFactor = 1;
  bool _isDrawerOpen = false;

  List<Data> _userScanModelDb = List<Data>();
  int _userId;
  String _userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserPreference();
  }

  Future getUserPreference() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefer.getInt('userId');
      _userName = prefer.getString('userName');
    });

    setUserScan();
  }
  
  void setUserScan() {
    Map params = Map();
    params['userId'] = _userId.toString();

    http.post('${Config.API_BASE_URL}/scanqrcode/findbyuserqrcode', body: params).then((res) {
      Map<String, dynamic> userScanMap = jsonDecode(res.body) as Map;
      UserScanDataModel userScanModel = UserScanDataModel.fromJson(userScanMap);
      setState(() {
        _userScanModelDb.addAll(userScanModel.data);
      });

      for (var i = 0; i < _userScanModelDb.length; i++) {
        print(_userScanModelDb[i].toJson().toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(_xOffset, _yOffset, 0)
        ..scale(_scaleFactor),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(_isDrawerOpen?40:0.0)),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _isDrawerOpen
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          _xOffset = 0;
                          _yOffset = 0;
                          _scaleFactor = 1;
                          _isDrawerOpen = false;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        setState(() {
                          _xOffset = 210;
                          _yOffset = 90;
                          _scaleFactor = 0.8;
                          _isDrawerOpen = true;
                        });
                      },
                    ),
              Column(
                children: [
                  Text(
                    _userName == null ? 'Profile' : '$_userName',
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: getProportionateScreenHeight(28),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(),
              Column(),
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
