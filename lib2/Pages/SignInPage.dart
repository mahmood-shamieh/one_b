// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';

import 'package:web_application/GetXController/UserController.dart';

import 'package:web_application/widgets/AppBar.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';
import 'package:web_application/widgets/StyleWidget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isSignupScreen = false;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: MyAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: double.infinity,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              MyConst.styleWidgetController
                                  .NavigateToSignInOrSignUpPage(false);
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: InkWell(
                              onTap: () {
                                MyConst.styleWidgetController
                                    .NavigateToSignInOrSignUpPage(false);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "إنشاء حساب",
                                    style: GoogleFonts.cairo(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen
                                            ? Theme.of(context).primaryColor
                                            : greenColor),
                                  ),
                                  if (isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: greenColor,
                                    )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              MyConst.styleWidgetController
                                  .NavigateToSignInOrSignUpPage(true);
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "تسجيل الدخول",
                                  style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen
                                          ? Theme.of(context).primaryColor
                                          : greenColor),
                                ),
                                if (!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: greenColor,
                                  )
                              ],
                            ),
                          )
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                              icon: Icons.email,
                              isEmail: true,
                              hintText: "رقم الهاتف",
                              isPassword: false,
                              controller: emailController,
                            ),
                            MyTextField(
                              icon: Icons.lock_sharp,
                              isPassword: true,
                              hintText: "كلمة المرور",
                              isEmail: false,
                              controller: passwordController,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: linearGradientbox,
                                  child: InkWell(
                                      onTap: () {
                                        if (emailController.text.length == 0)
                                          // ignore: curly_braces_in_flow_control_structures
                                          Get.defaultDialog(
                                              actions: [
                                                ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent)),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: MyText(
                                          content: "تم",
                                        ))
                                              ],
                                              title: "تنبيه",
                                              content: Center(
                                                  child: MyText(
                                                content:
                                                    "الرجاء ادخال رقم الهاتف",
                                              )));
                                        else {
                                          Get.to(() => Container(
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                color: Colors.white,
                                              ));
                                              MyConst.userGetXController.ressetPassword(emailController.text);
                                        }
                                      },
                                      child: FittedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MyText(
                                            content: "هل نسيت كلمة المرور ؟",
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: linearGradient,
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(18)),
                              child: TextButton(
                                  onPressed: () {
                                    Get.to(() => StyleWidget());
                                  },
                                  child: Text(
                                    "إنقر هنا للدخول كزائر",
                                    style: GoogleFonts.cairo(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (emailController.text.length != 0 &&
                                passwordController.text.length != 0) {
                              UserGetXController userGetXController =
                                  UserGetXController();
                              userGetXController.signIn({
                                'email_phone': emailController.text,
                                'password': passwordController.text
                              });
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              Get.defaultDialog(
                                  title: "تنبيه",
                                  content: MyText(
                                    content: "الرجاء ملئ كافة البيانات",
                                    size: 16,
                                    bold: false,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent)),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: MyText(
                                          content: "تم",
                                        ))
                                  ]);
                            }
                          },
                          child: Container(
                            height: 90,
                            width: 90,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Colors.green[100]!
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.3),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, 1))
                                  ]),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
