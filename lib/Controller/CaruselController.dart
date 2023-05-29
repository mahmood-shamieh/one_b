// ignore_for_file: prefer_typing_uninitialized_variables, file_names, empty_catches, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_application/Controller/CategoryController.dart';
import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Models/UserModel.dart';

import '../main.dart';

class CaruselConroller {
  var ip = CategoryController.ip;
  var client = CategoryController.client;

  Future<List<String>?> getImages() async {
    String path = ip + '/api/photoCarusel.php';
    var token = '';
    if (GetStorage().read('userModel') is UserModel)
      token = (GetStorage().read('userModel') as UserModel).token ?? "";
    else
      token = UserModel.fromJson(GetStorage().read('userModel')).token ?? "";
    var id = '';
    if (GetStorage().read('userModel') is UserModel)
      id = (GetStorage().read('userModel') as UserModel).id ?? "";
    else
      id = UserModel.fromJson(GetStorage().read('userModel')).id ?? "";

    var response;
    ResponseModel responseModel;
    // ignore: avoid_init_to_null
    List<String>? images = null;
    try {
      response = await client.post(Uri.parse(path),
          body: json.encode(
              {'user_id': id}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': '*'
          });
          print("-------------------------");
          print(response.body);
      responseModel = ResponseModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        images = [];
        for (var item in responseModel.data) {
          images.add(
              MyApp.hostName + "/admin/files/images/slider/" + item['photo']);
        }
      }
    } catch (e) {
      return [];
    }
    return images;
  }
}
