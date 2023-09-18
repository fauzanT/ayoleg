// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:typed_data';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ayoleg/cameraktp/viewimage.dart';
import 'package:ayoleg/camerasaksi.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/team/pendukung.dart';
import 'package:ayoleg/welcome/welcome.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RelawanPendukungPage extends StatefulWidget {
  const RelawanPendukungPage({Key? key}) : super(key: key);

  @override
  State<RelawanPendukungPage> createState() => _RelawanPendukungPageState();
}

class _RelawanPendukungPageState extends State<RelawanPendukungPage> {
  late Timer _timerForInter;

  bool loading = false;

  _startUp() async {
    _setLoading(true);

    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  var nikText = TextEditingController();
  String nohpAkun = "";
  String fotoAkun = "";
  String namaakun = "";
  String daerahpemilihan = "";
  String status = "";
  String umur = "";
  String alamatktp1 = "";
  String alamatktp2 = "";
  String statuskawin = "";
  String agama = "";
  String pekerjaan = "";
  String kodecaleg = "";
  String nikakun = "";
  String emailakun = "";
  String namarelawan = "";
  String tgglbergabung = "";


  int jumlahpendukung = 0;
  String fotoc1saksi = "";
  bool visibletps= false;
  bool visiblejmlpendukung = false;
  bool visibledatapendukung= false;
  String targetpendukung = "";
  String alasancaleg = "";
  String bantucaleg = "";
  String programutama = "";
  String siapatargetpendukung = "";
  bool visiblecewekvalid = false;
  bool visiblelakivalid = false;


  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    _startUp();

    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      nohpAkun = prefs.getString('nohprelawan')!;
      cekidrelawan(nohpAkun);
      // cektotpendukung();
      // cekdatasaksi();
      // fotoAkun = "";
      // namaakun = "";
      // daerahpemilihan = "";
      // status = "";
      // umur = "";
      // alamatktp1 = "";
      // alamatktp2 = "";
      // statuskawin = "";
      // agama = "";
      // pekerjaan = "";
      // kodecaleg = "";
      // nikakun = "";
      // emailakun = "";
    });

    super.initState();
  }

  @override
  void dispose() {
    _timerForInter.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   automaticallyImplyLeading: false,
          //   systemOverlayStyle: const SystemUiOverlayStyle(
          //     statusBarColor: whitePrimary,
          //     statusBarIconBrightness: Brightness.dark,
          //     statusBarBrightness: Brightness.light,
          //   ),
          //   flexibleSpace: Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //         colors: [
          //           gradient7,
          //           gradient5,
          //         ],
          //       ),
          //     ),
          //   ),
          //   title: Container(
          //     alignment: Alignment.topLeft,
          //     child: Image.asset(
          //       "assets/images/logocaleg3.png",
          //       width: 100,
          //     ),
          //   ),
          //   centerTitle: true,
          //   elevation: 0,
          //   actions: [
          //     // InkWell(
          //     //   onTap: () {
          //     //     accountMenu();
          //     //   },
          //     //   child: Container(
          //     //     margin: const EdgeInsets.only(right: 20),
          //     //     decoration: const BoxDecoration(
          //     //       color: whitePrimary,
          //     //       shape: BoxShape.circle,
          //     //       boxShadow: [
          //     //         BoxShadow(
          //     //             blurRadius: 2, color: shadowColor, spreadRadius: 5)
          //     //       ],
          //     //     ),
          //     //     child: const CircleAvatar(
          //     //       backgroundColor: Colors.white,
          //     //       radius: 20,
          //     //       child: Icon(Icons.settings),
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.2,
                      0.5,
                      0.8,

                    ],
                    colors: [
                      gradient1,
                      gradient2,
                      gradient3,

                    ])),
            child: ListView(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        new Container(
                          height: 290.0,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100)),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                gradient7,
                                gradient5,
                              ],
                            ),
                            color: greenPrimary,
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.only(top:20),
                                child:   ClipOval(
                                  // borderRadius:
                                  // BorderRadius.circular(150),
                                  child: Image.network(
                                    // widget.question.fileInfo[0].remoteURL,
                                    fotoAkun,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    //
                                    loadingBuilder: (context,
                                        child,
                                        loadingProgress) =>
                                    (loadingProgress == null)
                                        ? child
                                        : CircularProgressIndicator(),
                                    errorBuilder: (context, error,
                                        stackTrace) {
                                      Future.delayed(
                                        Duration(milliseconds: 0),
                                            () {
                                          if (mounted) {
                                            setState(() {
                                              CircularProgressIndicator();
                                            });
                                          }
                                        },
                                      );
                                      return SizedBox.shrink();
                                    },
                                  ),
                                ),
                              ),
                              onTap: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("fotoview",fotoAkun);
                                prefs.setString("navfoto", "relawanpendukung");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ZoomableImage(),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Container(
                                // padding:
                                // const EdgeInsets.symmetric(vertical: 11),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      size: 20,
                                      color: whitePrimary,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      status +" "+ namarelawan,
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: whitePrimary,
                                      ),
                                    )
                                  ],
                                )),

                            Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.date_range_outlined,
                                      size: 20,
                                      color: whitePrimary,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Bergabung Pada : "+ tgglbergabung,
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: whitePrimary,
                                      ),
                                    )
                                  ],
                                )),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: whitePrimary,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  // BoxShadow(
                                  //     blurRadius: 2,
                                  //     color: shadowColor,
                                  //     spreadRadius: 3)
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    // width: size.width * 04,
                                    decoration: BoxDecoration(
                                      color: whitePrimary,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //     blurRadius: 2,
                                        //     color: shadowColor,
                                        //     spreadRadius: 3)
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: visiblecewekvalid,
                                          child:
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: const BoxDecoration(
                                              color: whitePrimary,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  bottomLeft: Radius.circular(0)),
                                            ),
                                            child: const Icon(
                                              Icons.woman,
                                              size: 40,
                                              color: gradient6,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: visiblelakivalid,
                                          child:
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: const BoxDecoration(
                                              color: whitePrimary,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  bottomLeft: Radius.circular(0)),
                                            ),
                                            child: const Icon(
                                              Icons.man,
                                              size: 40,
                                              color: hijauprimary,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          width: 20,
                                        ),
                                        namaakun.isNotEmpty
                                            ? Expanded(
                                          child: Text(
                                            namaakun,
                                            style: const TextStyle(
                                              overflow:
                                              TextOverflow.ellipsis,
                                              fontFamily: 'poppins',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: textPrimary,
                                            ),
                                            overflow: TextOverflow.clip,
                                          ),
                                        )
                                            : DefaultTextStyle(
                                          style: const TextStyle(
                                              fontSize: 30.0,
                                              color: greenPrimary),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                  '•••••••••'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   margin: const EdgeInsets.symmetric(
                                  //       horizontal: 20),
                                  //   // width: size.width * 04,
                                  //   decoration: BoxDecoration(
                                  //     color: whitePrimary,
                                  //     borderRadius: BorderRadius.circular(0),
                                  //     boxShadow: const [
                                  //       // BoxShadow(
                                  //       //     blurRadius: 2,
                                  //       //     color: shadowColor,
                                  //       //     spreadRadius: 3)
                                  //     ],
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //     MainAxisAlignment.start,
                                  //     children: [
                                  //       Container(
                                  //         height: 30,
                                  //         width: 30,
                                  //         decoration: const BoxDecoration(
                                  //           color: whitePrimary,
                                  //           borderRadius: BorderRadius.only(
                                  //               topLeft: Radius.circular(0),
                                  //               bottomLeft: Radius.circular(0)),
                                  //         ),
                                  //         child: const Icon(
                                  //           Icons.person,
                                  //           color: greenPrimary,
                                  //         ),
                                  //       ),
                                  //       const SizedBox(
                                  //         width: 20,
                                  //       ),
                                  //       namaakun.isNotEmpty
                                  //           ? Expanded(
                                  //         child: Text(
                                  //           namaakun,
                                  //           style: const TextStyle(
                                  //             overflow:
                                  //             TextOverflow.ellipsis,
                                  //             fontFamily: 'poppins',
                                  //             fontSize: 15,
                                  //             fontWeight: FontWeight.bold,
                                  //             color: textPrimary,
                                  //           ),
                                  //           overflow: TextOverflow.clip,
                                  //         ),
                                  //       )
                                  //           : DefaultTextStyle(
                                  //         style: const TextStyle(
                                  //             fontSize: 30.0,
                                  //             color: greenPrimary),
                                  //         child: AnimatedTextKit(
                                  //           animatedTexts: [
                                  //             TyperAnimatedText(
                                  //                 '•••••••••'),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "NIK ",
                                        style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),



                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    // width: size.width * 04,
                                    decoration: BoxDecoration(
                                      color: whitePrimary,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //     blurRadius: 2,
                                        //     color: shadowColor,
                                        //     spreadRadius: 3)
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: const BoxDecoration(
                                            color: whitePrimary,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                bottomLeft: Radius.circular(0)),
                                          ),
                                          child: const Icon(
                                            Icons.credit_card,
                                            color: greenPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        nikakun.isNotEmpty
                                            ? Text(
                                          nikakun,
                                          style: const TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: textPrimary,
                                          ),
                                        )
                                            : DefaultTextStyle(
                                          style: const TextStyle(
                                              fontSize: 30.0,
                                              color: greenPrimary),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                  '•••••••••'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "No. HP ",
                                        style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    // width: size.width * 04,
                                    decoration: BoxDecoration(
                                      color: whitePrimary,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //     blurRadius: 2,
                                        //     color: shadowColor,
                                        //     spreadRadius: 3)
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: const BoxDecoration(
                                            color: whitePrimary,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                bottomLeft: Radius.circular(0)),
                                          ),
                                          child: const Icon(
                                            Icons.phone_iphone,
                                            color: greenPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        nohpAkun.isNotEmpty
                                            ? Text(
                                          '+' + nohpAkun,
                                          style: const TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: textPrimary,
                                          ),
                                        )
                                            : DefaultTextStyle(
                                          style: const TextStyle(
                                              fontSize: 30.0,
                                              color: greenPrimary),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                  '•••••••••'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "Email ",
                                        style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    // width: size.width * 04,
                                    decoration: BoxDecoration(
                                      color: whitePrimary,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //     blurRadius: 2,
                                        //     color: shadowColor,
                                        //     spreadRadius: 3)
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: const BoxDecoration(
                                            color: whitePrimary,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                bottomLeft: Radius.circular(0)),
                                          ),
                                          child: const Icon(
                                            Icons.mail,
                                            color: greenPrimary,
                                          ),
                                        ),


                                        const SizedBox(
                                          width: 20,
                                        ),
                                        emailakun.isNotEmpty
                                            ? Text(
                                          emailakun,
                                          style: const TextStyle(
                                            overflow:
                                            TextOverflow.ellipsis,
                                            fontFamily: 'poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: textPrimary,
                                          ),
                                          overflow: TextOverflow.clip,
                                        )
                                            : DefaultTextStyle(
                                          style: const TextStyle(
                                              fontSize: 30.0,
                                              color: greenPrimary),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                  '•••••••••'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),




                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "Alamat KTP ",
                                        style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    // width: size.width * 04,
                                    decoration: BoxDecoration(
                                      color: whitePrimary,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //     blurRadius: 2,
                                        //     color: shadowColor,
                                        //     spreadRadius: 3)
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          // height: 10,
                                          // width: 10,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          decoration: const BoxDecoration(
                                            color: whitePrimary,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                bottomLeft: Radius.circular(0)),
                                          ),
                                          child: const Icon(
                                            Icons.circle,
                                            size: 15.0,
                                            color: greenPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          // height: 30,
                                          width: 200,
                                          child: alamatktp1.isNotEmpty
                                              ? Text(
                                            alamatktp1,
                                            style: const TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: textPrimary,
                                            ),
                                          )
                                              : DefaultTextStyle(
                                            style: const TextStyle(
                                                fontSize: 30.0,
                                                color: greenPrimary),
                                            child: AnimatedTextKit(
                                              animatedTexts: [
                                                TyperAnimatedText(
                                                    '•••••••••'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "Alamat Domisili ",
                                        style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    // width: size.width * 04,
                                    decoration: BoxDecoration(
                                      color: whitePrimary,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //     blurRadius: 2,
                                        //     color: shadowColor,
                                        //     spreadRadius: 3)
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          // height: 10,
                                          // width: 10,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          decoration: const BoxDecoration(
                                            color: whitePrimary,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                bottomLeft: Radius.circular(0)),
                                          ),
                                          child: const Icon(
                                            Icons.circle,
                                            size: 15.0,
                                            color: greenPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          // height: 30,
                                          width: 200,
                                          child: alamatktp2.isNotEmpty
                                              ? Text(
                                            alamatktp2,
                                            style: const TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: textPrimary,
                                            ),
                                          )
                                              : DefaultTextStyle(
                                            style: const TextStyle(
                                                fontSize: 30.0,
                                                color: greenPrimary),
                                            child: AnimatedTextKit(
                                              animatedTexts: [
                                                TyperAnimatedText(
                                                    '•••••••••'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),


                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "Daerah Pemilihan ",
                                        style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    // width: size.width * 04,
                                    decoration: BoxDecoration(
                                      color: whitePrimary,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //     blurRadius: 2,
                                        //     color: shadowColor,
                                        //     spreadRadius: 3)
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          // height: 10,
                                          // width: 10,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          decoration: const BoxDecoration(
                                            color: whitePrimary,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                bottomLeft: Radius.circular(0)),
                                          ),
                                          child: const Icon(
                                            Icons.circle,
                                            size: 15.0,
                                            color: greenPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        daerahpemilihan.isNotEmpty
                                            ? Text(
                                          daerahpemilihan,
                                          style: const TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: textPrimary,
                                          ),
                                        )
                                            : DefaultTextStyle(
                                          style: const TextStyle(
                                              fontSize: 30.0,
                                              color: greenPrimary),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                  '•••••••••'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Visibility(
                                    visible: visibledatapendukung,
                                    child:
                                    Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: Text(
                                                "Target Pendukung",
                                                style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            // width: size.width * 04,
                                            decoration: BoxDecoration(
                                              color: whitePrimary,
                                              borderRadius: BorderRadius.circular(0),
                                              boxShadow: const [
                                              ],
                                            ),
                                            child:
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // height: 10,
                                                  // width: 10,
                                                  margin: const EdgeInsets.symmetric(
                                                      vertical: 20, horizontal: 20),
                                                  decoration: const BoxDecoration(
                                                    color: whitePrimary,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        bottomLeft: Radius.circular(0)),
                                                  ),
                                                  child: const Icon(
                                                    Icons.circle,
                                                    size: 15.0,
                                                    color: greenPrimary,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                targetpendukung.isNotEmpty
                                                    ? Text(
                                                  targetpendukung,
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                                    : Text(
                                                  "-",
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                "Apa Alasan Anda Memilih Caleg ini ?",
                                                style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            // width: size.width * 04,
                                            decoration: BoxDecoration(
                                              color: whitePrimary,
                                              borderRadius: BorderRadius.circular(0),
                                              boxShadow: const [
                                              ],
                                            ),
                                            child:
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // height: 10,
                                                  // width: 10,
                                                  margin: const EdgeInsets.symmetric(
                                                      vertical: 20, horizontal: 20),
                                                  decoration: const BoxDecoration(
                                                    color: whitePrimary,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        bottomLeft: Radius.circular(0)),
                                                  ),
                                                  child: const Icon(
                                                    Icons.circle,
                                                    size: 15.0,
                                                    color: greenPrimary,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                alasancaleg.isNotEmpty
                                                    ? Text(
                                                  alasancaleg,
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                                    : Text(
                                                  "-",
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                "Apa Yang Bisa Anda Bantu Untuk Caleg ini ?",
                                                style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            // width: size.width * 04,
                                            decoration: BoxDecoration(
                                              color: whitePrimary,
                                              borderRadius: BorderRadius.circular(0),
                                              boxShadow: const [
                                              ],
                                            ),
                                            child:
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // height: 10,
                                                  // width: 10,
                                                  margin: const EdgeInsets.symmetric(
                                                      vertical: 20, horizontal: 20),
                                                  decoration: const BoxDecoration(
                                                    color: whitePrimary,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        bottomLeft: Radius.circular(0)),
                                                  ),
                                                  child: const Icon(
                                                    Icons.circle,
                                                    size: 15.0,
                                                    color: greenPrimary,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                bantucaleg.isNotEmpty
                                                    ? Text(
                                                  bantucaleg,
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                                    : Text(
                                                  "-",
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                "Program Apa Yang Ingin Anda Utamakan ?",
                                                style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            // width: size.width * 04,
                                            decoration: BoxDecoration(
                                              color: whitePrimary,
                                              borderRadius: BorderRadius.circular(0),
                                              boxShadow: const [
                                              ],
                                            ),
                                            child:
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // height: 10,
                                                  // width: 10,
                                                  margin: const EdgeInsets.symmetric(
                                                      vertical: 20, horizontal: 20),
                                                  decoration: const BoxDecoration(
                                                    color: whitePrimary,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        bottomLeft: Radius.circular(0)),
                                                  ),
                                                  child: const Icon(
                                                    Icons.circle,
                                                    size: 15.0,
                                                    color: greenPrimary,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                programutama.isNotEmpty
                                                    ? Text(
                                                  programutama,
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                                    : Text(
                                                  "-",
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                "Siapa Target Pendukung Anda ?",
                                                style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            // width: size.width * 04,
                                            decoration: BoxDecoration(
                                              color: whitePrimary,
                                              borderRadius: BorderRadius.circular(0),
                                              boxShadow: const [
                                              ],
                                            ),
                                            child:
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // height: 10,
                                                  // width: 10,
                                                  margin: const EdgeInsets.symmetric(
                                                      vertical: 20, horizontal: 20),
                                                  decoration: const BoxDecoration(
                                                    color: whitePrimary,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        bottomLeft: Radius.circular(0)),
                                                  ),
                                                  child: const Icon(
                                                    Icons.circle,
                                                    size: 15.0,
                                                    color: greenPrimary,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                siapatargetpendukung.isNotEmpty
                                                    ? Text(
                                                  siapatargetpendukung,
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                                    : Text(
                                                  "-",
                                                  style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimary,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                        ]
                                    ),





                                  ),


                                  Visibility(
                                    visible: visiblejmlpendukung,
                                    child:
                                    Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                "Pendukung",
                                                style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            // width: size.width * 04,
                                            decoration: BoxDecoration(
                                              color: whitePrimary,
                                              borderRadius: BorderRadius.circular(0),
                                              boxShadow: const [
                                              ],
                                            ),
                                            child:
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // height: 10,
                                                  // width: 10,
                                                  margin: const EdgeInsets.symmetric(
                                                      vertical: 20, horizontal: 10),
                                                  decoration: const BoxDecoration(
                                                    color: whitePrimary,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        bottomLeft: Radius.circular(0)),
                                                  ),
                                                  child: const Icon(
                                                    Icons.people_alt_outlined,
                                                    size: 20.0,
                                                    color: greenPrimary,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  width: 20,
                                                ),

                                                TextButton(
                                                    onPressed: () {

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext context) => Pendukungpage()));
                                                    },
                                                    child:
                                                    jumlahpendukung != 0
                                                        ? Text(
                                                      'Total : ' + CurrencyFormat.convertToIdr(jumlahpendukung, 0),
                                                      style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: greenPrimary,
                                                      ),
                                                    )
                                                        : Text(
                                                      "0",
                                                      style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: textPrimary,
                                                      ),
                                                    )
                                                ),

                                              ],
                                            ),

                                          ),

                                        ]
                                    ),
                                  ),

                                  Visibility(
                                    visible: visibletps,
                                    child:
                                    Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                "Data Inputan TPS",
                                                style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),

                                          Center(
                                            child: fotoc1saksi.isEmpty
                                                ? Container(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator())
                                                : Container(
                                                alignment: Alignment.center,
                                                child: Image.network(
                                                  fotoc1saksi,
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        ]
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 50.0),
          //   child: FloatingActionButton(
          //     child: Icon(
          //       Icons.add,
          //       color: whitePrimary,
          //     ),
          //     onPressed: () {
          //       // getgalery();
          //       // Navigator.push(
          //       //     context,
          //       //     MaterialPageRoute(
          //       //         builder: (context) => const Tambahnewspage()));
          //     },
          //     backgroundColor: greenPrimary,
          //   ),
          // ),
        )
      ],
    );
  }

  Widget datapeople() {
    return Column(children: [
      Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    InkWell(
                      child: Text(
                        'Data Saksi TPS',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 0,
            ),
            child: const Row(
              children: [
                Text(
                  'Caleg Gelby Alamoudy : ',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '500  Suara Dari Partai Nasdem',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 0,
            ),
            child: const Row(
              children: [
                Text(
                  'Caleg Fauzan Zambir : ',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '300  Suara  Dari Partai Gerindra',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    InkWell(
                      child: Text(
                        'Total Data',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 0,
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.man_2_outlined,
                  size: 50,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "800 Suara Di TPS 45 Jakarta Pusat",
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ],
      )
    ]);
  }

  cekidrelawan(String usrhp) async {
    Map data = {
      'usrhp': usrhp,
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekidrelawan.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse['data'] != null) {
          setState(() {
            namaakun = jsonResponse['data']['usrnm'];
            fotoAkun = jsonResponse['data']['usrft'];
            daerahpemilihan = jsonResponse['data']['usrdpl'];
            tgglbergabung = jsonResponse['data']['usrdd'] +" "+jsonResponse['data']['usrtd'];

            if(jsonResponse['data']['usrjk']=='L'){
              setState(() {
                visiblecewekvalid = false;
                visiblelakivalid = true;
              });
            }else{
              setState(() {
                visiblecewekvalid = true;
                visiblelakivalid = false;
              });
            }

            if (jsonResponse['data']['usrsts'] == "R") {
              setState(() {
                status = "Relawan";
              });
            } else if (jsonResponse['data']['usrsts'] == "S") {
              setState(() {
                status = "Saksi";
              });
            } else if (jsonResponse['data']['usrsts'] == "A") {
              setState(() {
                status = "Admin";
              });
            } else if (jsonResponse['data']['usrsts'] == "C") {
              setState(() {
                status = "Calon Legislatif";
              });
            } else {
              setState(() {
                status = "Pendukung";
                targetpendukung = (jsonResponse['data']['usrtpd']);
                alasancaleg =  (jsonResponse['data']['usrapc']);
                bantucaleg = (jsonResponse['data']['usrbpd']);
                programutama = (jsonResponse['data']['usrput']);
                siapatargetpendukung = (jsonResponse['data']['usrtrp']);
              });
            }
            // umur = jsonResponse['data']['usrnm'];
            alamatktp1 = jsonResponse['data']['usralm1']+", "+
                jsonResponse['data']['usrrt1'] +
                ", " +
                jsonResponse['data']['usrrw1'] +
                ", " +
                jsonResponse['data']['usrkel1'] +
                ", " +
                jsonResponse['data']['usrkec1'] +
                ", " +
                jsonResponse['data']['usrkt1'] +
                ", " +
                jsonResponse['data']['usrpr1'];

            alamatktp2 = jsonResponse['data']['usralm2']+", "+
                jsonResponse['data']['usrrt2'] +
                ", " +
                jsonResponse['data']['usrrw2'] +
                ", " +
                jsonResponse['data']['usrkel2'] +
                ", " +
                jsonResponse['data']['usrkec2'] +
                ", " +
                jsonResponse['data']['usrkt2'] +
                ", " +
                jsonResponse['data']['usrpr2'];

            statuskawin = jsonResponse['data']['usrsp'];
            agama = jsonResponse['data']['usragm'];
            pekerjaan = jsonResponse['data']['usrpkj'];
            kodecaleg = jsonResponse['data']['usrnm'];
            nikakun = jsonResponse['data']['usrnik'];
            emailakun = jsonResponse['data']['usrema'];
          });
        } else {}
      }
    } else {}
  }

  cektotpendukung() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    String nohprelawan = prefs.getString('nohprelawancalegpendukung')!;
    Map data = {
      'usrkc': kodecaleg,
      'usrhpr': nohprelawan,
      'usrhp': nohprelawan,
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmlpendukung.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          namarelawan = "Dari Relawan "+jsonResponse['datarelawan']['usrnm'];

          prefs.setString(
              'nohprelawan', "");
          prefs.setString(
              'nohprelawancalegpendukung', "");

        });
      }
    }
  }



  cekdatasaksi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    String nohsaksi = prefs.getString('nohprelawansaksi')!;
    Map data = {
      'srakc': kodecaleg,
      'srahp': nohsaksi,

    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/ceksra.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse['data'] != null) {
          setState(() {
            visibletps = true;
            fotoc1saksi = jsonResponse['data']['ftc1'];
            prefs.setString(
                'nohprelawan', "");
            prefs.setString(
                'nohprelawansaksi', "");

          });

        }else{
          setState(() {
            visibletps = false;
          });
        }

      }else{
        setState(() {
          visibletps = false;
        });
      }
    }else{
      setState(() {
        visibletps = false;
      });
    }
  }



}
