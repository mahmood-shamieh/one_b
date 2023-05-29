// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures, file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_application/Pages/Pages.dart';

class StyleWidgetController extends GetxController{
  var page = Pages.homePage.obs;
  var homePageOrPaymentPage = true.obs;
  var signInPageOrSignUpPage = true.obs;
  var profilePageOrEditProfilePageOrChargeAcount = "ProfilePage".obs;
  void NavigateToSignInOrSignUpPage(bool value){
    signInPageOrSignUpPage.value = value;
    update();
  }
  void NavigateProfilePageOrEdirOrCharge(String value){
    profilePageOrEditProfilePageOrChargeAcount.value = value;
    update();
  }
  void NavigateToMainPageOrPaymentPage(bool value){
    homePageOrPaymentPage.value = value;
    update();
  }

  void navigate(Pages distinationPage,BuildContext? context){
    if(distinationPage == Pages.profilePage)
    profilePageOrEditProfilePageOrChargeAcount.value = "ProfilePage";
    page.value = distinationPage;
    Navigator.pop(context!);
    update();
  }
}