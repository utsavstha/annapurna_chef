import 'dart:convert';

import 'package:annapurna_chef/model/order_item.dart';
import 'package:annapurna_chef/network/http_requests.dart';
import 'package:annapurna_chef/utils/api_constants.dart';
import 'package:annapurna_chef/utils/api_response.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier {
  bool isLoading = true;

  String message = '';

  bool success = false;
  late HttpNetworkRequest httpRequest;
  late List<OrderModel> tableModel;
  late List<OrderModel> pollModel;
  late ApiResponse apiResponse;

  DashboardController() {
    apiResponse = ApiResponse.loading(false);
    httpRequest = HttpNetworkRequest();
    tableModel = [];
  }

  void notify(
      String tableName, String quantity, String itemName, int id) async {
    try {
      final Map<String, dynamic> data = {
        "table_name": tableName,
        "product_name": itemName,
        "quantity": quantity
      };
      var response =
          await httpRequest.postWithAuth(ApiConstants.notificationUrl, data);
      var res =
          await httpRequest.getWithAuth(ApiConstants.setCooked + id.toString());
      print(response);
      print(res);
      // // final data = json.decode(response);
      // tableModel = [];
      // response.map((item) {
      //   tableModel.add(OrderModel.fromJson(item));
      // }).toList();

      // apiResponse = ApiResponse.success(false, tableModel);
      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Could not Transaction");
    }
  }

  void getOrders() async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      var response = await httpRequest.getWithAuth(ApiConstants.getOrders);
      print(response.runtimeType);
      // final data = json.decode(response);
      tableModel = [];
      response.map((item) {
        tableModel.add(OrderModel.fromJson(item));
      }).toList();

      apiResponse = ApiResponse.success(false, tableModel);
      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Could not Transaction");
    }

    notifyListeners();
  }

  void pollOrders() async {
    try {
      var response = await httpRequest.getWithAuth(ApiConstants.getOrders);
      print(response.runtimeType);
      // final data = json.decode(response);
      pollModel = [];
      response.map((item) {
        pollModel.add(OrderModel.fromJson(item));
      }).toList();

      if (pollModel != tableModel) {
        tableModel = pollModel;
        apiResponse = ApiResponse.success(false, tableModel);
        notifyListeners();
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

  void delete(String id) async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      var response =
          await httpRequest.deletetWithAuth(ApiConstants.getBudgets + "/" + id);

      success = true;
      apiResponse = ApiResponse.success(false, success);

      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Could not Transaction");
    }

    notifyListeners();
  }
}
