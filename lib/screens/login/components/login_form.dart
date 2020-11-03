import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_antec/models/UserDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:project_antec/components/custom_surfix_icon.dart';
import 'package:project_antec/components/default_button.dart';
import 'package:project_antec/components/form_error.dart';
import 'package:project_antec/configuration/config.dart';
import 'package:project_antec/screens/menudashboard/mainmenudashboard.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class LoginForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  bool remember = false;
  final List<String> errors = [];

  Future<Null> onLogin() async {
    Map params = Map();
    params['userName'] = _username;
    params['passWord'] = _password;

    SharedPreferences prefer = await SharedPreferences.getInstance();

    http.post('${Config.API_BASE_URL}/user/login', body: params).then((res) {
      Map<String, dynamic> _userMap = jsonDecode(res.body) as Map;
      UserDataModel userModel = UserDataModel.fromJson(_userMap);

      /// Save user data to SharedPreference
      prefer.setInt('userId', userModel.data.id);
      prefer.setString('userName', userModel.data.userName);

      // print('Login: ' + params.toString()),
      // print(res.body),
      if (userModel.data.id == null) {
        print("Not Found User");
      } else {
        /// Save user login log
        params['userId'] = _userMap["data"]["id"].toString();
        http.post('${Config.API_BASE_URL}/login_log/createLoginLog', body: params);

        /// Route page to dashboard
        Navigator.popAndPushNamed(context, Homepage.routeName);
      }
    });
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                onLogin();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      onSaved: (newValue) => _username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUserNullError);
        } else if (userValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidUserError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kUserNullError);
          return "";
        } else if (!userValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidUserError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "User",
        hintText: "Enter your user",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => _password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}