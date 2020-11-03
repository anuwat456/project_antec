import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_antec/components/custom_surfix_icon.dart';
import 'package:project_antec/constants.dart';
import 'package:project_antec/screens/camera/camera.dart';
import 'package:project_antec/screens/login/login.dart';
import 'package:project_antec/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color backgroundColor = kPrimaryColor;

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

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
      _userName = prefer.getString('userName');
    });
  }

  Future<Null> onLogout() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.clear();

    MaterialPageRoute route = MaterialPageRoute(builder: (context) => LoginScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      padding: EdgeInsets.only(top: 50, left: 20, bottom: 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userName == null ? 'Profile' : '$_userName',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(20)),
                  )
                ],
              )
            ],
          ),

          Column(
            children: [
              // Row(
              //   children: [
              //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
              //     SizedBox(width: 5),
              //     GestureDetector(
              //       onTap: null,
              //       child: Text(
              //         "Profile",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, CamaraScreen.routeName),
                    child: Row(children: [
                      CustomSurffixIcon(svgIcon: "assets/icons/Camera Icon.svg"),
                      SizedBox(width: 8,),
                      Text(
                        "Camera",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],)
                  ),
                ],
              ),
            ],
          ),

          Column(),
          Column(),
          Column(),

          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    onLogout();
                  },
                  child: Text(
                    "Log out",
                    style:
                      TextStyle(color: Colors.white, fontSize: getProportionateScreenWidth(16)),
              ))
            ],
          )
        ],
      ),
    );
  }
}
