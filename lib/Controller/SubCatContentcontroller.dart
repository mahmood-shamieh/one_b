// ignore_for_file: file_names, prefer_typing_uninitialized_variables, empty_catches, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:web_application/Controller/CategoryController.dart';
import 'package:web_application/Models/DropDownButtonModel.dart';
import 'package:web_application/Models/ImageLodaer.dart';
import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Models/TextFieldModel.dart';
import 'package:web_application/Models/UserModel.dart';

class SubCatContentContoller {
  var client = CategoryController.client;
  String ip = CategoryController.ip;
  Future<Map<String, dynamic>> getSubCatContent(Map map) async {
    String path = ip + "/api/subcat_content.php";
    var token = '';
    if (GetStorage().read('userModel') is UserModel)
      token = (GetStorage().read('userModel') as UserModel).token ?? "";
    else
      token = UserModel.fromJson(GetStorage().read('userModel')).token ?? "";
    // print(map);
    var response;
    ResponseModel responseModel;
    // ignore: avoid_init_to_null
    List? dropDownButtons = null;
    // ignore: avoid_init_to_null
    List? textFields = null;
    // ignore: avoid_init_to_null
    List? multiTextField = null;
    // ignore: avoid_init_to_null
    List? imageLodaers = null;
    try {
      response =
          await client.post(Uri.parse(path), body: json.encode(map), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      responseModel = ResponseModel.fromJson(json.decode(response.body));
      if (responseModel.status!) {
        dropDownButtons = [];
        textFields = [];
        multiTextField = [];
        imageLodaers = [];
        for (var item in responseModel.data) {
          
          if (item['type'] == "dropdown" || item['type'] == "dropdown_bill") {
            dropDownButtons.add(DropDownButtonModel.fromJson(item));
            
          }
          if (item['type'] == "text") {
            textFields.add(TextFieldModel.fromJson(item));
          }

          if (item['type'] == "list") {
            multiTextField.add(TextFieldModel.fromJson(item));
          }
          if(item['type'] == "image"){
            imageLodaers.add(ImageLoader.fromMap(item));
          }
        }
      }
    } catch (e) {}
    return {
      'dropDowns': dropDownButtons,
      'textFields': textFields,
      'multiTextField' : multiTextField,
      'imageLoaders' :imageLodaers
    };
  }

  Future<ResponseModel> addOrder(Map map) async {
    String path = ip + "/api/set_user_order.php";
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
    // ignore: await_only_futures
    map['user_id'] = id;
    var response;
    try {
      response =
        await client.post(Uri.parse(path), body: json.encode(map), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });  
    } catch (e) {
      return ResponseModel.fromJson({"status":false,"msg":"فشلت العملية","token":"","data":""});
    }
    // print(response.body);
    ResponseModel responseModel = 
        ResponseModel.fromJson(json.decode(response.body));

    return responseModel;
  }
  Future<ResponseModel> setOrderSent(String orderId) async {
    
    String path = ip + "/api/ask_order_sent.php";
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
    // ignore: await_only_futures
    var data = {};
    data['user_id'] = id;
    data['order_id'] = orderId;
    
    var response;
    try {
      
    response =
        await client.post(Uri.parse(path), body: json.encode(data), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    } catch (e) {
      return ResponseModel.fromJson({"status":false,"msg":"فشلت العملية","token":"","data":""});
    }
    
    ResponseModel responseModel =
        ResponseModel.fromJson(json.decode(response.body));

    
    return responseModel;
  }
  

}
