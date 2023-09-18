import 'dart:convert';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/camera.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/login.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

// import 'package:emailjs/emailjs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';


class PreviewktpPage extends StatefulWidget {
  const PreviewktpPage({Key? key}) : super(key: key);

  @override
  State<PreviewktpPage> createState() => _PreviewktpPage();
}

class _PreviewktpPage extends State<PreviewktpPage> {
  late final XFile picture;

  late SharedPreferences sharedPrefs;

  String fotousr = "";

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      fotousr = prefs.getString('fotoktpregister')!;
    });
    super.initState();
  }

  bool isLoading = false;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64.decode(fotousr);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Foto KTP'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                gradient7,
                gradient5,
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          bytes.isEmpty
              ? Container(
            width: 100,
            height: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/images/gambarnon.png",
                  fit: BoxFit.cover,
                )),
          )
              : Image.memory(
            bytes,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),

          // Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          // const SizedBox(height: 24),
          FadeInUp(
            duration: Duration(milliseconds: 1300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: greenPrimary,
                  onPrimary: whitePrimary,
                  shadowColor: shadowColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(130, 50), //////// HERE
                ),
                onPressed: () {
                  // setState(() async {
                  //   isLoading = true;
                  //
                  //   await availableCameras().then((value) => Navigator.push(context,
                  //       MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
                  // });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: whitePrimary,
                      ),
                    )
                        : const Text(
                      'Lanjut Foto Wajah',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: whitePrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Text(picture.name)
        ]),
      ),
    );
  }


}
