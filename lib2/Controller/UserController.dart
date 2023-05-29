// ignore_for_file: file_names, prefer_typing_uninitialized_variables, empty_catches, unnecessary_null_in_if_null_operators, avoid_print, unnecessary_new, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/Controller/CategoryController.dart';

import 'package:web_application/Models/CodeModel.dart';
import 'package:web_application/Models/NotificationModel.dart';
import 'package:web_application/Models/OrderModel.dart';
import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Models/UserModel.dart';

class UserController {
  static bool? logedIn;
  var client = CategoryController.client;
  String ip = CategoryController.ip;

  Future<Map<String, dynamic>> addUser(UserModel userModel) async {
    String path = ip + '/api/register.php';
    var response;
    // ignore: avoid_init_to_null
    UserModel? userModel1 = null;
    try {
    response = await client.post(Uri.parse(path),
        body: json.encode({
          'first_name': userModel.firstName,
          'last_name': userModel.lastName,
          'username': userModel.userName,
          'email': userModel.email,
          'phone': userModel.mobile,
          'password': userModel.password,
          'address': userModel.adress
        }));
    if (ResponseModel.fromJson(json.decode(response.body)).status!) {
      GetStorage().write("userModel",
          ResponseModel.fromJson(json.decode(response.body)).data[0]);
      if (GetStorage().read('userModel') is UserModel)
        userModel1 = (GetStorage().read('userModel') as UserModel);
      else
        userModel1 = UserModel.fromJson(GetStorage().read('userModel'));
      MyConst.profilePageController.userModel.value = userModel1;
      MyConst.profilePageController.getUserInformations();
      // GetStorage().write("logedIn", userModel.verified == '1' ? true : false);
      MyConst.logedInController.myUpdate(userModel.verified == '1' ? true : false);
      MyConst.profilePageController.isLoding.value = false;
      MyConst.profilePageController.userModel.value = UserModel.fromJson(
          ResponseModel.fromJson(json.decode(response.body)).data[0]);
      if (GetStorage().read('userModel') is UserModel)
        userModel1 = (GetStorage().read('userModel') as UserModel);
      else
        userModel1 = UserModel.fromJson(GetStorage().read('userModel'));
    }
    return {
      'response': ResponseModel.fromJson(json.decode(response.body)),
      'active': userModel1 == null ? "0" : userModel1.verified
    };
    } catch (e) {}
    return {
      'response': ResponseModel.fromJson({
        "status": false,
        "msg": "لا يوجد اتصال بالإنترنت يرجى التأكد من اتصالك وإعادة المحاولة",
        "token": "",
        "data": ""
      }),
      'active': userModel1 == null ? "0" : userModel1.verified
    };
  }

  Future<Map> signIn(Map map) async {
    String path = ip + "/api/login.php";
    // ignore: non_constant_identifier_names
    String FCM_token = "";
    // await FirebaseMessaging.instance.getToken().then((value) {
    //   FCM_token = value!;
    // });
    map["FCM_token"] = FCM_token;

    var response;
    try {
      response = await client.post(Uri.parse(path), body: json.encode(map));
      print(map);
      print(response.body);
      ResponseModel responseModel =
          ResponseModel.fromJson(json.decode(response.body));
      MyConst.profilePageController.userModel.value.token = responseModel.token;
      if ((responseModel.data).length != 0) {
        GetStorage().write("logedIn", responseModel.status);
        GetStorage().write("token", responseModel.token.toString());
        GetStorage().write(
            "userModel",
            UserModel.fromJson(responseModel.data is List
                ? responseModel.data[0]
                : responseModel.data));
        MyConst.logedInController.myUpdate(true);
        MyConst.profilePageController.isLoding.value = false;
        MyConst.profilePageController.userModel.value = UserModel.fromJson(
            responseModel.data is List
                ? responseModel.data[0]
                : responseModel.data);
      }
      return {
        'responseModel': ResponseModel.fromJson(json.decode(response.body)),
        'needActive':
            responseModel.data.length != 0 && responseModel.status == false
                ? true
                : false,
        'active': responseModel.data.isNotEmpty && responseModel.status == true
            ? true
            : false
      };
    } catch (e) {}
    return {
      'responseModel': ResponseModel.fromJson({
        "status": false,
        "msg": "لا يوجد اتصال بالإنترنت يرجى التأكد من اتصالك وإعادة المحاولة",
        "token": "",
        "data": ""
      }),
      'active': false,
      'needActive': false,
    };
  }

  Future<ResponseModel> ressetPassword(String mobile) async {
    String path = ip + "/api/reset_password_request.php";
    var response;
    try {
      response = await client.post(Uri.parse(path),
          body: json.encode({'email_phone': mobile}));
      return ResponseModel.fromJson(json.decode(response.body));
    } catch (e) {}
    return ResponseModel.fromJson({
      "status": false,
      "msg": "لا يوجد اتصال بالإنترنت يرجى التأكد من اتصالك وإعادة المحاولة",
      "token": "",
      "data": ""
    });
  }

