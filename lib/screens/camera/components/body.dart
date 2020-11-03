import 'package:flutter/material.dart';
import 'package:project_antec/constants.dart';
import 'package:project_antec/size_config.dart';

import 'camera_form.dart';

class BodyCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Scan QR code",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                CameraForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
