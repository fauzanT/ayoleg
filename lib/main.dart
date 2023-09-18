
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/home.dart';
import 'package:ayoleg/login.dart';
import 'package:ayoleg/splash/splash.dart';
import 'package:ayoleg/suara/suaradetail.dart';
import 'package:ayoleg/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // ignore: avoid_print
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() async {


  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'Ayocaleg',
      'Ayocaleg Notification',
      sound: RawResourceAndroidNotificationSound('zz'),
      playSound: true,
      importance: Importance.max,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String deviceTokenToSendPushNotification = "";



  @override
  void initState() {
    requestNotificationPermissions();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      // ignore: unnecessary_null_comparison
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel!.id, channel!.name,
                icon: 'mipmap/ic_launcher',
                sound: RawResourceAndroidNotificationSound('zz'),
                playSound: true,
                importance: Importance.max,
                enableLights: true,
                priority: Priority.max),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification Clicked');
    });
    super.initState();
  }
  Future<void> requestNotificationPermissions() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      // Notification permissions granted
    } else if (status.isDenied) {
      // Notification permissions denied
    } else if (status.isPermanentlyDenied) {
      // Notification permissions permanently denied, open app settings
      await openAppSettings();
    }
  }

  Future<void> getDeviceTokenToSendNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
    prefs.setString('token_notif', deviceTokenToSendPushNotification);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    getDeviceTokenToSendNotification();
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Ayocaleg',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/NavBar': (BuildContext context) => const CustomNavBar(),
          '/HomePage': (BuildContext context) => const HomePage(),
          '/WelcomePage': (BuildContext context) => const WelcomePage(),
          '/navbarrelawan': (BuildContext context) => const CustomNavRelawanBar(),
          '/login': (BuildContext context) => const LoginPage(),
          '/suaradetail': (BuildContext context) => const SuaraDetailpage(),


        });


  }



}


//
// import 'package:ayoleg/component/navbar/navbar.dart';
// import 'package:ayoleg/component/navbar/navbarpendukung.dart';
// import 'package:ayoleg/component/navbar/navbarrelawan.dart';
// import 'package:ayoleg/home.dart';
// import 'package:ayoleg/login.dart';
// import 'package:ayoleg/splash/splash.dart';
// import 'package:ayoleg/welcome/welcome.dart';
// import 'package:flutter/material.dart';
//
//
// void main() async {
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   @override
//   void initState() {
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'AyoCaleg',
//         theme: ThemeData(
//           primarySwatch: Colors.grey,
//         ),
//         home: SplashScreen(),
//         routes: <String, WidgetBuilder>{
//           '/NavBar': (BuildContext context) => const CustomNavBar(),
//           '/HomePage': (BuildContext context) => const HomePage(),
//           '/WelcomePage': (BuildContext context) => const WelcomePage(),
//           '/navbarrelawan': (BuildContext context) => const CustomNavRelawanBar(),
//           '/navbarpendukung': (BuildContext context) => const CustomNavPendukungBar(),
//           '/login': (BuildContext context) => const LoginPage(),
//
//
//         });
//   }
// }