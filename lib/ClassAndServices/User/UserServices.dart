
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduan_test/ClassAndServices/AuthToken/AuthToken.dart';
import 'package:graduan_test/ClassAndServices/ErrorHandler.dart';
import 'package:graduan_test/ClassAndServices/PageNavigatorService.dart';
import 'package:graduan_test/ClassAndServices/User/User.dart';
import 'package:graduan_test/UserInterface/UserPages/SignInPage.dart';
import 'package:graduan_test/UserInterface/UserPages/UpdateUserInfoPage.dart';
import 'package:graduan_test/UserInterface/UserPages/UserInfoPage.dart';
import 'package:http/http.dart' as http;

class UserServices {

  void goToUserInfoPage(BuildContext context,) {
    PageNavigatorService.navigateTo(context, UserInfoPage());
  }

 void goToUserUpdateInfoPage(BuildContext context, String name) async {
   PageNavigatorService.navigateTo(context, UpdateUserInfoPage(name: name));
  }

  Future<ReturnAuthToken?> loginUser({required String email, required String password}) async {

    final String apiUrl = "https://flutter-api-demo.graduan.xyz/api/login";

    bool success = false;
    String text ="";
    Object? error;
    ReturnAuthToken? returnAuthToken;

    Map<String, String> loginData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginData),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        success = true;
        text = "Login Successful";
        returnAuthToken = ReturnAuthToken(text: text, success: success, authToken: AuthToken.fromJson(data));
      } else {
        success = false;
        text = "Failed To Login [${response.statusCode}]";
      }
    } catch (e) {
      success = false;
      text = "Failed To Login: $e";
      error = e;
    }
    ErrorHandler().logSuccessOrError(success: success, text: text, error: error);
    return returnAuthToken;
  }

  Future<ReturnHandler> logOutUser() async {

    final String apiUrl = "https://flutter-api-demo.graduan.xyz/api/dashboard/logout";

    bool success = false;
    String text ="";
    Object? error;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authTokenGlobal',
        },
      );

      if (response.statusCode == 204) {
        success = true;
        text = "Log Out Successful";
      } else {
        success = false;
        text = "Failed To Log Out [${response.statusCode}]";
      }
    } catch (e) {
      success = false;
      text = "Failed To Log Out: $e";
      error = e;
    }
    ErrorHandler().logSuccessOrError(success: success, text: text, error: error);
    return ReturnHandler(text: text, success: success);
  }

  Future<ReturnUser?> getUserInfo() async {

    bool success = false;
    String text ="";
    Object? error;
    ReturnUser? returnUser;

    final String apiUrl = "https://flutter-api-demo.graduan.xyz/api/dashboard/profile";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authTokenGlobal',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        success = true;
        text = "Get User Info Successful";
        returnUser = ReturnUser(text: text, success: success, user: User.fromJson(data));
      } else {
        success = false;
        text = "Get User Info Failed [${response.statusCode}]";
      }
    } catch (e) {
      success = false;
      text = "Get User Info Failed: $e";
      error = e;
    }
    ErrorHandler().logSuccessOrError(success: success, text: text, error: error);
    return returnUser;
  }

  Future<ReturnHandler> updateUserInfo( String name) async {

    bool success = false;
    String text ="";
    Object? error;
    final String apiUrl = "https://flutter-api-demo.graduan.xyz/api/dashboard/profile";
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authTokenGlobal',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        String responseBody = response.body;
        print(responseBody);
        if (responseBody == '"Updated"') {
          success = true;
          text = "Profile Updated Successful";
        } else {
          success = false;
          text = "Profile Updated Failed [${response.statusCode}]: Wrong Response";
        }
      } else {
        success = false;
        text = "Profile Updated Failed [${response.statusCode}]";
      }
    } catch (e) {
      success = false;
      text = "Profile Updated Failed: $e";
      error = e;
    }
    ErrorHandler().logSuccessOrError(success: success, text: text, error: error);
    return ReturnHandler(text: text, success: success);
  }


}