import 'dart:convert';
import 'package:http/http.dart';
import 'package:module12/ui/controllers/auth_controller.dart';
import 'package:module12/ui/screen/login_screen.dart';
import '../app.dart';
import 'network_response.dart';
import 'package:flutter/material.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        "content-type": "Application/json",
        'token': AuthController.token.toString(),
      });
      print(response.statusCode.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          backToLogin();
        }

        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      } else {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMassage: e.toString());
    }
  }

  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url), headers: {
        "content-type": "Application/json",
        'token': AuthController.token.toString(),
      });
      print(response.statusCode.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        backToLogin();

        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      } else {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMassage: e.toString());
    }
  }

  void backToLogin() async {
    await AuthController.clearAuthData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigationKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
