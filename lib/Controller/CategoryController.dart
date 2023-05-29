// ignore_for_file: file_names, empty_catches, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:web_application/Models/CategoryModel.dart';
import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Models/SubCategoryModel.dart';
import 'package:web_application/Models/UserModel.dart';
import 'package:web_application/main.dart';

class CategoryController {
  static var client = http.Client();

  static String ip = MyApp.hostName;
  

  Future<List<dynamic>?> getDynamicCat() async {
    List<CategoryModel> categories = [];
    String path = ip + '/api/cat.php';
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
      responseModel = ResponseModel.fromJson(json.decode(response.body));
      
      if (response.statusCode == 200) {
        for (var item in responseModel.data) {
          categories.add(CategoryModel.fromJson(item));
        }
        
        var cats = jsonEncode(categories,
            toEncodable: (e) => (e as CategoryModel).toJson());
        GetStorage().write("cats", cats);
        return categories;
      }
    } catch (e) {}
    return [];
  }

  Future<List<dynamic>?> getSubCats(int catId) async {
    String path = ip + '/api/subcat.php';
    var token = '';
    if (GetStorage().read('userModel') is UserModel)
      token = (GetStorage().read('userModel') as UserModel).token ??"";
    else
      token = UserModel.fromJson(GetStorage().read('userModel')).token ??"";
      var id = '';
    if (GetStorage().read('userModel') is UserModel)
      id = (GetStorage().read('userModel') as UserModel).id!;
    else
      id = UserModel.fromJson(GetStorage().read('userModel')).id!;
    var response;
    ResponseModel responseModel;
    // ignore: avoid_init_to_null
    List<dynamic>? subCats = null;
    try {
       response= await client.post(Uri.parse(path),
        body: json.encode({
          'user_id': id,
          'cat_id': catId
        }),
        headers: {
          'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': '*'

        });
     responseModel =
        ResponseModel.fromJson(json.decode(response.body));
    
    if (response.statusCode == 200) {
      subCats = [];
      for (var item in responseModel.data) {
        subCats.add(SubCategoryModel.fromJson(item));
      }
      
      if (GetStorage().read("subcats") == null) {
        GetStorage().write(
            'subcats',
            jsonEncode(subCats,
                toEncodable: (e) => (e as SubCategoryModel).toJson()));
      } else {
        List<dynamic> subcatslist = jsonDecode(
          GetStorage().read('subcats'),
          reviver: (key, value) {
            if (value is Map)
              return SubCategoryModel.fromJson(value);
            else
              return value;
          },
        );
        bool addedBefor = false;
        for (var item in subCats) {
          addedBefor = false;
          for (var item1 in subcatslist) {
            if (item1.name == item.name) {
              addedBefor = true;
              break;
            }
          }
          if (!addedBefor) subcatslist.add(item);
        }
        GetStorage().write(
            'subcats',
            jsonEncode(subcatslist,
                toEncodable: (e) => (e as SubCategoryModel).toJson()));
      }
      return subCats;
    }
    } catch (e) {
    }
    return [];
  }
}
