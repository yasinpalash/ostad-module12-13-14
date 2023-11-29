import 'dart:convert';

import 'package:http/http.dart';
import 'package:module12/ui/controllers/auth_controller.dart';


import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        "content-type": "Application/json",
            'token':AuthController.token.toString(),
      });
      print(response.statusCode.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
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
}
