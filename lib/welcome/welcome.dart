// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/login.dart';
import 'package:ayoleg/reveral.dart';
import 'package:ayoleg/team/relawan.dart';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
// import 'package:dart_appwrite/dart_appwrite.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late SharedPreferences sharedPrefs;
  String checkPrivasi = "";
  String deviceTokenToSendPushNotification = "";
  String Fotobanner1 = "";
  String Fotobanner2 = "";
  String Fotobanner3 = "";
  String Fotobanner4 = "";
  String Fotobanner5 = "";

  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  void initState() {
    // privacyPolicy();
    cekbanner();
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return

     WillPopScope(
         onWillPop: () => Future.value(false),
    child:
      Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: ImageSlideshow(
                        // width: size.width,
                        height: 560,
                        initialPage: 0,
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                // width: 100,
                                height: 300,
                                child:
                                Image.asset("assets/images/logocaleg4.jpg"
                                ,   height: 200,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   alignment: Alignment.topLeft,
                                    //   margin: const EdgeInsets.only(
                                    //       top: 20, bottom: 5, left: 20),
                                    //   child:    Text(
                                    //     'Ayocaleg',
                                    //     style: TextStyle(
                                    //       fontFamily: 'poppins',
                                    //       color: greenPrimary,
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 15,
                                    //     ),
                                    //   ),
                                    // ),

                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 5, left: 20, right: 20),
                                      child: Center(
                                        child: Text(
                                          '          Ayocaleg Aplikasi unggulan caleg 2024. Kelola kampanye dengan agenda, berita, dan kegiatan. Data swing voter, isu sosial, suara online, pemilih tetap terorganisir. Panduan strategi offline dan online. Menuju kemenangan !',
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              height: 2
                                              // letterSpacing: 2.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: 100,
                                height: 80,
                                child:
                                    Image.asset("assets/images/logocaleg4.jpg"),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // width: 100,
                                height: 300,
                                child: Image.asset(
                                  'assets/images/b1.png',
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(
                                    left: 20, top: 10, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Aplikasi Pemenangan Caleg 2024',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Selamat Datang Di AyoCaleg Mobile',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: 100,
                                height: 80,
                                child:
                                    Image.asset("assets/images/logocaleg4.jpg"),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // width: 100,
                                height: 300,
                                child: Image.asset(
                                  'assets/images/b2.png',
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 20, bottom: 20
                                    // bottom: 5,
                                    ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Kegiatan Kampanye Anda Dengan Mudah',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      '. Agenda Kampanye',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '. Berita Terkini',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '. Aktivitas Kampanye',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '. Kirim Pesan Masal',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: 100,
                                height: 80,
                                child:
                                    Image.asset("assets/images/logocaleg4.jpg"),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // width: 100,
                                height: 300,
                                child: Image.asset(
                                  'assets/images/b3.png',
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(
                                    left: 20, top: 10, bottom: 20
                                    // bottom: 5,
                                    ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Optimalkan Kampanye Dengan Data Akurat',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      '. Data Swing Voter',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '. Data Isu Sosial',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '. Data Suara Online',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '. Data Pemilih Tetap',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: 100,
                                height: 80,
                                child:
                                    Image.asset("assets/images/logocaleg4.jpg"),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // width: 100,
                                height: 300,
                                child: Image.asset(
                                  'assets/images/b4.png',
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 20, bottom: 20
                                    // bottom: 5,
                                    ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Panduan Kampanye Tersedia Di AyoCaleg',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      '. Strategi Kampanye Offline',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '. Strategi Kampanye Online',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '. Dan 100 Panduan Lainnya',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                        onPageChanged: (value) {
                          print('Page changed: $value');
                        },
                        autoPlayInterval: 5000,
                        isLoop: true,
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginPage()));

                                _updateInfo?.updateAvailability ==
                                        UpdateAvailability.updateAvailable
                                    ? () {
                                        InAppUpdate.performImmediateUpdate()
                                            .catchError(
                                                (e) => showSnack(e.toString()));
                                      }
                                    : null;
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Masuk',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: whitePrimary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: whitePrimary,
                                onPrimary: whitePrimary,
                                shadowColor: shadowColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                        width: 2, color: greenPrimary)),
                                minimumSize: const Size(130, 50), //////// HERE
                              ),
                              onPressed: () {
                                // sendRegistrationNotification("fauzantamsin09@gmail.com");

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Reveralcodepage()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Daftar',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left:30,right: 30),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: whitePrimary,
                                onPrimary: whitePrimary,
                                shadowColor: shadowColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                        width: 2, color: greenPrimary)),
                                minimumSize: const Size(130, 50), //////// HERE
                              ),
                              onPressed: () async {
                                String url = "https://ayocaleg.com/";
                                var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                                if(urllaunchable){
                                  await launch(url); //launch is from url_launcher package to launch URL
                                }else{
                                  print("URL can't be launched.");
                                }
                                // String url = 'https://ayocaleg.com/';
                                // await launchUrl(Uri.parse(url));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Masuk Tanpa Daftar',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left:30,right: 30,top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: whitePrimary,
                                onPrimary: whitePrimary,
                                shadowColor: shadowColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                        width: 2, color: greenPrimary)),
                                minimumSize: const Size(130, 50), //////// HERE
                              ),
                              onPressed: () async {
                                String url = "https://Ayocaleg.com/formulir";
                                var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                                if(urllaunchable){
                                  await launch(url); //launch is from url_launcher package to launch URL
                                }else{
                                  print("URL can't be launched.");
                                }
                                // String url = 'https://ayocaleg.com/formulir/';
                                // await launchUrl(Uri.parse(url));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Daftar Caleg',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.only(
                                left:30,right: 30,top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: whitePrimary,
                                onPrimary: whitePrimary,
                                shadowColor: shadowColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                        width: 2, color: greenPrimary)),
                                minimumSize: const Size(130, 50), //////// HERE
                              ),
                              onPressed: () async {

                                  setState(() async {
                                    String url = "https://youtube.com/playlist?list=PLfWMrxPsGMT9UkHc_4ZH4o2gJrJFIrnFT&si=stT3OFr_8euEhnsp";
                                    var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                                    if(urllaunchable){
                                      await launch(url); //launch is from url_launcher package to launch URL
                                    }else{
                                      print("URL can't be launched.");
                                    }


                                  });

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Tutorial',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left:30,right: 30,top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: whitePrimary,
                                onPrimary: whitePrimary,
                                shadowColor: shadowColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                        width: 2, color: greenPrimary)),
                                minimumSize: const Size(130, 50), //////// HERE
                              ),
                              onPressed: () async {

                                setState(() async {
                                  String url = "https://ayocaleg.com/artikel/";
                                  var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                                  if(urllaunchable){
                                    await launch(url); //launch is from url_launcher package to launch URL
                                  }else{
                                    print("URL can't be launched.");
                                  }


                                });

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Artikel Untuk Caleg 2024',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Stack(
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.bottomCenter,
                  //       child: Image.asset('assets/images/g7.png'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ]),
      ),
    ));
  }
