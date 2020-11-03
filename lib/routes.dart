import 'package:flutter/widgets.dart';
import 'package:project_antec/screens/camera/camera.dart';
import 'package:project_antec/screens/login/login.dart';
import 'package:project_antec/screens/menudashboard/mainmenudashboard.dart';
import 'package:project_antec/screens/register/register.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  ReginterScreen.routeName: (context) => ReginterScreen(),
  Homepage.routeName: (context) => Homepage(),
  CamaraScreen.routeName: (context) => CamaraScreen(),
};