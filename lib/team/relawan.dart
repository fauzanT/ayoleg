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
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/team/pendukung.dart';
import 'package:ayoleg/team/pendukungpendukung.dart';
import 'package:ayoleg/team/pendukungteam.dart';
import 'package:ayoleg/welcome/welcome.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RelawanPage extends StatefulWidget {
  const RelawanPage({Key? key}) : super(key: key);

  @override
  State<RelawanPage> createState() => _RelawanPageState();
}

class _RelawanPageState extends State<RelawanPage> {
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
  var aktifasicontrolel = TextEditingController();
  var alasankeluarconterolel = TextEditingController();

  String nohpAkun = "";
  String fotoAkun = "";
  String namaakun = "";
  String daerahpemilihan = "";
  String jmlpemilihan = "";
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
  String targetpendukung = "";
  String alasancaleg = "";
  String bantucaleg = "";
  String programutama = "";
  String siapatargetpendukung = "";
  String fotoktp = "";
  String bidangutama ="";
  String usrhrc="";
  String usrsts = "";
  String tgglbergabung = "";

  String namarelawan = "";
  String statuspindahcaleg = "";
  String statuspindahpartai = "";
  int jumlahpendukung = 0;
  int jumlahpendukungpendukung = 0;
  String fotoc1saksi = "";
  bool visibletps= false;
  bool visiblejmlpendukung = false;
  bool visiblepindahpartai = false;
  bool visiblejmlpendukungpendukung= false;
  bool visibledatapendukung= false;
  bool visibletargetdukungan = false;
  bool visiblebidanguatama = false;

  bool visiblecewekvalid = false;
  bool visiblelakivalid = false;
  bool visibleaktif =false;
  bool visiblealasankeluar = false;
  bool visiblealasanvalid = false;

  String dropdownalasankeluar = 'Meninggal Dunia';
  var itemsalasankeluar = [
    'Meninggal Dunia',
    'Sakit Parah',
    'Pindah Domisili',
    'Pindah Dukungan',
    'Tidak Pernah Ikut Kegiatan',
    'Ada Kesalahan Fatal',
    "Lainnya",
  ];


  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    _startUp();

    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      nohpAkun = prefs.getString('nohprelawan')!;
      cekidrelawan(nohpAkun);
      cektotpendukungrelawan();
      cektotpendukungpendukung(nohpAkun );
      usrsts = prefs.getString('status')!;


