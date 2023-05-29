// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/GetXController/UserController.dart';
import 'package:web_application/Models/UserModel.dart';

import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';


// ignore: must_be_immutable
class EditProfilePage extends StatefulWidget {
  

  EditProfilePage({Key? key }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController firstNameController =  TextEditingController();
  TextEditingController usernameController =  TextEditingController();
  TextEditingController lastNameController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController oldPasswordController =  TextEditingController();
  TextEditingController newPasswordController =  TextEditingController();
  TextEditingController configNewPasswordController =
       TextEditingController();
  TextEditingController adressController =  TextEditingController();
  TextEditingController mobileController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    usernameController.text = MyConst.profilePageController.userModel.value.userName ?? "";
    firstNameController.text = MyConst.profilePageController.userModel.value.firstName ?? "";
    lastNameController.text = MyConst.profilePageController.userModel.value.lastName ?? "";
    emailController.text = MyConst.profilePageController.userModel.value.email ?? "";
    adressController.text = MyConst.profilePageController.userModel.value.adress ?? "";
    mobileController.text = MyConst.profilePageController.userModel.value.mobile ?? "";
    return Column(
      
      children: [
        
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: CircleAvatar(
                    maxRadius: 60,
                    backgroundColor: Theme.of(context).primaryColor,
                    // ignore: prefer_const_constructors
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MyText(
                content: "معلومات الملف الشخصي",
                size: 28,
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              
              Column(
                children: [
                  MyText(
                    content: "الاسم الأول",
                  ),
                  MyTextField(
                    
                    isEmail: true,
                    isPassword: false,
                    icon: Icons.person,
                    controller: firstNameController,
                  ),
                ],
              ),
              Column(
                children: [
                  MyText(
                    content: "الاسم الأخير",
                  ),
                  MyTextField(
                    hintText: MyConst.profilePageController.userModel.value.lastName!,
                    isEmail: true,
                    isPassword: false,
                    icon: Icons.person,
                    controller: lastNameController,
                  )
                ],
              ),
              
              Column(
                children: [
                  MyText(
                    content: "العنوان",
                  ),
                  MyTextField(
                    hintText: MyConst.profilePageController.userModel.value.adress!,
                    isEmail: true,
                    isPassword: false,
                    icon: Icons.location_on,
                    controller: adressController,
                  ),
                ],
              ),
              // Column(
              //   children: [
              //     MyText(
              //       content: "الموبايل",
              //     ),
              //     MyTextField(
              //       hintText: widget.userModel.mobile,
              //       isEmail: true,
              //       isPassword: false,
              //       icon: Icons.phone_android,
              //       controller: mobileController,
              //     ),
              //   ],
              // ),
              Column(
                children: [
                  MyText(
                    content: "كلمة المرور الجديدة",
                  ),
                  MyTextField(
                    hintText: "كلمة المرور الجديدة",
                    isEmail: false,
                    isPassword: true,
                    icon: Icons.lock_sharp,
                    controller: newPasswordController,
                  ),
                ],
              ),
              Column(
                children: [
                  MyText(
                    content: "تأكيد كلمة المرور الجديدة",
                  ),
                  MyTextField(
                    hintText: "تأكيد كلمة المرور الجديدة",
                    isEmail: false,
                    isPassword: true,
                    icon: Icons.lock_sharp,
                    controller: configNewPasswordController,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: blueColor,
                thickness: 1,
              ),
              Row(
                children: [
                  Spacer(),
                  Center(
                    child: Container(
                      
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: linearGradient),
                      
                      child: InkWell(
                        onTap: () {
                          if (newPasswordController.text ==
                              configNewPasswordController.text) {
                            showAlertDialog(context, [
                              Center(
                                child: Text(
                                  "هل أنت متأكد؟؟",
                                  style: GoogleFonts.cairo(
                                      color: blueColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ], [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "إلغاء",
                                    style: GoogleFonts.cairo(
                                        color: blueColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextButton(
                                onPressed: () {
                                  UserGetXController userGetXController =
                                       MyConst.userGetXController;
                                  UserModel userModel = MyConst
                                      .profilePageController.userModel.value;
                                  userModel.firstName =
                                      firstNameController.text ==
                                              userModel.firstName
                                          ? userModel.firstName
                                          : firstNameController.text;
                                  userModel.lastName =
                                      lastNameController.text ==
                                              userModel.lastName
                                          ? userModel.lastName
                                          : lastNameController.text;
                                  userModel.adress = adressController.text ==
                                          userModel.adress
                                      ? userModel.adress
                                      : adressController.text;
                                  userModel.userName =
                                      usernameController.text ==
                                              userModel.userName
                                          ? userModel.userName
                                          : usernameController.text;

                                  userModel.password =
                                      newPasswordController.text.isEmpty
                                          ? ''
                                          : newPasswordController.text;

                                  userGetXController.updateUser(userModel);
                                  Get.to(() => Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ));

                                },
                                child: Text(
                                  "تأكيد",
                                  style: GoogleFonts.cairo(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ]);
                          } else {
                            showAlertDialog(context, [
                              Center(
                                child: Text(
                                  "كلمات المرور غير متطابقة",
                                  style: GoogleFonts.cairo(
                                      color: blueColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ], [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "إلغاء",
                                    style: GoogleFonts.cairo(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.save, color: Colors.white),
                              SizedBox(width: 20,),
                              MyText(
                                content: "حفظ التعديلات",
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer()
                ],
              ),
              Divider(
                color: blueColor,
                thickness: 1,
              ),
              SizedBox(
                height: 180,
              )
            ],
          ),
        )
      ],
    );
  }
}
