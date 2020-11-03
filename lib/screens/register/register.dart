import 'package:flutter/material.dart';
import 'package:project_antec/screens/register/components/body.dart';

class ReginterScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: BodyRegister(),
    );
  }
}