//
// @override
// Widget build(BuildContext context) {
//   final size = MediaQuery.of(context).size;
//   return WillPopScope(
//       onWillPop: () => Future.value(false),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//             child: ListView(
//           children: [
//             Column(
//               children: [
//                 Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(),
//                 // FadeInUp(
//                 //   duration: Duration(milliseconds: 400),
//                 //   child: Container(
//                 //     padding: EdgeInsets.only(
//                 //         left:20 ),
//                 //     width: 100,
//                 //     height: 100,
//                 //     child: Image.asset("assets/images/logocaleg4.jpg"),
//                 //   ),
//                 // ),
//        ] ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: FadeInUp(
//                         duration: Duration(milliseconds: 800),
//                         child: ImageSlideshow(
//                           // width: size.width,
//                           // height: size.width,
//                           // height: 250,
//                           initialPage: 0,
//                           children: [
//                             Column(
//                               children: [
//                                 // SizedBox(
//                                 //   height: 250,
//                                   // height: size.width * 0.5,
//                                   // width: size.width * 0.7,
//                                 //   child:   Image.network(
//                                 //     // widget.question.fileInfo[0].remoteURL,
//                                 //     Fotobanner1,
//                                 //     // width: 220,
//                                 //     // height: 220,
//                                 //     //
//                                 //     loadingBuilder: (context, child, loadingProgress) =>
//                                 //     (loadingProgress == null)
//                                 //         ? child
//                                 //         : Center(
//                                 //       child: CircularProgressIndicator(),
//                                 //     ),
//                                 //     errorBuilder: (context, error, stackTrace) {
//                                 //       Future.delayed(
//                                 //         Duration(milliseconds: 0),
//                                 //             () {
//                                 //           if (mounted) {
//                                 //             setState(() {
//                                 //               CircularProgressIndicator();
//                                 //             });
//                                 //           }
//                                 //         },
//                                 //       );
//                                 //       return SizedBox.shrink();
//                                 //     },
//                                 //   ),
//                                 //
//                                 // ),
//
//                                 SizedBox(
//                                   height: 250,
//                                   child: Image.asset(
//                                     "assets/images/logocaleg4.jpg",
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: const EdgeInsets.only(bottom: 20),
//                                   child:
//                                   Container(
//                                     alignment: Alignment.center,
//                                     child: Center(
//                                       child: const Text(
//                                         'Ayocaleg: Aplikasi unggulan caleg 2024.Kelola kampanye dengan agenda,berita, dan aktivitas. Data swing voter, isusosial, suara online, pemilih tetapterorganisir. Panduan strategi offline danonline. Menuju kemenangan!',
//                                       style: TextStyle(
//                                       fontFamily: 'poppins',
//                                         color: textPrimary,
//                                         fontSize: 12,
//                                       ),
//                                   ),
//                                     ),
//                                 ),
//                                 ),
//                       ]),
//
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   height: 250,
//                                   // height: size.width * 0.5,
//                                   // width: size.width * 0.7,
//                                   child:Image.network(
//                                     // widget.question.fileInfo[0].remoteURL,
//                                     Fotobanner2,
//                                     // width: 220,
//                                     // height: 220,
//                                     //
//                                     loadingBuilder: (context, child, loadingProgress) =>
//                                     (loadingProgress == null)
//                                         ? child
//                                         : Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                     errorBuilder: (context, error, stackTrace) {
//                                       Future.delayed(
//                                         Duration(milliseconds: 0),
//                                             () {
//                                           if (mounted) {
//                                             setState(() {
//                                               CircularProgressIndicator();
//                                             });
//                                           }
//                                         },
//                                       );
//                                       return SizedBox.shrink();
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   height: 250,
//                                   // height: size.width * 0.5,
//                                   // width: size.width * 0.7,
//                                   child: Image.network(
//                                     // widget.question.fileInfo[0].remoteURL,
//                                     Fotobanner3,
//                                     // width: 220,
//                                     // height: 220,
//                                     //
//                                     loadingBuilder: (context, child, loadingProgress) =>
//                                     (loadingProgress == null)
//                                         ? child
//                                         : Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                     errorBuilder: (context, error, stackTrace) {
//                                       Future.delayed(
//                                         Duration(milliseconds: 0),
//                                             () {
//                                           if (mounted) {
//                                             setState(() {
//                                               CircularProgressIndicator();
//                                             });
//                                           }
//                                         },
//                                       );
//                                       return SizedBox.shrink();
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   height: 250,
//                                   // height: size.width * 0.5,
//                                   // width: size.width * 0.7,
//                                   child:Image.network(
//                                     // widget.question.fileInfo[0].remoteURL,
//                                     Fotobanner4,
//                                     // width: 220,
//                                     // height: 220,
//                                     //
//                                     loadingBuilder: (context, child, loadingProgress) =>
//                                     (loadingProgress == null)
//                                         ? child
//                                         : Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                     errorBuilder: (context, error, stackTrace) {
//                                       Future.delayed(
//                                         Duration(milliseconds: 0),
//                                             () {
//                                           if (mounted) {
//                                             setState(() {
//                                               CircularProgressIndicator();
//                                             });
//                                           }
//                                         },
//                                       );
//                                       return SizedBox.shrink();
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   height: 250,
//                                   // height: size.width * 0.5,
//                                   // width: size.width * 0.7,
//                                   child: Image.network(
//                                     // widget.question.fileInfo[0].remoteURL,
//                                     Fotobanner5,
//                                     // width: 220,
//                                     // height: 220,
//                                     //
//                                     loadingBuilder: (context, child, loadingProgress) =>
//                                     (loadingProgress == null)
//                                         ? child
//                                         : Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                     errorBuilder: (context, error, stackTrace) {
//                                       Future.delayed(
//                                         Duration(milliseconds: 0),
//                                             () {
//                                           if (mounted) {
//                                             setState(() {
//                                               CircularProgressIndicator();
//                                             });
//                                           }
//                                         },
//                                       );
//                                       return SizedBox.shrink();
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                           onPageChanged: (value) {
//                             print('Page changed: $value');
//                           },
//                           autoPlayInterval: 5000,
//                           isLoop: true,
//                         ),
//                       ),
//                     ),
//                     FadeInUp(
//                       duration: Duration(milliseconds: 1400),
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 30),
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 30, vertical: 10),
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   primary: greenPrimary,
//                                   onPrimary: whitePrimary,
//                                   shadowColor: shadowColor,
//                                   elevation: 3,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   minimumSize:
//                                       const Size(130, 50), //////// HERE
//                                 ),
//                                 onPressed: () {
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               LoginPage()));
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: const [
//                                     Text(
//                                       'Masuk',
//                                       style: TextStyle(
//                                           fontFamily: 'poppins',
//                                           color: whitePrimary,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 30, vertical: 10),
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   primary: whitePrimary,
//                                   onPrimary: whitePrimary,
//                                   shadowColor: shadowColor,
//                                   elevation: 3,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                       side: const BorderSide(
//                                           width: 2, color: greenPrimary)),
//                                   minimumSize:
//                                       const Size(130, 50), //////// HERE
//                                 ),
//                                 onPressed: () {
//                                   // sendRegistrationNotification("fauzantamsin09@gmail.com");
//
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               Reveralcodepage()));
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: const [
//                                     Text(
//                                       'Daftar',
//                                       style: TextStyle(
//                                           fontFamily: 'poppins',
//                                           color: greenPrimary,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 30, vertical: 10),
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   primary: whitePrimary,
//                                   onPrimary: whitePrimary,
//                                   shadowColor: shadowColor,
//                                   elevation: 3,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                       side: const BorderSide(
//                                           width: 2, color: greenPrimary)),
//                                   minimumSize:
//                                   const Size(130, 50), //////// HERE
//                                 ),
//                                 onPressed: () async {
//                                   String url =
//                                       'https://ayocaleg.com/';
//                                   await launchUrl(Uri.parse(url));
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: const [
//                                     Text(
//                                       'Masuk Tanpa Daftar',
//                                       style: TextStyle(
//                                           fontFamily: 'poppins',
//                                           color: greenPrimary,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     // Stack(
//                     //   children: [
//                     //     Container(
//                     //       alignment: Alignment.bottomCenter,
//                     //       child: Image.asset('assets/images/g7.png'),
//                     //     ),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         )),
//       ));
// }

cekbanner() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map data = {'nmap': 'ayocaleg'};

  dynamic jsonResponse;
  var response = await http.post(
      Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekbn.php"),
      body: data);
  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body);

    if (jsonResponse != null) {
      if (jsonResponse["data"] != null) {
        setState(() {
          Fotobanner1 = jsonResponse["data"]["ftbn1"];
          Fotobanner2 = jsonResponse["data"]["ftbn2"];
          Fotobanner3 = jsonResponse["data"]["ftbn3"];
          Fotobanner4 = jsonResponse["data"]["ftbn4"];
          Fotobanner5 = jsonResponse["data"]["ftbn5"];


          prefs.setString("Fotobanner1", Fotobanner1);
          prefs.setString("Fotobanner2", Fotobanner2);
          prefs.setString("Fotobanner3", Fotobanner3);
          prefs.setString("Fotobanner4", Fotobanner4);
          prefs.setString("Fotobanner5", Fotobanner5);
        });

      }
    }
  }
}
}
