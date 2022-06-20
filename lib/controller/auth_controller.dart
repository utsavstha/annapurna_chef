import 'package:annapurna_chef/network/http_requests.dart';
import 'package:annapurna_chef/utils/api_constants.dart';
import 'package:annapurna_chef/utils/api_response.dart';
import 'package:annapurna_chef/utils/save_data.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool isLoading = true;

  String message = '';

  late HttpNetworkRequest httpRequest;
  late ApiResponse apiResponse;

  AuthController() {
    apiResponse = ApiResponse.loading(false);
    httpRequest = HttpNetworkRequest();
  }
  void login(String email, String password) async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      final Map<String, dynamic> data = {"email": email, "password": password};
      var response = await httpRequest.post(ApiConstants.loginUrl, data);

      // if (response.)
      if (response.containsKey('token')) {
        if (response['user']['role'] == 'chef' ||
            response['user']['role'] == 'admin') {
          SaveData.saveData(
              response['token']['token'],
              response['user']['email'],
              response['user']['first_name'] +
                  " " +
                  response['user']['last_name'],
              response['user']['role']);
          apiResponse = ApiResponse.success(false, "success");
        } else {
          apiResponse = ApiResponse.success(false, "You are not authorized");
        }
      } else {
        apiResponse = ApiResponse.success(false, "failed");
      }

      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Could not Transaction");
    }

    notifyListeners();
  }
}
