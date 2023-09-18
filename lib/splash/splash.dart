// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
const _url =
    'https://play.google.com/store/apps/details?id=com.ayolegid';
class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    _startUpdateService();

    super.initState();
    getStringValuesSF();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('token');
    if (stringValue == "admin") {
      Timer(Duration(seconds: 3),
              () => Navigator.pushReplacementNamed(context, '/NavBar'));

    } else if(stringValue == "relawan") {
      Timer(Duration(seconds: 3),
              () => Navigator.pushReplacementNamed(context, '/navbarrelawan'));
    }else if(stringValue == "Pendukung") {
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, '/navbarpendukung'));
    }else{
      Timer(Duration(seconds: 3),
              () => Navigator.pushReplacementNamed(context, '/WelcomePage'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Center(
                child:Container(
                        width: 300,
                        height: 150,
                        child: Image.asset("assets/images/logocaleg4.jpg"),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // versionDialog(String url) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) => WillPopScope(
  //         onWillPop: () async => false,
  //         child: AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20)),
  //           content: const Text(
  //             "Sudah Tersedia Versi Aplikasi AyoCaleg Terbaru, Segera Update Aplikasi Anda",
  //             style: TextStyle(fontFamily: 'poppins', fontSize: 15),
  //           ),
  //           actions: <Widget>[
  //             // ignore: deprecated_member_use
  //             TextButton(
  //               child: const Text('Update',
  //                   style: TextStyle(fontFamily: 'poppins', fontSize: 15)),
  //               onPressed: () => launch(url),
  //             ),
  //             // ignore: deprecated_member_use
  //           ],
  //         ),
  //       ));
  // }
  Future<void> _startUpdateService() async {
    try {
      //This feature is only available on the Android OS
      //As specified above.

      if (Platform.isAndroid) {
        //Here, the user is asked and could decide if they want to start the update or ignore it
        await checkForFlexibleUpdate();

        //After this is done, we'll show a dialog telling the user
        //that the update is done, and ask them to complete it.
        //For this case, we'll use a simple dialog to demonstrate this
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //       content: Text("Update Sedang Berjalan.."),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             completeFlexibleUpdate();
        //           },
        //           child: Text("Selesai"),
        //         )
        //       ]
        //   ),
        // );

      }
    } catch (e) {
      //The user choosing to ignore the flexible update should trigger an exception
      //Your preferred method of showing the user erros
    }
  }

  Future<void> checkForFlexibleUpdate() async {
    //Here, you'll show the user a dialog asking if the user is wiilling
    //to update your app while using it

    try {
      //We'll check if the there is an actual update
      final AppUpdateInfo? info = await _checkForUpdate();

      //Because info could be null. If info is null, we can safely assume that there is no pending
      //update

      if (info != null) {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          //The user starts the flexible updates, when it's done we'll ask the user if they want to go ahead with the update or not
          await InAppUpdate.performImmediateUpdate();


        }
      }
    } catch (e) {
      throw e.toString();
    }
  }
  Future<void> completeFlexibleUpdate() async {
    //Here, the user has downloaded and queued up your new update, it's time to
    //actually install it!

    try {
      await InAppUpdate.completeFlexibleUpdate();
    } catch (e) {
      throw e.toString();
    }
  }
  Future<AppUpdateInfo?> _checkForUpdate() async {
    try {
      return await InAppUpdate.checkForUpdate();
    } catch (e) {
      //Throwing the exception so we can catch it on our UI layer
      throw e.toString();
    }
  }

}

