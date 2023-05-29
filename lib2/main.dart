// ignore_for_file: empty_catches, use_key_in_widget_constructors, annotate_overrides, avoid_print, prefer_const_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, prefer_function_declarations_over_variables, avoid_unnecessary_containers

import 'dart:io';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/Controller/UserController.dart';
import 'package:web_application/DefaultFirebaseOptions.dart';
import 'package:web_application/Models/UserModel.dart';
import 'package:web_application/Pages/HomePage.dart';

import 'package:web_application/widgets/StyleWidget.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title

    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseMessaging.instance.subscribeToTopic("all");
  if (GetStorage().read("userModel") != null)
    FirebaseMessaging.instance.subscribeToTopic(
        UserModel.fromJson(GetStorage().read("userModel")).level!);
  // print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  // GetStorage().erase();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  try {
    FirebaseMessaging.instance.subscribeToTopic(
        (Platform.isAndroid ? "" : "ios_").toString() + "all");
    if (GetStorage().read("userModel") != null) {
      FirebaseMessaging.instance.subscribeToTopic(
          (Platform.isAndroid ? "" : "ios_").toString() +
              UserModel.fromJson(GetStorage().read("userModel")).level!);
    }
  } catch (e) {
    print("error in topic subscribe");
  }
  if (GetStorage().read("userModel") != null) {
    UserModel user = UserModel.fromJson(GetStorage().read("userModel"));
    if (user.id != null) {
      // ignore: non_constant_identifier_names
      String FCM_token = "";
      await FirebaseMessaging.instance.getToken().then((value) {
        FCM_token = value!;
      });
      // print(FCM_token);
      user.FCM_token = FCM_token;
      user.password = "";
      // print("------>" + FCM_token.toString());
      UserController userController = UserController();
      try {
        userController.updateUser(user);
      } catch (e) {}
    }
  }
  // ignore: unused_local_variable
  runApp(MyApp());
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

class MyApp extends StatefulWidget {
  static String hostName = "https://khodoati.com/mybill4/mybill";
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    try {
      FirebaseMessaging.instance.subscribeToTopic(
          (Platform.isAndroid ? "" : "ios_").toString() + "all");
      if (GetStorage().read("userModel") != null) {
        FirebaseMessaging.instance.subscribeToTopic(
            (Platform.isAndroid ? "" : "ios_").toString() +
                UserModel.fromJson(GetStorage().read("userModel")).level!);
      }
    } catch (e) {
      print("error in topic subscribe");
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id, channel.name,
                color: Colors.amber,
                playSound: true,
                channelShowBadge: true,
                fullScreenIntent: true,
                importance: Importance.high,
                priority: Priority.high,
                // ongoing: true,
                styleInformation: BigTextStyleInformation(''),
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GetStorage().read("logedIn") != null && GetStorage().read("logedIn")) {
      try {
        MyConst.profilePageController.getUserInformations();
      } catch (e) {}
    } else {
      GetStorage().write("logedIn", false);
      MyConst.logedInController.logedIn.value = false;
      MyConst.profilePageController.isLoding.value = false;
    }

    return GetMaterialApp(
        // ignore: prefer_const_literals_to_create_immutables
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // ignore: prefer_const_literals_to_create_immutables
        supportedLocales: [
          const Locale('ar'),
        ],
        theme: ThemeData(
          cardColor: Colors.grey[200],
          primaryColor: blueColor,
          buttonTheme: ButtonThemeData(
            buttonColor: blueColor,
          ),
          iconTheme: IconThemeData(color: blueColor),
          textTheme: TextTheme(
            bodyText1: TextStyle(color: blueColor),
            headline5: TextStyle(color: blueColor),
            headline6: TextStyle(color: blueColor),
            headline4: TextStyle(color: blueColor),
            headline3: TextStyle(color: blueColor),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'فواتيري',
        home: SplashScreen());
  }
}

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function duringSplash = () {
      int a = 123 + 23;

      if (a > 100)
        return 1;
      else
        return 2;
    };
    Map<int, Widget> op = {1: HomePage(), 2: SplashScreen()};
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: AnimatedSplash(
            imagePath: 'assets/logo.png',
            home: StyleWidget(),
            customFunction: duringSplash,
            duration: 2500,
            type: AnimatedSplashType.StaticDuration,
            outputAndHome: op,
          ),
        ),
      ),
    );
  }
}