  Future<ResponseModel> signOut(Map map) async {
    try {
      GetStorage().erase();
      GetStorage().write("logedIn", false);
      MyConst.profilePageController.userModel.value.canCharge = "0";
      MyConst.logedInController.myUpdate(false);
    } catch (e) {}
    return ResponseModel.fromJson({
      "status": true,
      "msg": "تم تسجيل الخروج بنجاح",
      "token": "",
      "data": ""
    });
  }

  Future<List<OrderModel>?> getPymentHistory() async {
    String path = ip + "/api/get_user_orders.php";
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
    List<OrderModel>? orders = null;
    try {
      response = await client
          .post(Uri.parse(path), body: json.encode({'user_id': id}), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      responseModel = ResponseModel.fromJson(json.decode(response.body));
      if (responseModel.status!) {
        orders = [];
        for (var order in responseModel.data) {
          if (order['type'] == '1') {
            orders.add(new OrderModel(
              catName: order['cat_name'],
                inputs: order['inputs'],
                id: order['id'],
                title: order['arabic_name'],
                bill: order['bill'] ?? "لا يوجد",
                cost: order['cost'] ?? "لا يوجد",
                content: order['result'] ?? "لا يوجد نتيجة بعد",
                dateTime: order['created_date'] != null
                    ? DateTime.parse(order['created_date'])
                    : null,
                finishDate: order['finished_date'] != null
                    ? DateTime.parse(order['finished_date'])
                    : null,
                finished: order['finished'] ?? "لا يوجد"));
          }
        }
      }
    } catch (e) {}
    if (orders != null)
      orders.sort((a, b) {
        return a.dateTime!.compareTo(b.dateTime!);
      });
    return orders;
  }

  Future<List<OrderModel>?> getOrderHistory() async {
    String path = ip + "/api/get_user_orders.php";
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
    List<OrderModel>? orders = null;
    // try {
    response = await client
        .post(Uri.parse(path), body: json.encode({'user_id': id}), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    responseModel = ResponseModel.fromJson(json.decode(response.body));
    if (responseModel.status!) {
      print(responseModel.data);
      orders = [];
      for (var order in responseModel.data) {
        if (order['type'] == '0') {
          orders.add(new OrderModel(
            catName: order['cat_name'],
              inputs: order['inputs'],
              id: order['id'],
              subcatsId: order['subcat_id'],
              askOrderSent: order['ask_order_sent'] == "1" ? true : false,
              title: order['arabic_name'],
              bill: order['bill'] ?? "لا يوجد",
              cost: order['cost'] ?? "لا يوجد",
              content: order['result'] ?? "لا يوجد نتيجة بعد",
              dateTime: order['created_date'] != null
                  ? DateTime.parse(order['created_date'])
                  : null,
              finishDate: order['finished_date'] != null
                  ? DateTime.parse(order['finished_date'])
                  : null,
              finished: order['finished'] ?? "لا يوجد"));
        }
      }
    }

    return orders;
  }

  Future<ResponseModel> updateUser(UserModel userModel) async {
    String path = ip + "/api/user_update.php";
    var token = '';
    if (GetStorage().read('userModel') is UserModel)
      token = (GetStorage().read('userModel') as UserModel).token ?? "";
    else
      token = UserModel.fromJson(GetStorage().read('userModel')).token ?? "";
    Map map = {
      'user_id': userModel.id,
      'first_name': userModel.firstName,
      'last_name': userModel.lastName,
      'username': userModel.userName,
      'address': userModel.adress,
      'password': userModel.password,
      'FCM_token': userModel.FCM_token
    };
    var response;
    try {
      response =
          await client.post(Uri.parse(path), body: json.encode(map), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      ResponseModel responseModel =
          ResponseModel.fromJson(json.decode(response.body));
      if (responseModel.status!) {
        GetStorage().write("userModel", userModel.toJson());
        MyConst.logedInController.myUpdate(true);
        MyConst.profilePageController.isLoding.value = false;
        MyConst.profilePageController.userModel.value =
            UserModel.fromJson(responseModel.data);
      }
      return ResponseModel.fromJson(json.decode(response.body));
    } catch (e) {}
    return ResponseModel.fromJson({
      "status": false,
      "msg": "لا يوجد اتصال بالإنترنت يرجى التأكد من اتصالك وإعادة المحاولة",
      "token": "",
      "data": ""
    });
  }

  Future<ResponseModel> getUserInfo() async {
    String path = ip + "/api/user_info.php";
    var token = '';
    if (GetStorage().read('userModel') is UserModel)
      token = GetStorage().read('userModel').token;
    else
      token = UserModel.fromJson(GetStorage().read('userModel')).token ?? "";
    var id = '';
    if (GetStorage().read('userModel') is UserModel)
      id = (GetStorage().read('userModel') as UserModel).id ?? "";
    else
      id = UserModel.fromJson(GetStorage().read('userModel')).id ?? "";
    Map map = {'user_id': id};
    var response;
    ResponseModel responseModel;
    try {
      response =
          await client.post(Uri.parse(path), body: json.encode(map), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      responseModel = ResponseModel.fromJson(json.decode(response.body));
      UserModel userModel = UserModel.fromJson(responseModel.data[0] ?? null);
      userModel.token = responseModel.token;
      if (response.statusCode == 200) {
        GetStorage().write("userModel", responseModel.data[0]);
        GetStorage().write("token", responseModel.token.toString());
        MyConst.logedInController.myUpdate(true);
        MyConst.profilePageController.isLoding.value = false;
        MyConst.profilePageController.userModel.value =
            UserModel.fromJson(responseModel.data[0]);
        return ResponseModel.fromJson(json.decode(response.body));
      }
    } catch (e) {}
    return ResponseModel.fromJson({
      "status": false,
      "msg": "لا يوجد اتصال بالإنترنت يرجى التأكد من اتصالك وإعادة المحاولة",
      "token": "",
      "data": ""
    });
  }

  Future<ResponseModel> chargeAccount(String code) async {
    String path = ip + "/api/charge.php";
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
    try {
      response = await client.post(Uri.parse(path),
          body: json.encode({'user_id': id, 'code': code}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      ResponseModel responseModel =
          ResponseModel.fromJson(json.decode(response.body));
      if (responseModel.status!) {
        MyConst.profilePageController.getUserInformations();
      }
      return responseModel;
    } catch (e) {}
    return ResponseModel.fromJson({
      "status": false,
      "msg": "لا يوجد اتصال بالإنترنت يرجى التأكد من اتصالك وإعادة المحاولة",
      "token": "",
      "data": ""
    });
  }

  Future<List?> getUserNotification() async {
    String path = ip + "/api/get_users_notifications.php";
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
    List<NotificationModel> notifications = [];
    try {
      response = await client.post(Uri.parse(path),
          body: json.encode({
            'user_id': id,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      ResponseModel responseModel =
          ResponseModel.fromJson(json.decode(response.body));
      if (responseModel.status!) {
        for (var item in responseModel.data) {
          notifications.add(NotificationModel.fromMap(item));
        }
      }
      return notifications;
    } catch (e) {
      return null;
    }
  }

  Future<bool> canGenerateCode() async {
    String path = ip + '/api/user_generate_code.php';
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
    try {
      response = await client
          .post(Uri.parse(path), body: json.encode({'user_id': id}), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      return ResponseModel.fromJson(json.decode(response.body)).status!;
    } catch (e) {}
    return false;
  }

  Future<ResponseModel> generateCode(String amount) async {
    String path = ip + '/api/user_generate_code.php';
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
    try {
      response = await client.post(Uri.parse(path),
          body: json.encode({'user_id': id, 'amount': amount}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      ResponseModel responseModel =
          ResponseModel.fromJson(json.decode(response.body));
      if (responseModel.status!) {
        int value =
            (int.parse(MyConst.profilePageController.userModel.value.balance!) -
                int.parse(amount));
        MyConst.profilePageController.userModel.value.balance =
            value.toString();
        GetStorage().write("userModel",
            MyConst.profilePageController.userModel.value.toJson());
      }

      return responseModel;
    } catch (e) {}
    return ResponseModel.fromJson({
      "status": false,
      "msg": "لا يوجد اتصال بالإنترنت يرجى التأكد من اتصالك وإعادة المحاولة",
      "token": "",
      "data": ""
    });
  }

  Future<Map> getAllCode() async {
    String path = ip + '/api/get_user_code_generate.php';
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

    // ignore: avoid_init_to_null, unused_local_variable
    List<CodeModel>? generatedCode = null;
    // ignore: avoid_init_to_null, unused_local_variable
    List<CodeModel>? consumedCode = null;
    try {
      response = await client.post(Uri.parse(path),
          body: json.encode({
            'user_id': id,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      responseModel = ResponseModel.fromJson(json.decode(response.body));
      if (responseModel.status!) {
        generatedCode = [];
        consumedCode = [];
        for (var item in responseModel.data) {
          if (CodeModel.fromJson(item).user_charge_code_id ==
              MyConst.profilePageController.userModel.value.id) {
            generatedCode.add(CodeModel.fromJson(item));
          } else if (CodeModel.fromJson(item).user_id ==
                  MyConst.profilePageController.userModel.value.id &&
              CodeModel.fromJson(item).checked == "1") {
            consumedCode.add(CodeModel.fromJson(item));
          }
        }
      }
    } catch (e) {}
    return {'generated': generatedCode, 'consumed': consumedCode};
  }

  Future<ResponseModel> verifyUser(String code) async {
    String path = ip + "/api/verify_code.php";
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

    // ignore: non_constant_identifier_names
    var response;
    try {
      response = await client.post(Uri.parse(path),
          body: json.encode({
            'id': id,
            'ver_code': code,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      ResponseModel responseModel =
          ResponseModel.fromJson(json.decode(response.body));
      UserModel userModel = UserModel.fromJson(responseModel.data ?? null);
      userModel.token = responseModel.token;
      GetStorage().write("logedIn", responseModel.status);
      return ResponseModel.fromJson(json.decode(response.body));
    } catch (e) {}
    return ResponseModel.fromJson({
      "status": false,
      "msg": "لا يوجد اتصال بالإنترنت يرجى التأكد من اتصالك وإعادة المحاولة",
      "token": "",
      "data": ""
    });
  }
}