      if (usrsts == "Admin") {
        setState(() {
          visibleaktif =true;
        });
      } else if (usrsts == "Calon Legislatif") {
        setState(() {
          visibleaktif =true;
        });
      } else  {
        setState(() {
          visibleaktif =false;
        });
      }
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
                                child:     ClipOval(
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
                                prefs.setString("navfoto", "relawan");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ZoomableImage(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                                height: 10,
                              ),
                            Container(
                                // padding:
                                //     const EdgeInsets.symmetric(vertical: 11),
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

                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
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
                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
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
                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
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
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          child: Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            // padding: const EdgeInsets.all(7),
                                            decoration: const BoxDecoration(
                                              color: whitePrimary,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 2,
                                                    color: shadowColor,
                                                    spreadRadius: 5)
                                              ],
                                            ),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image.asset("assets/images/whatsapp.png"),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() async {
                                              String url =
                                                  'https://api.whatsapp.com/send?phone=+'+nohpAkun;
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          child: Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            // padding: const EdgeInsets.all(7),
                                            decoration: const BoxDecoration(
                                              color: whitePrimary,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 2,
                                                    color: shadowColor,
                                                    spreadRadius: 5)
                                              ],
                                            ),
                                            child: const Icon(Icons.phone),
                                          ),
                                          onTap: () {
                                            setState(() async {
                                              String phoneNumber = 'tel:+'+nohpAkun; // Replace with a valid phone number
                                              if (await canLaunch(phoneNumber)) {
                                                await launch(phoneNumber);
                                              } else {
                                                throw 'Could not launch $phoneNumber';
                                              }
                                            });
                                          },
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


                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
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
                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
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
                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
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
                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
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
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "Jumlah Pemilih Terdaftar Dalam Kartu Keluarga",
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
                                            Icons.circle,
                                            size: 15.0,
                                            color: greenPrimary,
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
                                        jmlpemilihan.isNotEmpty
                                            ? Text(
                                          jmlpemilihan,
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
                                        "Saran Untuk Caleg",
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
                                    // width: ,
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
                                            Icons.circle,
                                            size: 15.0,
                                            color: greenPrimary,
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
                                        usrhrc.isNotEmpty
                                            ? Expanded(
                                          child: Text(
                                            usrhrc,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'poppins',
                                              fontSize: 12,
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
                                  Visibility(
                                      visible: visiblebidanguatama,
                                      child:       Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                alignment: Alignment.topLeft,
                                                margin: const EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Text(
                                                  "Bidang Utama ",
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
                                                  // const SizedBox(
                                                  //   width: 20,
                                                  // ),
                                                  bidangutama.isNotEmpty
                                                      ? Text(
                                                    bidangutama,
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

                                          ])
                                  ),
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
                                              "Foto KTP",
                                              style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 15,
                                        ),

                                        Center(
                                          child:
                                          InkWell(
                                            child:
                                            Container(
                                              // height: 100,
                                              margin: EdgeInsets.only(top:20),
                                              child:
                                                Image.network(

                                                  fotoktp,
                                                  width: 250,
                                                  height: 250,
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
                                            onTap: () async {
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              prefs.setString("fotoview",fotoktp);
                                              prefs.setString("navfoto", "relawan");
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const ZoomableImage(),
                                                ),
                                              );
                                            },
                                          ),


                                        ),
                                      ]
                                  ),
                                  Visibility(
                                      visible: visibletargetdukungan,
                                      child:       Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
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
                                                  // const SizedBox(
                                                  //   width: 20,
                                                  // ),
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

                                          ])
                                  ),



                                  Visibility(
                                    visible: visiblepindahpartai,
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
                                                "Kemungkinan Pindah Caleg :",
                                                style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                // height: 10,
                                                // width: 10,
                                                margin: const EdgeInsets.symmetric(
                                                    vertical: 20, horizontal: 30),
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
                                              // const SizedBox(
                                              //   width: 20,
                                              // ),
                                              statuspindahcaleg.isNotEmpty
                                                  ? Text(
                                                statuspindahcaleg+" Mungkin",
                                                style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: textPrimary,
                                                ),
                                              )
                                                  :Text(
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
                                                      "Kemungkinan Pindah Partai :",
                                                      style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // height: 10,
                                                      // width: 10,
                                                      margin: const EdgeInsets.symmetric(
                                                          vertical: 20, horizontal: 30),
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
                                                    // const SizedBox(
                                                    //   width: 20,
                                                    // ),
                                                    statuspindahpartai.isNotEmpty
                                                        ? Text(
                                                      statuspindahpartai+" Mungkin",
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

                                              ]
                                          ),
                                        ]
                                    )

                                   

                                  ),

                                  Visibility(
                                    visible: visibledatapendukung,
                                    child:
                                    Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          // const SizedBox(
                                          //   height: 20,
                                          // ),

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
                                                // const SizedBox(
                                                //   width: 20,
                                                // ),
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
                                                // const SizedBox(
                                                //   width: 20,
                                                // ),
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
                                                // const SizedBox(
                                                //   width: 20,
                                                // ),
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
                                                // const SizedBox(
                                                //   width: 20,
                                                // ),
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

                                                Container(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      primary: greenPrimary,
                                                      onPrimary: whitePrimary,
                                                      shadowColor: shadowColor,
                                                      elevation: 3,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      minimumSize: const Size(100, 40), //////// HERE
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext context) => PendukungTeampage()));
                                                    },
                                                    child:    jumlahpendukung != 0
                                                        ? Text(
                                                      'Total : ' + CurrencyFormat.convertToIdr(jumlahpendukung, 0),
                                                      style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
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
                                                ),
                                                // TextButton(
                                                //   onPressed: () {
                                                //
                                                //     Navigator.push(
                                                //         context,
                                                //         MaterialPageRoute(
                                                //             builder: (BuildContext context) => PendukungTeampage()));
                                                //   },
                                                //   child:
                                                //   jumlahpendukung != 0
                                                //       ? Text(
                                                //     'Total : ' + CurrencyFormat.convertToIdr(jumlahpendukung, 0),
                                                //     style: const TextStyle(
                                                //       fontFamily: 'poppins',
                                                //       fontSize: 14,
                                                //       fontWeight: FontWeight.bold,
                                                //       color: greenPrimary,
                                                //     ),
                                                //   )
                                                //       : Text(
                                                //     "0",
                                                //     style: const TextStyle(
                                                //       fontFamily: 'poppins',
                                                //       fontSize: 12,
                                                //       fontWeight: FontWeight.bold,
                                                //       color: textPrimary,
                                                //     ),
                                                //   )
                                                // ),

                                              ],
                                            ),

                                          ),

                                        ]
                                    ),
                                  ),
                                  Visibility(
                                    visible: visiblejmlpendukungpendukung,
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
                                                Container(
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary: greenPrimary,
                                                        onPrimary: whitePrimary,
                                                        shadowColor: shadowColor,
                                                        elevation: 3,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                        minimumSize: const Size(100, 40), //////// HERE
                                                      ),
                                                      onPressed: () async {
                                                        SharedPreferences prefs =
                                                        await SharedPreferences.getInstance();
                                                        prefs.setString(
                                                            'nohppendukungpendukungg', nohpAkun);

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext context) => PendukungPendukungpage()));
                                                      },
                                                      child:    jumlahpendukungpendukung != 0
                                                          ? Text(
                                                        'Total : ' + CurrencyFormat.convertToIdr(jumlahpendukungpendukung, 0),
                                                        style: const TextStyle(
                                                          fontFamily: 'poppins',
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
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
                                                ),
                                                // TextButton(
                                                //     onPressed: () async {
                                                //       SharedPreferences prefs =
                                                //           await SharedPreferences.getInstance();
                                                //       prefs.setString(
                                                //           'nohppendukungpendukung', nohpAkun);
                                                //
                                                //       Navigator.push(
                                                //           context,
                                                //           MaterialPageRoute(
                                                //               builder: (BuildContext context) => PendukungPendukungpage()));
                                                //     },
                                                //     child:
                                                //     jumlahpendukungpendukung != 0
                                                //         ? Text(
                                                //       '--> Total : ' + CurrencyFormat.convertToIdr(jumlahpendukungpendukung, 0),
                                                //       style: const TextStyle(
                                                //         fontFamily: 'poppins',
                                                //         fontSize: 15,
                                                //         fontWeight: FontWeight.bold,
                                                //         color: greenPrimary,
                                                //       ),
                                                //     )
                                                //         : Text(
                                                //       "0",
                                                //       style: const TextStyle(
                                                //         fontFamily: 'poppins',
                                                //         fontSize: 12,
                                                //         fontWeight: FontWeight.bold,
                                                //         color: textPrimary,
                                                //       ),
                                                //     )
                                                // ),

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
                                  const SizedBox(
                                    height: 15,
                                  ),

                                  Center(
                                    child:
                                    InkWell(
                                      child: Container(
                                        child:     fotoc1saksi.isEmpty
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
                                            : Container(
                                          width: 250,
                                          height: 150,
                                          child:Image.network(
                                            fotoc1saksi,
                                            width: 250,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),),),
                                      onTap: () async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setString("fotoview",fotoc1saksi);
                                        prefs.setString("navfoto", "relawan");
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const ZoomableImage(),
                                          ),
                                        );
                                      },
                                    ),

                                  ),

                                  ]
                              ),
                              ),

                                  Visibility(
                                    visible: visibleaktif,
                                    child:
                                    Column(

                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          FadeInUp(
                                            duration: const Duration(milliseconds: 1300),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 10),
                                              child:
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: gradient6,
                                                  onPrimary: whitePrimary,
                                                  shadowColor: shadowColor,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  minimumSize: const Size(150, 40), //////// HERE
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    visiblealasankeluar = true;

                                                  });
                                                },
                                                child: Text(
                                                  'Keluar Dari Dukungan',
                                                  style: TextStyle(
                                                      fontFamily: 'poppins',
                                                      color: whitePrimary,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                               Visibility(
                                              visible: visiblealasankeluar,
                                              child:
                                                    Container(
                                                  margin: EdgeInsets.only(left: 10, right: 10),
                                                  alignment: Alignment.topLeft,
                                                  padding: const EdgeInsets.only(bottom: 0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey),
                                                    color: whitePrimary,
                                                    borderRadius: BorderRadius.circular(20),
                                                    boxShadow: const [],
                                                  ),
                                                  child:
                                                  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 20, horizontal: 5),
                                                        child:   Text(
                                                          'Alasan Keluar Dari Dukungan',
                                                          style: TextStyle(
                                                              fontFamily: 'poppins',
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 11),
                                                        ),),
                                                      Container(
                                                          alignment: Alignment.topLeft,
                                                          margin:
                                                          EdgeInsets.only(left: 10, top: 5, right: 10),
                                                          // padding: EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(15),
                                                              border: Border.all(color: greenPrimary)),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                  alignment: Alignment.center,
                                                                  margin: const EdgeInsets.only(left: 5.0),
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      // Show the dropdown options when the text field is tapped
                                                                      _showOptionsalasankeluar(
                                                                          context);
                                                                    },
                                                                    child: Icon(
                                                                      Icons.arrow_drop_down_outlined,
                                                                      size: 30,
                                                                      color: greenPrimary,
                                                                    ),
                                                                  )),
                                                              Container(
                                                                width: 200,

                                                                color: whitePrimary,
                                                                alignment: Alignment.center,
                                                                margin: const EdgeInsets.only(
                                                                    left: 5.0, right: 0.0),
                                                                child: TextFormField(
                                                                  style: const TextStyle(
                                                                      fontFamily: 'poppins',
                                                                      color: greenPrimary,
                                                                      fontSize: 11,
                                                                      fontWeight: FontWeight.bold),
                                                                  controller: alasankeluarconterolel,
                                                                  decoration: const InputDecoration(
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide:
                                                                      BorderSide(color: Colors.white),
                                                                    ),
                                                                    focusedBorder: UnderlineInputBorder(
                                                                      borderSide:
                                                                      BorderSide(color: Colors.white),
                                                                    ),
                                                                    fillColor: whitePrimary,
                                                                    hintText: "Pilih...",
                                                                    hintStyle:
                                                                    TextStyle(color: greyPrimary),
                                                                    filled: true,
                                                                  ),
                                                                  keyboardType: TextInputType.text,
                                                                  autofocus: false,
                                                                  textInputAction: TextInputAction.done,
                                                                  textCapitalization: TextCapitalization.words,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                      Visibility(
                                                        visible: visiblealasanvalid,
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                                                          child: Text(
                                                            'Masukkan Alasan Keluar Dari Dukungan !',
                                                            style: TextStyle(
                                                                fontFamily: 'poppins',
                                                                color: Colors.red,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 11),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                   Padding(
                                                     padding:
                                                     EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                                                     child:
                                                     ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          primary: gradient6,
                                                          onPrimary: whitePrimary,
                                                          shadowColor: shadowColor,
                                                          elevation: 3,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          minimumSize: const Size(70, 30), //////// HERE
                                                        ),
                                                        onPressed: () {
                                                          setState(() {

                                                            if(alasankeluarconterolel.text.isEmpty){
                                                              visiblealasanvalid= true;

                                                            }else{
                                                              visiblealasanvalid= false;
                                                              keluardaridukungan();
                                                            }


                                                          });
                                                        },
                                                        child: Text(
                                                          'Kirim',
                                                          style: TextStyle(
                                                              fontFamily: 'poppins',
                                                              color: whitePrimary,
                                                              fontSize: 11
                                                          ),
                                                        ),
                                                      ),
                                                   ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),

                                                    ],
                                                  )
                                                ),



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

        )
      ],
    );
  }


  void _showOptionsalasankeluar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(),
          content: DropdownButton<String>(
            value: dropdownalasankeluar,
            onChanged: (newValue) {
              setState(() {
                dropdownalasankeluar = newValue!;
                alasankeluarconterolel.text = dropdownalasankeluar;
              });
              Navigator.of(context).pop(); // Close the dialog
            },
            items:
            itemsalasankeluar.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
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
            jmlpemilihan = jsonResponse['data']['usrjpm'];
            bidangutama = jsonResponse['data']['usrbu'];
            usrhrc =  jsonResponse['data']['usrhrc'];
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
                visiblebidanguatama = true;
                visibletargetdukungan = true;
                targetpendukung = (jsonResponse['data']['usrtpd']);
                status = "Relawan";
                visibledatapendukung = false;
              });
            } else if (jsonResponse['data']['usrsts'] == "S") {
              setState(() {

                cekdatasaksi();
                visiblebidanguatama = false;
                visiblebidanguatama = false;
                status = "Saksi";
                visibledatapendukung = false;
                visibletargetdukungan = false;
              });
            } else if (jsonResponse['data']['usrsts'] == "A") {
              setState(() {


                visiblebidanguatama = false;
                status = "Admin";
                visibledatapendukung = false;
                visibletargetdukungan = false;
              });
            }  else if (jsonResponse['data']['usrsts'] == "P") {
              setState(() {
                cektotpendukung();

                visiblebidanguatama = false;
                visibletargetdukungan = true;
                status = "Pendukung";
                targetpendukung = (jsonResponse['data']['usrtpd']);
                alasancaleg =  (jsonResponse['data']['usrapc']);
                bantucaleg = (jsonResponse['data']['usrbpd']);
                programutama = (jsonResponse['data']['usrput']);
                siapatargetpendukung = (jsonResponse['data']['usrtrp']);
                visibledatapendukung = true;
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

            // statuskawin = jsonResponse['data']['usrsp'];
            // agama = jsonResponse['data']['usragm'];
            // pekerjaan = jsonResponse['data']['usrpkj'];
            kodecaleg = jsonResponse['data']['usrnm'];
            nikakun = jsonResponse['data']['usrnik'];
            emailakun = jsonResponse['data']['usrema'];
            if(jsonResponse['data']['usrvt'] == "T"){
             
               setState(() {
                 statuspindahcaleg = "Tidak";
                 visiblepindahpartai = true;
               });
     
            }else if(jsonResponse['data']['usrvt'] == "Y"){
              setState(() {
                statuspindahcaleg = "Ya";
                visiblepindahpartai = true;
              });
      
            }else{
              setState(() {
                statuspindahcaleg  = "-";
                visiblepindahpartai = false;
              });
            }
              
            

            if(jsonResponse['data']['usrvt2'] == "T"){
              setState(() {
                
                statuspindahpartai = "Tidak";
                visiblepindahpartai = true;
              });
         
            }else if(jsonResponse['data']['usrvt2'] == "Y"){
              setState(() {
                statuspindahpartai = "Ya";
                visiblepindahpartai = true;
              });
            }else{
              setState(() {
                statuspindahpartai = "-";
                visiblepindahpartai = false;
              });
            }

            fotoktp = jsonResponse['data']['usrfktp'];

          });
        } else {}
      }
    } else {}
  }

  cektotpendukung() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    String nohprelawanp = prefs.getString('nohprelawancalegpendukung')!;
    Map data = {
      'usrkc': kodecaleg,
      'usrhpr': nohprelawanp,
      'usrhp': nohprelawanp,
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

          // prefs.remove(
          //     'nohprelawan');
          // prefs.remove(
          //     'nohprelawancalegpendukung');

        });
      }
    }
  }

  cektotpendukungrelawan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    String nohprelawan = prefs.getString('nohprelawancaleg')!;
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
        if(jsonResponse['datarelawan'] != false){
          setState(() {

            if(jsonResponse['jumlahpendukung'] == 0){
              setState(() {
                visiblejmlpendukung = false;
                visiblejmlpendukungpendukung = false;
              });

            }else{
              setState(() {
                visiblejmlpendukung = true;
                visiblejmlpendukungpendukung = false;
                jumlahpendukung = jsonResponse['jumlahpendukung'];
              });

            }

          });
        }else{
          setState(() {
            visiblejmlpendukung = false;
            // visiblejmlpendukungpendukung = false;
          });
        }

      }
    }
  }

  cektotpendukungpendukung(nohppendukung) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {
      'usrkc': kodecaleg,
      'usrkp': nohppendukung,

    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmlpendukung2.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if(jsonResponse['datapendukung'] != false) {

          setState(() {
            if(jsonResponse['jumlahpendukung'] == 0){
              setState(() {
                visiblejmlpendukung = false;
                visiblejmlpendukungpendukung = false;
              });

            }else{
              setState(() {
                visiblejmlpendukungpendukung = true;
                jumlahpendukungpendukung = jsonResponse['jumlahpendukung'];

                visiblejmlpendukung = false;
              });

            }

          });
        }

      }else{
        setState(() {
          // visiblejmlpendukung = false;
          visiblejmlpendukungpendukung = false;

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

            // prefs.remove(
            //     'nohprelawansaksi');
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



  keluardaridukungan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeformat = DateFormat("HH:mm:ss");
    String createDate = dateFormat.format(DateTime.now());
    String createtime = timeformat.format(DateTime.now());

    Map data = {
      'usrhp': nohpAkun,
      'usrals': alasankeluarconterolel.text,
      'usrrdt': createDate,
      'usrrtm': createtime,

    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/updateact.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return const CustomNavBar();
            }));

      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Gagal !")));
      }
    } else {}
  }


}
