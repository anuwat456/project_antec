import 'package:flutter/material.dart';
import 'package:project_antec/routes.dart';
import 'package:project_antec/screens/login/login.dart';
import 'package:project_antec/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }

}