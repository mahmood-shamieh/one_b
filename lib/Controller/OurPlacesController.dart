// ignore_for_file: file_names, prefer_typing_uninitialized_variables, empty_catches, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:web_application/Controller/CategoryController.dart';
import 'package:web_application/Models/CenterModel.dart';
import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Models/UserModel.dart';

class OurPlacesController {
  var client = CategoryController.client;
  String ip = CategoryController.ip;
  Future<List<CenterModel>?> getAllCenters(String address) async {
    String path = ip + "/api/searchCenters.php";
    var token = '';
    if (GetStorage().read('userModel') is UserModel)
      token = (GetStorage().read('userModel') as UserModel).token ?? "";
    else
      token = UserModel.fromJson(GetStorage().read('userModel')).token ?? "";
    var response;
    ResponseModel responseModel;
    // ignore: avoid_init_to_null
    List<CenterModel>? centers = null;

    try {
      response = await client.post(Uri.parse(path),
          body: json.encode({'search': address}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      responseModel = ResponseModel.fromJson(json.decode(response.body));
      if (responseModel.status!) {
        centers = [];
        for (var item in responseModel.data) {
          centers.add(CenterModel.fromson(item));
        }
        return centers;
      }
    } catch (e) {}
    return [];
  }
}
