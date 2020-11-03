import 'package:flutter/material.dart';
import 'package:project_antec/screens/menudashboard/components/homescreen.dart';

import 'components/drawerscreen.dart';

class Homepage extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen()
        ],
      ),
    );
  }
}
