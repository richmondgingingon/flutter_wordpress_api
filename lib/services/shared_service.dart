import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService{
  static Future<bool> isLoggedIn() async{
    final prefs = await SharedPreferences.getInstance();
    /* print('isLoggedIn : ${prefs.getString("login_details")}'); */
    return prefs.getString("login_details") != null ? true : false;
  }

  static Future<LoginResponseModel> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_details") != null ? LoginResponseModel.fromJson(jsonDecode(prefs.getString("login_details"),),
    ) : null ;
  }

  static Future<void> setLoginDetails (LoginResponseModel responseModel) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("login_details", responseModel != null ? jsonEncode(responseModel.toJson(),) : "null");
  }

  static Future<void> logout(BuildContext context) async{
    await setLoginDetails(null);
    Navigator.of(context).pushReplacementNamed('/login');
  }
}