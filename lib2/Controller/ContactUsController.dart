// ignore_for_file: file_names, prefer_typing_uninitialized_variables, empty_catches, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:web_application/Controller/CategoryController.dart';
import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Models/SocialBlockModel.dart';
import 'package:web_application/Models/UserModel.dart';

class ContactUsController {
  var client = CategoryController.client;
  String ip = CategoryController.ip;
  Future<List<SocialBlockModel>?> getAllCenters() async {
    String path = ip + "/api/social_media.php";
    var response;
        ResponseModel responseModel ;
        // ignore: avoid_init_to_null
        List<SocialBlockModel>? contactList = null;
    try {
      response = await client.get(
      Uri.parse(path),
    );
     responseModel =
        ResponseModel.fromJson(json.decode(response.body));
    
    if (responseModel.status!) {
      contactList = [];
      for (var item in responseModel.data) {
        contactList.add(SocialBlockModel.fromJson(item));
      }
      return contactList;
    }
    } catch (e) {
    }
    return [];
  }

  Future<ResponseModel> sendMessage(String message) async {
    String path = ip + "/api/send_message.php";
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
    var response = await client.post(Uri.parse(path),
        body: json.encode({
          'user_id': id,
          'message': message
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    ResponseModel responseModel =
        ResponseModel.fromJson(json.decode(response.body));

    return responseModel;
  }
}
