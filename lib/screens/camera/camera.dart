import 'package:flutter/material.dart';

import 'components/body.dart';

class CamaraScreen extends StatelessWidget {
static String routeName = "/camera";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BodyCamera(),
    );
  }
}
