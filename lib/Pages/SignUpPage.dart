// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, prefer_is_empty

import 'package:flutter/material.dart';

import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/Controller/UserController.dart';
import 'package:web_application/GetXController/UserController.dart';
import 'package:web_application/Models/UserModel.dart';


import 'package:web_application/widgets/AppBar.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool privarcyReaded = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController configNewPasswordController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  UserController userController = UserController();
  bool isMale = true;
  bool isSignupScreen = true;

  @override
  Widget build(BuildContext context) {
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
                  // ignore: prefer_const_constructors
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
                          GestureDetector(
                            onTap: () {
                              MyConst.styleWidgetController
                                  .NavigateToSignInOrSignUpPage(true);
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: InkWell(
                              onTap: () {
                                MyConst.styleWidgetController
                                    .NavigateToSignInOrSignUpPage(true);
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
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            
                            MyTextField(
                              icon: Icons.person,
                              hintText: "الاسم الكامل",
                              isEmail: false,
                              isPassword: false,
                              controller: firstNameController,
                            ),
                            // MyTextField(
                            //   icon: Icons.person,
                            //   hintText: "اسم المركز",
                            //   isEmail: false,
                            //   isPassword: false,
                            //   controller: lastNameController,
                            // ),
                            
                            MyTextField(
                              icon: Icons.phone_android_sharp,
                              hintText: "رقم الموبايل",
                              isEmail: true,
                              isPassword: false,
                              controller: mobileController,
                              keyboardType: TextInputType.number,
                            ),
                            MyTextField(
                              icon: Icons.location_city,
                              hintText: "العنوان",
                              isEmail: true,
                              isPassword: false,
                              controller: adressController,
                            ),
                            MyTextField(
                              icon: Icons.lock_sharp,
                              hintText: "كلمة المرور",
                              isEmail: false,
                              isPassword: true,
                              controller: newPasswordController,
                            ),
                            MyTextField(
                              icon: Icons.lock_sharp,
                              hintText: "تأكيد كلمة المرور",
                              isEmail: false,
                              isPassword: true,
                              controller: configNewPasswordController,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Checkbox(
                                value: privarcyReaded,
                                onChanged: (value) {
                                  setState(() {
                                    privarcyReaded = value!;
                                  });
                                }),
                            Container(
                              width: MediaQuery.of(context).size.width - 110,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: ListView(
                                            children: [
                                              MyText(
                                                color: blueColor,
                                                content: "سياسة الخصوصية",
                                                size: 20,
                                                bold: true,
                                              ),
                                              Divider(
                                                color: blueColor,
                                              ),
                                              MyText(
                                                color: blueColor,
                                                content:
                                                    // ignore: unnecessary_string_escapes
                                                    "مُنشئ سياسة الخصوصية عبر الإنترنت لموقع الويب أو المدونة أو التجارة الإلكترونية أو التطبيق \ n مُنشئ سياسة الخصوصية عبر الإنترنت لموقع الويب أو المدونة أو متجر التجارة الإلكترونية أو التطبيق \ n هل لديك موقع ويب أو مدونة أو تطبيق على الإنترنت؟ إذا كانت الإجابة بنعم ، فأنت بحاجة ماسة إلى سياسة خصوصية لها. \ n اليوم ، الخصوصية عبر الإنترنت أكثر أهمية من أي وقت مضى. يجب على الجميع الاهتمام بالخصوصية والامتثال لقوانين الخصوصية في السلطة القضائية المعنية. \ n سنت العديد من البلدان قوانين خصوصية المعلومات التي يتعين عليك اتباعها إذا قمت بجمع معلومات حول المستخدمين لديك. من المحتمل أن يقوم موقع الويب أو تطبيق الجوال الخاص بك بجمع ، على الأقل ، أسماء المستخدمين وعناوين البريد الإلكتروني الخاصة بهم. \ n غالبًا ما تطلب الخدمات عبر الإنترنت مزيدًا من المعلومات مثل رقم الهاتف ، والعنوان السكني ، والموقع ، والتفاصيل المالية ، وما إلى ذلك. \ n قد تكون كذلك يسأل ، ما هي سياسة الخصوصية؟ \ n منشئ نهج الخصوصية عبر الإنترنت لموقع الويب أو المدونة أو التجارة الإلكترونية أو التطبيق \ n منشئ سياسة الخصوصية عبر الإنترنت لموقع الويب أو المدونة أو متجر التجارة الإلكترونية أو التطبيق \ n هل لديك موقع ويب أو مدونة أو تطبيق على الإنترنت؟ إذا كانت الإجابة بنعم ، فأنت بحاجة ماسة إلى سياسة خصوصية لها. \ n اليوم ، الخصوصية عبر الإنترنت أكثر أهمية من أي وقت مضى. يجب على الجميع الاهتمام بالخصوصية والامتثال لقوانين الخصوصية في السلطة القضائية المعنية. \ n سنت العديد من البلدان قوانين خصوصية المعلومات التي يتعين عليك اتباعها إذا قمت بجمع معلومات حول المستخدمين لديك. من المحتمل أن يقوم موقع الويب أو تطبيق الجوال الخاص بك بجمع ، على الأقل ، أسماء المستخدمين وعناوين البريد الإلكتروني الخاصة بهم. \ n غالبًا ما تطلب الخدمات عبر الإنترنت مزيدًا من المعلومات مثل رقم الهاتف ، والعنوان السكني ، والموقع ، والتفاصيل المالية ، وما إلى ذلك. \ n قد تكون كذلك يسأل ، ما هي سياسة الخصوصية؟",
                                                size: 16,
                                                bold: false,
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .transparent)),
                                                onPressed: () {
                                                  setState(() {
                                                    privarcyReaded = true;
                                                  });
                                                  Get.back();
                                                },
                                                child: MyText(
                                                  content: "الموافقة",
                                                  bold: true,
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .transparent)),
                                                onPressed: () {
                                                  Get.back();
                                                  setState(() {
                                                    privarcyReaded = false;
                                                  });
                                                },
                                                child: MyText(
                                                  content: "الخروج",
                                                  bold: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                                },
                                child: MyText(
                                  content:
                                      "لقد قرأت بنود الخصوصية وأوافق عليها",
                                  bold: true,
                                  color: blueColor,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (firstNameController.text.length != 0 &&
                              // lastNameController.text.length != 0 &&
                              mobileController.text.length != 0 &&
                              newPasswordController.text.length != 0 &&
                              adressController.text.length != 0 &&
                              configNewPasswordController.text.length != 0) {
                                if(configNewPasswordController.text.length < 8 || newPasswordController.text.length <8){
                                  Get.defaultDialog(
                                  content: MyText(
                                    size: 16,
                                    bold: false,
                                    content:
                                        "يجب أن تكون كلمة المرور أكثر من ثمانية أرقام أو أحرف",
                                  ),
                                  title: "تنبيه",
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
                            else if (!privarcyReaded) {
                              Get.defaultDialog(
                                  content: MyText(
                                    size: 16,
                                    bold: false,
                                    content:
                                        "يجب قراءة سياسة الخصوصية والموافقة عليها",
                                  ),
                                  title: "تنبيه",
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
                            } else if (newPasswordController.text ==
                                configNewPasswordController.text) {
                              UserGetXController userGetXController =
                                  UserGetXController();
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
                              userGetXController.signUp(UserModel(
                                  userName: "",
                                  email: "",
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  mobile: mobileController.text,
                                  password: newPasswordController.text,
                                  adress: adressController.text));
                            } else {
                              Get.defaultDialog(
                                  title: "تنبيه",
                                  content: MyText(
                                    size: 16,
                                    bold: false,
                                    content: "كلمات المرور غير متطابقة",
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
                          } else {
                            Get.defaultDialog(
                                title: "تنبيه",
                                content: MyText(
                                  size: 16,
                                  bold: false,
                                  content: "الرجاء ملئ كافة البيانات الضرورية",
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
                        child: Center(
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
