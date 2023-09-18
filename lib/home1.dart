import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/berita/saran.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/team/relawan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ayoleg/account.dart';
import 'package:ayoleg/component/colors/colors.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_update/in_app_update.dart';
import 'dart:io';

class MyHome extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING";
  const MyHome({Key? key}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}

const _url =
    'https://play.google.com/store/apps/details?id=com.ayolegid';

class _MyHomeState extends State<MyHome> {
  List items = [];
  List itemsrelawan = [];
  List itemspendukung = [];

  bool isAppbarCollapsing = false;
  String id = "";
  String id2 = "";
  bool verifFoto = true;

  bool errorFoundInImageLoad = false;

  bool isLoadingsc = true;
  String nohpAkun = "";
  String fotoAkun = "";
  String namaAkun = "";
  String calonlegislatif = "";
  String daerahpemilihan = "";
  String akunverifikasi = "";
  String kodecaleg = "";
  String usrsts = "";
  String Statusreferal = "";

  String statusFoto = "";
  String calonlegis = "";
  int saldoUserr = 0;
  String trans = "";
  String fotocaleg = "";
  String namacaleg = "";
  String usrtkccaleg = "";
  String kodeadmin = "";
  String koderelawan = "";
  String kodesaksi = "";
  String targetsuara = "";
  String targetrelawan = "";
  String targetpendukung = "";
  String jumlahkursi = "";

  String visicaleg = "";
  String misicaleg = "";
  String programcaleg = "";
  String yotubecaleg = "";

  String walletOvo = "Hubungkan";
  String walletLink = "Hubungkan";
  String walletDana = "Hubungkan";
  String walletShopee = "Hubungkan";

  String jobadmin = "";
  String jobsaksi = "";
  String jobrelawan = "";
  String jobpendukung = "";
  String kdweb = "-";

  bool colorOvo = false;
  bool colorLink = false;
  bool colorDana = false;
  bool colorShopee = false;
  bool visiblekodesaksiakun = false;
  bool visiblekoderelawanakun = false;
  bool visiblekodadmineakun = false;
  bool visibletargetpendukungakun = false;
  bool visiblenohpakun = false;
  bool visiblejobadmin = false;
  bool visiblejobrelawan = false;
  bool visiblejobpendukung = false;
  bool visiblejobsaksi = false;
  bool visibleanggran = false;
  bool visiblesaran = false;

  late SharedPreferences sharedPrefs;

  //ShowCase
  final GlobalKey globalKeyOne = GlobalKey();
  final GlobalKey globalKeyTwo = GlobalKey();
  final GlobalKey globalKeyThree = GlobalKey();
  final GlobalKey globalKeyFour = GlobalKey();
  final GlobalKey globalKeyFive = GlobalKey();

  YoutubePlayerController? _controller;
  String Fotobanner1 = "";
  String Fotobanner2 = "";
  String Fotobanner3 = "";
  String Fotobanner4 = "";
  String Fotobanner5 = "";
  String jumlahdonasi = "";
  String anggaran = "";
  String janjipolitik = "";
  String showcase = "";

  int startIndex = 2; // Index of 'W'

  String nohpsubstring="";
  @override
  void initState() {
    _startUpdateService();
    cekkodecaleg();
    cektotkeuangan();
    cekcalegadmin();

    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);

        // showcase = prefs.getString('showcase')!;
        fotoAkun = prefs.getString('fotoregister')!;
        namaAkun = prefs.getString('namaregister')!;
        nohpAkun = prefs.getString('nohpregister')!;

        usrsts = prefs.getString('status')!;
        fotocaleg = prefs.getString('fotocaleg')!;
        namacaleg = prefs.getString('namacaleg')!;
        usrtkccaleg = prefs.getString('usrtkccaleg')!;
        daerahpemilihan = prefs.getString('daerahpemilihan')!;
        kodecaleg = prefs.getString('kodecaleg')!;
        targetpendukung = prefs.getString('targetpendukunghome')!;
        kdweb = prefs.getString('kdweb')!;
        // fotocaleg = prefs.getString('fotocaleg')!;
        // namacaleg = prefs.getString('namacaleg')!;
        // usrtkccaleg = prefs.getString('usrtkccaleg')!;
        // daerahpemilihan = prefs.getString('daerahpemilihan')!;
        // kodeadmin = prefs.getString('kodeadmin')!;
        // koderelawan = prefs.getString('koderelawan')!;
        // kodesaksi = prefs.getString('kodesaksi')!;
        // visicaleg = prefs.getString('visicaleg')!;
        // misicaleg = prefs.getString('misicaleg')!;
        // kodecaleg = prefs.getString('kodecaleg')!;
        // programcaleg = prefs.getString('programcaleg')!;
        yotubecaleg = prefs.getString('yotubecaleg')!;
        // anggaran = prefs.getString('anggaran')!;
        // janjipolitik = prefs.getString('janjipolitik')!;

        jobadmin = prefs.getString('jobadmin')!;
        jobsaksi = prefs.getString('jobsaksi')!;
        jobrelawan = prefs.getString('jobrelawan')!;
        jobpendukung = prefs.getString('jobpendukung')!;

        // if(showcase=="1"){
        //   prefs.setString("showcase", "2");
        //   _isFirstLaunch().then((result) {
        //     if (result)
        //       ShowCaseWidget.of(context).startShowCase(
        //           [globalKeyOne,globalKeyTwo, globalKeyThree, globalKeyFour]);
        //   });
        // }


        _controller = YoutubePlayerController(
          initialVideoId: yotubecaleg,
          flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: false,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: true,
          ),
        );


        fetchData(kodecaleg);
        fetchDataRelawanterbaik(kodecaleg);
        fetchDataPendukungterbaik(kodecaleg);

        cekiddpl1(kodecaleg);
        cekiddpl2(kodecaleg);
        cekiddpl3(kodecaleg);
        cekiddpl4(kodecaleg);
        cekiddpl5(kodecaleg);
        if (usrsts == "Admin") {
          setState(() {
            visiblekodesaksiakun = true;
            visiblekoderelawanakun = true;
            visiblekodadmineakun = true;
            visiblenohpakun = false;
            visibletargetpendukungakun = false;

            visiblejobadmin = true;
            visiblejobrelawan = false;
            visiblejobpendukung = false;
            visiblejobsaksi = false;
            visiblesaran = true;
            visibleanggran = true;
          });
        } else if (usrsts == "Calon Legislatif") {
          setState(() {
            visiblekodesaksiakun = true;
            visiblekoderelawanakun = true;
            visiblekodadmineakun = true;
            visiblenohpakun = false;
            visibletargetpendukungakun = false;

            visiblejobadmin = true;
            visiblejobrelawan = true;
            visiblejobpendukung = true;
            visiblejobsaksi = true;
            visiblesaran = true;
            visibleanggran = true;
          });
        } else if (usrsts == "Relawan") {
          setState(() {
            visiblekodesaksiakun = false;
            visiblekoderelawanakun = false;
            visiblenohpakun = true;
            visiblekodadmineakun = false;
            visibletargetpendukungakun = true;
            visiblejobadmin = false;
            visiblejobrelawan = true;
            visiblejobpendukung = false;
            visiblejobsaksi = false;
            visiblesaran = false;
            visibleanggran = false;
          });
        } else if (usrsts == "Saksi") {
          setState(() {
            visiblekodesaksiakun = false;
            visiblekoderelawanakun = false;
            visiblekodadmineakun = false;
            visiblenohpakun = false;
            visibletargetpendukungakun = false;
            visiblejobadmin = false;
            visiblejobrelawan = false;
            visiblejobpendukung = false;
            visiblejobsaksi = true;
            visiblesaran = false;
            visibleanggran = false;
          });
        } else {
          setState(() {
            visiblekodesaksiakun = false;
            visiblekoderelawanakun = false;
            visiblekodadmineakun = false;
            visiblenohpakun = true;
            visibletargetpendukungakun = true;
            visiblejobadmin = false;
            visiblejobrelawan = false;
            visiblejobpendukung = true;
            visiblejobsaksi = false;
            visiblesaran = false;
            visibleanggran = false;
          });
        }



        Fotobanner1 = prefs.getString('Fotobanner1')!;
        Fotobanner2 = prefs.getString('Fotobanner2')!;
        Fotobanner3 = prefs.getString('Fotobanner3')!;
        Fotobanner4 = prefs.getString('Fotobanner4')!;
        Fotobanner5 = prefs.getString('Fotobanner5')!;


      nohpsubstring = nohpAkun.substring(startIndex);
      });
    });

    super.initState();
  }



  void play() async {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoadingsc = false;
      });
    });
  }

  var ctime;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return
      WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(

          body:
          Stack(
              children: [

              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                        0.2,
                        0.5,
                        0.8,
                        0.7
                      ],
                          colors: [
                        gradient1,
                            gradient2,
                            gradient3,
                            gradient5
                      ])),
                  child:
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child:
                    Stack(
                        children: [


                          Column(
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              datajumlahdonasi(),
                              SizedBox(
                                height: 5,
                              ),
                              datanewdukungan(),
                              SizedBox(
                                height: 10,
                              ),
                              datarelawanterbaik(),
                              SizedBox(
                                height: 10,
                              ),
                              datapendukungterbaik(),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: visiblesaran,
                                child:
                              FadeInUp(
                                duration: const Duration(milliseconds: 1300),
                                child: Container(
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 30, vertical: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: greenPrimary,
                                      onPrimary: whitePrimary,
                                      shadowColor: shadowColor,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      minimumSize: const Size(200, 40), //////// HERE
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                const Saranpage()));
                                      });
                                    },
                                    child: Text(
                                      'Saran Untuk Caleg',
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          color: whitePrimary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              datacalegprof(),
                              SizedBox(
                                height: 10,
                              ),
                              datajobdesc(),
                              SizedBox(
                                height: 10,
                              ),
                              visimisi(),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                      const EdgeInsets.only(top: 20, bottom: 20),
                                      alignment: Alignment.center,
                                      // height: 30,
                                      width: 350,
                                      child: yotubecaleg.isNotEmpty
                                          ? YoutubePlayer(
                                        controller: _controller!,
                                        liveUIColor: Colors.amber,
                                        showVideoProgressIndicator: false,
                                      )
                                          : DefaultTextStyle(
                                        style: const TextStyle(
                                            fontSize: 30.0,
                                            color: greenPrimary),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TyperAnimatedText('•••••••••'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                            ],
                          ),

                        ]))),
    Stack(
    children: [
                Container(
                  // margin: const EdgeInsets.only(
                  //     top: 10),
                  height: 120.0,
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
                InkWell(
                  child:
    Showcase(
    key: globalKeyOne,
    description: 'Ketuk Disini Untuk Melihat Akun Anda',
    descTextStyle: TextStyle(fontFamily: 'poppins'),
    child:
                  Container(
                      height: 100,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          color: putihprimary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: shadowColor2, width: 1)),
                      child:
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _controller!.pause();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AccountPage()));
                              },
                              // child: ClipRRect(
                              //   borderRadius: BorderRadius.circular(100),
                              //   child: Container(
                              //     width: 80,
                              //     height: 80,
                              //     child: Image.asset("assets/images/ftgelby.jpg"),
                              //   ),
                              // )
                              child:
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                // width: 50,
                                // height: 50,
                                // Replace with your own item widget
                                child:
                                ClipOval(
                                  // borderRadius:
                                  // BorderRadius.circular(150),
                                  child: Image.network(
                                    // widget.question.fileInfo[0].remoteURL,
                                    fotoAkun,
                                    width: 80,
                                    height: 80,
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
                              )

                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    namaAkun,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 0, top: 5),
                                    child: Text(
                                      usrsts,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 0, top: 5),
                                    child: Text(
                                      daerahpemilihan,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Visibility(
                                    visible: visibletargetpendukungakun,
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 0, top: 5),
                                        child:targetpendukung.isNotEmpty
                                            ? Text(

                                          "Target Pendukung : "+CurrencyFormat.convertToIdr(int.parse(targetpendukung), 0),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'poppins',
                                              color: gradient6,
                                              fontWeight: FontWeight.bold
                                          ),
                                          overflow:
                                          TextOverflow.ellipsis,
                                        )
                                            : Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
                                          overflow:
                                          TextOverflow.ellipsis,
                                        )
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ]),
                          )
                        ],
                      )
                  )),

                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountPage()));
                  },
                ),
    ]),
    //             Container(
    //               child:Column(children: [
    //             Container(
    //             decoration: BoxDecoration(
    //             color: gradient2,
    //             ),
    //                 child:Column(children: [
    //                   // ImageSlideshow(
    //                   //   // width: size.width,
    //                   //   // height: size.width,
    //                   //   height: 250,
    //                   //   initialPage: 0,
    //                   //   children: [
    //                   //     Column(
    //                   //       children: [
    //                   //         SizedBox(
    //                   //           height: 250,
    //                   //           // height: size.width * 0.5,
    //                   //           // width: size.width * 0.7,
    //                   //           child:   Image.network(
    //                   //             // widget.question.fileInfo[0].remoteURL,
    //                   //             Fotobanner1,
    //                   //             // width: 220,
    //                   //             // height: 220,
    //                   //             //
    //                   //             loadingBuilder: (context, child, loadingProgress) =>
    //                   //             (loadingProgress == null)
    //                   //                 ? child
    //                   //                 : Center(
    //                   //               child: CircularProgressIndicator(),
    //                   //             ),
    //                   //             errorBuilder: (context, error, stackTrace) {
    //                   //               Future.delayed(
    //                   //                 Duration(milliseconds: 0),
    //                   //                     () {
    //                   //                   if (mounted) {
    //                   //                     setState(() {
    //                   //                       CircularProgressIndicator();
    //                   //                     });
    //                   //                   }
    //                   //                 },
    //                   //               );
    //                   //               return SizedBox.shrink();
    //                   //             },
    //                   //           ),
    //                   //
    //                   //         ),
    //                   //       ],
    //                   //     ),
    //                   //     Column(
    //                   //       children: [
    //                   //         SizedBox(
    //                   //           height: 250,
    //                   //           // height: size.width * 0.5,
    //                   //           // width: size.width * 0.7,
    //                   //           child:Image.network(
    //                   //             // widget.question.fileInfo[0].remoteURL,
    //                   //             Fotobanner2,
    //                   //             // width: 220,
    //                   //             // height: 220,
    //                   //             //
    //                   //             loadingBuilder: (context, child, loadingProgress) =>
    //                   //             (loadingProgress == null)
    //                   //                 ? child
    //                   //                 : Center(
    //                   //               child: CircularProgressIndicator(),
    //                   //             ),
    //                   //             errorBuilder: (context, error, stackTrace) {
    //                   //               Future.delayed(
    //                   //                 Duration(milliseconds: 0),
    //                   //                     () {
    //                   //                   if (mounted) {
    //                   //                     setState(() {
    //                   //                       CircularProgressIndicator();
    //                   //                     });
    //                   //                   }
    //                   //                 },
    //                   //               );
    //                   //               return SizedBox.shrink();
    //                   //             },
    //                   //           ),
    //                   //         ),
    //                   //       ],
    //                   //     ),
    //                   //     Column(
    //                   //       children: [
    //                   //         SizedBox(
    //                   //           height: 250,
    //                   //           // height: size.width * 0.5,
    //                   //           // width: size.width * 0.7,
    //                   //           child: Image.network(
    //                   //             // widget.question.fileInfo[0].remoteURL,
    //                   //             Fotobanner3,
    //                   //             // width: 220,
    //                   //             // height: 220,
    //                   //             //
    //                   //             loadingBuilder: (context, child, loadingProgress) =>
    //                   //             (loadingProgress == null)
    //                   //                 ? child
    //                   //                 : Center(
    //                   //               child: CircularProgressIndicator(),
    //                   //             ),
    //                   //             errorBuilder: (context, error, stackTrace) {
    //                   //               Future.delayed(
    //                   //                 Duration(milliseconds: 0),
    //                   //                     () {
    //                   //                   if (mounted) {
    //                   //                     setState(() {
    //                   //                       CircularProgressIndicator();
    //                   //                     });
    //                   //                   }
    //                   //                 },
    //                   //               );
    //                   //               return SizedBox.shrink();
    //                   //             },
    //                   //           ),
    //                   //         ),
    //                   //       ],
    //                   //     ),
    //                   //     Column(
    //                   //       children: [
    //                   //         SizedBox(
    //                   //           height: 250,
    //                   //           // height: size.width * 0.5,
    //                   //           // width: size.width * 0.7,
    //                   //           child:Image.network(
    //                   //             // widget.question.fileInfo[0].remoteURL,
    //                   //             Fotobanner4,
    //                   //             // width: 220,
    //                   //             // height: 220,
    //                   //             //
    //                   //             loadingBuilder: (context, child, loadingProgress) =>
    //                   //             (loadingProgress == null)
    //                   //                 ? child
    //                   //                 : Center(
    //                   //               child: CircularProgressIndicator(),
    //                   //             ),
    //                   //             errorBuilder: (context, error, stackTrace) {
    //                   //               Future.delayed(
    //                   //                 Duration(milliseconds: 0),
    //                   //                     () {
    //                   //                   if (mounted) {
    //                   //                     setState(() {
    //                   //                       CircularProgressIndicator();
    //                   //                     });
    //                   //                   }
    //                   //                 },
    //                   //               );
    //                   //               return SizedBox.shrink();
    //                   //             },
    //                   //           ),
    //                   //         ),
    //                   //       ],
    //                   //     ),
    //                   //     Column(
    //                   //       children: [
    //                   //         SizedBox(
    //                   //           height: 250,
    //                   //           // height: size.width * 0.5,
    //                   //           // width: size.width * 0.7,
    //                   //           child: Image.network(
    //                   //             // widget.question.fileInfo[0].remoteURL,
    //                   //             Fotobanner5,
    //                   //             // width: 220,
    //                   //             // height: 220,
    //                   //             //
    //                   //             loadingBuilder: (context, child, loadingProgress) =>
    //                   //             (loadingProgress == null)
    //                   //                 ? child
    //                   //                 : Center(
    //                   //               child: CircularProgressIndicator(),
    //                   //             ),
    //                   //             errorBuilder: (context, error, stackTrace) {
    //                   //               Future.delayed(
    //                   //                 Duration(milliseconds: 0),
    //                   //                     () {
    //                   //                   if (mounted) {
    //                   //                     setState(() {
    //                   //                       CircularProgressIndicator();
    //                   //                     });
    //                   //                   }
    //                   //                 },
    //                   //               );
    //                   //               return SizedBox.shrink();
    //                   //             },
    //                   //           ),
    //                   //         ),
    //                   //       ],
    //                   //     ),
    //                   //
    //                   //   ],
    //                   //   onPageChanged: (value) {
    //                   //     // print('Page changed: $value');
    //                   //   },
    //                   //   autoPlayInterval: 5000,
    //                   //   isLoop: true,
    //                   // ),
    //
    //
    // ],)
    //
    //
    //             ),
    //
    //
    //             ],)
    //
    //
    //             ),


        ]))
    );
  }
  Widget datajumlahdonasi() {
    // final size = MediaQuery.of(context).size;
    return
      Showcase(
        key: globalKeyTwo,
        description: 'Total Donasi',
        descTextStyle: TextStyle(fontFamily: 'poppins'),
    child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only( top: 10),
        child:
          Text(
            "Total Donasi",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'poppins',
              color: gradient6,
              fontWeight: FontWeight.bold
            ),
            overflow:
            TextOverflow.ellipsis,
          ),
        ),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only( top: 5),
            child: jumlahdonasi.isNotEmpty
                ? Text(
              "Rp "+CurrencyFormat.convertToIdr(int.parse(jumlahdonasi), 0),
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'poppins',
                color: gradient6,
                  fontWeight: FontWeight.bold
              ),
              overflow:
              TextOverflow.ellipsis,
            )
                : Text(
              "0",
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'poppins',
                color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
              overflow:
              TextOverflow.ellipsis,
            )
          ),
        ]));
  }
  Widget datanewdukungan() {
    // final size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              "Dukungan Terbaru",
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'poppins',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
          Container(
              height: 50,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(left: 20, top: 5, right: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];

                  return
                    InkWell(
                      child:
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      // width: 50,
                      // height: 50,
                      // Replace with your own item widget
                      child:  ClipOval(
                        // borderRadius:
                        // BorderRadius.circular(150),
                        child: Image.network(
                          // widget.question.fileInfo[0].remoteURL,
                          item['usrft'],
                          width: 50,
                          height: 50,
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
                  //       onTap: () async {
                  //   setState(() async {
                  //     SharedPreferences prefs =
                  //     await SharedPreferences
                  //         .getInstance();
                  //     prefs.setString(
                  //         'nohprelawan',
                  //         item['usrhp']);
                  //     prefs.setString(
                  //         'nohprelawancaleg', "");
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) =>
                  //             const RelawanPage()));
                  //     // Navigator.pop(context);
                  //   });
                  //
                  // },
                    );
                },
              )),
        ]);
  }

  Widget datarelawanterbaik() {
    // final size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              "Relawan Terbaik",
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'poppins',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
          Container(
              height: 50,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(left: 20, top: 5, right: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemsrelawan.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = itemsrelawan[index];

                  return
                    InkWell(
                      child:
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        // width: 50,
                        // height: 50,
                        // Replace with your own item widget
                        child:  ClipOval(
                          // borderRadius:
                          // BorderRadius.circular(150),
                          child: Image.network(
                            // widget.question.fileInfo[0].remoteURL,
                            item['usrft'],
                            width: 50,
                            height: 50,
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
                      // onTap: () async {
                      //   setState(() async {
                      //     SharedPreferences prefs =
                      //     await SharedPreferences
                      //         .getInstance();
                      //     prefs.setString(
                      //         'nohprelawan',
                      //         item['usrhp']);
                      //     prefs.setString(
                      //         'nohprelawancaleg', "");
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //             const RelawanPage()));
                      //     // Navigator.pop(context);
                      //   });
                      //
                      // },
                    );
                },
              )),
        ]);
  }

  Widget datapendukungterbaik() {
    // final size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              "Pendukung Terbaik",
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'poppins',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
          Container(
              height: 50,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(left: 20, top: 5, right: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemspendukung.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = itemspendukung[index];

                  return

                    InkWell(
                      child:
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        // width: 50,
                        // height: 50,
                        // Replace with your own item widget
                        child:  ClipOval(
                          // borderRadius:
                          // BorderRadius.circular(150),
                          child: Image.network(
                            // widget.question.fileInfo[0].remoteURL,
                            item['usrft'],
                            width: 50,
                            height: 50,
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
                      // onTap: () async {
                      //   setState(() async {
                      //     SharedPreferences prefs =
                      //     await SharedPreferences
                      //         .getInstance();
                      //     prefs.setString(
                      //         'nohprelawan',
                      //         item['usrhp']);
                      //     prefs.setString(
                      //         'nohprelawancaleg', "");
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //             const RelawanPage()));
                      //     // Navigator.pop(context);
                      //   });
                      //
                      // },
                    );
                },
              )),
        ]);
  }

  Widget datacalegprof() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // width: 220,
            height: 250,
            margin: EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.center,
            child: Image.network(
              // widget.question.fileInfo[0].remoteURL,
              fotocaleg,
              // width: 220,
              // height: 220,
              //
              loadingBuilder: (context, child, loadingProgress) =>
                  (loadingProgress == null)
                      ? child
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
              errorBuilder: (context, error, stackTrace) {
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
          // fotocaleg.isEmpty
          //     ? Container(
          //     width: 20, height: 20, child: CircularProgressIndicator())
          //     : Container(
          //     alignment: Alignment.center,
          //     child: Image.network(
          //       fotocaleg,
          //       width: 220,
          //       height: 220,
          //       fit: BoxFit.cover,
          //     )),
          SizedBox(
            height: 10,
          ),
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
                  height: 13,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  // width: 100,
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          Icons.person,
                          color: greenPrimary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      namacaleg.isNotEmpty
                          ? Expanded(
                              child: Text(
                                namacaleg,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                            )
                          : DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 30.0, color: greenPrimary),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText('•••••••••'),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          Icons.location_city,
                          color: greenPrimary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      usrtkccaleg.isNotEmpty
                          ? Text(
                              "Calon Legislatif " + usrtkccaleg,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                              overflow: TextOverflow.clip,
                            )
                          : DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 30.0, color: greenPrimary),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText('•••••••••'),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: visiblekodadmineakun,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                Icons.people_alt_outlined,
                                color: greenPrimary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            kodeadmin.isNotEmpty
                                ? Text(
                                    "Kode Referal Admin " + kodeadmin,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimary,
                                    ),
                                    overflow: TextOverflow.clip,
                                  )
                                : DefaultTextStyle(
                                    style: const TextStyle(
                                        fontSize: 30.0, color: greenPrimary),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText('•••••••••'),
                                      ],
                                    ),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            // kodeadmin.isNotEmpty
                            //     ? Text(
                            //         "Kode Relawan " + koderelawan,
                            //         style: const TextStyle(
                            //           overflow: TextOverflow.ellipsis,
                            //           fontFamily: 'poppins',
                            //           fontSize: 13,
                            //           fontWeight: FontWeight.bold,
                            //           color: textPrimary,
                            //         ),
                            //         overflow: TextOverflow.clip,
                            //       )
                            //     : DefaultTextStyle(
                            //         style: const TextStyle(
                            //             fontSize: 30.0, color: greenPrimary),
                            //         child: AnimatedTextKit(
                            //           animatedTexts: [
                            //             TyperAnimatedText('•••••••••'),
                            //           ],
                            //         ),
                            //       ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            // kodeadmin.isNotEmpty
                            //     ? Text(
                            //         "Kode Saksi " + kodesaksi,
                            //         style: const TextStyle(
                            //           overflow: TextOverflow.ellipsis,
                            //           fontFamily: 'poppins',
                            //           fontSize: 13,
                            //           fontWeight: FontWeight.bold,
                            //           color: textPrimary,
                            //         ),
                            //         overflow: TextOverflow.clip,
                            //       )
                            //     : DefaultTextStyle(
                            //         style: const TextStyle(
                            //             fontSize: 30.0, color: greenPrimary),
                            //         child: AnimatedTextKit(
                            //           animatedTexts: [
                            //             TyperAnimatedText('•••••••••'),
                            //           ],
                            //         ),
                            //       ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: visiblekoderelawanakun,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                Icons.people_alt_outlined,
                                color: greenPrimary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            koderelawan.isNotEmpty
                                ? Text(
                                    "Kode Referal Relawan " + koderelawan,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimary,
                                    ),
                                    overflow: TextOverflow.clip,
                                  )
                                : DefaultTextStyle(
                                    style: const TextStyle(
                                        fontSize: 30.0, color: greenPrimary),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText('•••••••••'),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visiblenohpakun,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                Icons.people_alt_outlined,
                                color: greenPrimary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            nohpAkun.isNotEmpty
                                ? Text(
                                    "No. HP Referal  " + nohpsubstring,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimary,
                                    ),
                                    overflow: TextOverflow.clip,
                                  )
                                : DefaultTextStyle(
                                    style: const TextStyle(
                                        fontSize: 30.0, color: greenPrimary),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText('•••••••••'),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: visiblekodesaksiakun,
                      child:
                      Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                Icons.people_alt_outlined,
                                color: greenPrimary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            kodesaksi.isNotEmpty
                                ? Text(
                                    "Kode Referal Saksi " + kodesaksi,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimary,
                                    ),
                                    overflow: TextOverflow.clip,
                                  )
                                : DefaultTextStyle(
                                    style: const TextStyle(
                                        fontSize: 30.0, color: greenPrimary),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText('•••••••••'),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: visibleanggran,
                      child:
                    Container(
                      margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      // width: size.width * 04,
                      decoration: BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: const [

                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              Icons.money,
                              color: greenPrimary,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          anggaran.isNotEmpty
                              ? Text(
                            "Anggaran : Rp "+CurrencyFormat.convertToIdr(int.parse(anggaran), 0),
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                            overflow: TextOverflow.clip,
                          )
                              : Text(
                            "0",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'poppins',
                              color: Colors.white,
                            ),
                            overflow:
                            TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    ),


                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget datajobdesc() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: whitePrimary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [],
        ),
        child:
        Column(
          children: [
            const SizedBox(
              height: 13,
            ),
            Visibility(
                visible: visiblejobadmin,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      // width: 100,
                      decoration: BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: const [],
                      ),
                      child: Text(
                        "Tugas Admin",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      // width: 100,
                      decoration: BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: const [],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              Icons.description_outlined,
                              color: greenPrimary,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          jobadmin.isNotEmpty
                              ? Expanded(
                                  child: Text(
                                    jobadmin,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimary,
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                )
                              : DefaultTextStyle(
                                  style: const TextStyle(
                                      fontSize: 30.0, color: greenPrimary),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText('•••••••••'),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                )),
            Visibility(
              visible: visiblejobrelawan,
              child: Container(
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    // width: 100,
                    decoration: BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: const [],
                    ),
                    child: Text(
                      "Tugas Relawan",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: 'poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    // width: 100,
                    decoration: BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: const [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            Icons.description_outlined,
                            color: greenPrimary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        jobrelawan.isNotEmpty
                            ? Expanded(
                                child: Text(
                                  jobrelawan,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              )
                            : DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: 30.0, color: greenPrimary),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText('•••••••••'),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
            Visibility(
              visible: visiblejobpendukung,
              child: Container(
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    // width: 100,
                    decoration: BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: const [],
                    ),
                    child: Text(
                      "Tugas Pendukung",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: 'poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    // width: 100,
                    decoration: BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: const [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            Icons.description_outlined,
                            color: greenPrimary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        jobpendukung.isNotEmpty
                            ? Expanded(
                                child: Text(
                                  jobpendukung,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              )
                            : DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: 30.0, color: greenPrimary),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText('•••••••••'),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              )),
            ),
            Visibility(
              visible: visiblejobsaksi,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      // width: 100,
                      decoration: BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: const [],
                      ),
                      child: Text(
                        "Tugas Saksi",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      // width: 100,
                      decoration: BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: const [],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              Icons.description_outlined,
                              color: greenPrimary,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          jobsaksi.isNotEmpty
                              ? Expanded(
                                  child: Text(
                                    jobsaksi,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimary,
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                )
                              : DefaultTextStyle(
                                  style: const TextStyle(
                                      fontSize: 30.0, color: greenPrimary),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText('•••••••••'),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget visimisi() {
    return Container(
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
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                alignment: Alignment.center,
                child: Text(
                  "VISI",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    color: greenPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10,bottom: 10, top: 10),
                      alignment: Alignment.center,
                      // height: 30,
                      width: 280,
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0)),
                      ),
                      child: visicaleg.isNotEmpty
                          ? Text(
                              visicaleg,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'poppins',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.clip,
                            )
                          : DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 30.0, color: greenPrimary),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText('•••••••••'),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                alignment: Alignment.center,
                child: Text(
                  "MISI",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    color: greenPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10,bottom: 10, top: 10),
                      alignment: Alignment.center,
                      // height: 30,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0)),
                      ),
                      child: misicaleg.isNotEmpty
                          ? Text(
                              misicaleg,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'poppins',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.clip,
                            )
                          : DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 30.0, color: greenPrimary),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText('•••••••••'),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                alignment: Alignment.center,
                child: Text(
                  "PROGRAM DAN PENGALAMAN",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    color: greenPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10,bottom: 20, top: 10),
                      alignment: Alignment.center,
                      // height: 30,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0)),
                      ),
                      child: programcaleg.isNotEmpty
                          ? Text(
                              programcaleg,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'poppins',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.clip,
                            )
                          : DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 30.0, color: greenPrimary),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText('•••••••••'),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                alignment: Alignment.center,
                child: Text(
                  "JANJI/KONTRAK POLITIK",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    color: greenPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10,bottom: 20, top: 10),
                      alignment: Alignment.center,
                      // height: 30,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0)),
                      ),
                      child: janjipolitik.isNotEmpty
                          ? Text(
                        janjipolitik,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'poppins',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.clip,
                      )
                          : DefaultTextStyle(
                        style: const TextStyle(
                            fontSize: 30.0, color: greenPrimary),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('•••••••••'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),


              Container(
                margin:
                EdgeInsets.only(left: 20, right: 20, bottom: 10),
                // width: size.width * 04,
                decoration: BoxDecoration(
                  color: whitePrimary,
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: const [

                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    kdweb == '-'
                        ?   Text(
                      " ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'poppins',
                        color: Colors.white,
                      ),
                      overflow:
                      TextOverflow.ellipsis,
                    )
                        : TextButton(
                      onPressed: () async {
                        String url = kdweb;
                        var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                        if(urllaunchable){
                          await launch(url); //launch is from url_launcher package to launch URL
                        }else{
                          print("URL can't be launched.");
                        }
                        // String url =
                        //     kdweb;
                        // await launchUrl(Uri.parse(url));
                      },
                      child:  Text(
                        kdweb,
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  cekcalegadmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'usrkc': kodecaleg, 'usrsts': "C"};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekcaleg.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          prefs.setString('tokencaleg', jsonResponse['data']['tkn']);

        });
      } else {}
    }
  }

  Future pesantroblegaguan() {
    return showDialog(
        context: context,
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width / 5,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Image.asset(
                  'assets/trob.png',
                  height: 95,
                  width: 100,
                ),
                content: const Text(
                  "Fitur Dalam Proses Pengembangan !",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'poppins', fontSize: 17),
                ),
                actions: <Widget>[
                  // ignore: deprecated_member_use
                  TextButton(
                    child: const Text('OK',
                        style: TextStyle(fontFamily: 'poppins', fontSize: 13)),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  // ignore: deprecated_member_use
                ],
              ),
            ));
  }

  cekiddpl1(String kodecaleg) async {
    Map data = {
      'dplkc': kodecaleg,
      'iddpl': "1",
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekiddpl.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        String usrdpl = jsonResponse['data']["dpldpl"];
        Map data = {
          'usrkc': kodecaleg,
          'usrdpl': usrdpl,
          'iddpl': "1",
        };

        var response = await http.post(
            Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmldukungan.php"),
            body: data);
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          if (jsonResponse != null) {

          }
        }
      }
    }
  }

  cekiddpl2(String kodecaleg) async {
    Map data = {
      'dplkc': kodecaleg,
      'iddpl': "2",
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekiddpl.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        String usrdpl = jsonResponse['data']["dpldpl"];
        Map data = {
          'usrkc': kodecaleg,
          'usrdpl': usrdpl,
          'iddpl': "2",
        };

        var response = await http.post(
            Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmldukungan.php"),
            body: data);
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          if (jsonResponse != null) {}
        }
      }
    }
  }

  cekiddpl3(String kodecaleg) async {
    Map data = {
      'dplkc': kodecaleg,
      'iddpl': "3",
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekiddpl.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        String usrdpl = jsonResponse['data']["dpldpl"];
        Map data = {
          'usrkc': kodecaleg,
          'usrdpl': usrdpl,
          'iddpl': "3",
        };

        var response = await http.post(
            Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmldukungan.php"),
            body: data);
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          if (jsonResponse != null) {}
        }
      }
    }
  }

  cekiddpl4(String kodecaleg) async {
    Map data = {
      'dplkc': kodecaleg,
      'iddpl': "4",
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekiddpl.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        String usrdpl = jsonResponse['data']["dpldpl"];
        Map data = {
          'usrkc': kodecaleg,
          'usrdpl': usrdpl,
          'iddpl': "4",
        };

        var response = await http.post(
            Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmldukungan.php"),
            body: data);
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          if (jsonResponse != null) {}
        }
      }
    }
  }

  cekiddpl5(String kodecaleg) async {
    Map data = {
      'dplkc': kodecaleg,
      'iddpl': "5",
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekiddpl.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        String usrdpl = jsonResponse['data']["dpldpl"];
        Map data = {
          'usrkc': kodecaleg,
          'usrdpl': usrdpl,
          'iddpl': "5",
        };

        var response = await http.post(
            Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmldukungan.php"),
            body: data);
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          if (jsonResponse != null) {}
        }
      }
    }
  }


  cekkodecaleg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   String kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'kdkc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekkd.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        //  prefs.setString("token", jsonResponse['data']['nohp']);

        setState(() async {


          prefs.setString("yotubecaleg", jsonResponse['kodecaleg']['kdcu']);
            prefs.setString('fotocaleg', jsonResponse['kodecaleg']['kdft']);
          prefs.setString('kdweb', jsonResponse['kodecaleg']['kdweb']);
            prefs.setString("kodeadmin", jsonResponse['kodecaleg']['kdad']);
            prefs.setString("koderelawan", jsonResponse['kodecaleg']['kdrlw']);
            prefs.setString("kodesaksi", jsonResponse['kodecaleg']['kdsks']);
            prefs.setString("visicaleg", jsonResponse['kodecaleg']['kdvs']);
            prefs.setString("misicaleg", jsonResponse['kodecaleg']['kdms']);
            prefs.setString("programcaleg", jsonResponse['kodecaleg']['kdpp']);


            prefs.setString('jobadmin', jsonResponse['kodecaleg']['kdjdad']);
            prefs.setString('jobsaksi', jsonResponse['kodecaleg']['kdjdsk']);
            prefs.setString('jobrelawan', jsonResponse['kodecaleg']['kdjdrl']);
            prefs.setString('jobpendukung', jsonResponse['kodecaleg']['kdjdpd']);
            prefs.setString('anggaran', jsonResponse['kodecaleg']['kdbgt']);
            prefs.setString('janjipolitik', jsonResponse['kodecaleg']['kdjkp']);

            prefs.setString('targetsuara', jsonResponse['kodecaleg']['kdts']);
            prefs.setString('targetrelawan', jsonResponse['kodecaleg']['kdtr']);
            prefs.setString('targetpendukung', jsonResponse['kodecaleg']['kdpd']);

          // yotubecaleg = prefs.getString('yotubecaleg')!;
          kdweb = prefs.getString('kdweb')!;
            kodeadmin = prefs.getString('kodeadmin')!;
            koderelawan = prefs.getString('koderelawan')!;
            kodesaksi = prefs.getString('kodesaksi')!;
            visicaleg = prefs.getString('visicaleg')!;
            misicaleg = prefs.getString('misicaleg')!;

            programcaleg = prefs.getString('programcaleg')!;

            anggaran = prefs.getString('anggaran')!;
            janjipolitik = prefs.getString('janjipolitik')!;

            jobadmin = prefs.getString('jobadmin')!;
            jobsaksi = prefs.getString('jobsaksi')!;
            jobrelawan = prefs.getString('jobrelawan')!;
            jobpendukung = prefs.getString('jobpendukung')!;

        });
      } else {}
    }
  }
  cektotkeuangan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;

    Map data = {'keukc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmltotdonasi.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {

          jumlahdonasi = jsonResponse['donasi']['sum'];


        });
      }
    }
  }
  Future<void> fetchData(String kodecaleg) async {
    final response = await http.get(Uri.parse(
        'http://aplikasiayocaleg.com/ayocalegapi/getnewdukungan.php?usrkc=' +
            kodecaleg));
    // 'http://aplikasiayocaleg.com/ayocalegapi/getnewdukungan.php?usrkc=GEL00'));
    if (response.statusCode == 200) {
      setState(() {
        items = json
            .decode(response.body); // Initialize filteredItems with all items
      });
    }
  }
  Future<void> fetchDataRelawanterbaik(String kodecaleg) async {
    final response = await http.get(Uri.parse(
        'http://aplikasiayocaleg.com/ayocalegapi/getnewdukungan1.php?usrkc=' +
            kodecaleg + "&usrsts=" + "R"));
        // 'http://aplikasiayocaleg.com/ayocalegapi/getnewdukungan.php?usrkc=GEL00'));
    if (response.statusCode == 200) {
      setState(() {

        itemsrelawan = json
            .decode(response.body); // Initialize filteredItems with all items
      });
    }
  }
  Future<void> fetchDataPendukungterbaik(String kodecaleg) async {
    final response = await http.get(Uri.parse(
        'http://aplikasiayocaleg.com/ayocalegapi/getnewdukungan2.php?usrkc=' +
            kodecaleg + "&usrsts=" + "P"));
    // 'http://aplikasiayocaleg.com/ayocalegapi/getnewdukungan.php?usrkc=GEL00'));
    if (response.statusCode == 200) {
      setState(() {
        itemspendukung = json
            .decode(response.body); // Initialize filteredItems with all items
      });
    }
  }

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

          launch(_url);
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


  Future<bool> _isFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasBeenSeen = prefs.getBool('showcaseSeen') ?? true;
    return hasBeenSeen;
    // final sharedPreferences = await SharedPreferences.getInstance();
    // bool isFirstLaunch = sharedPreferences
    //     .getBool(MyHome.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
    //     true;
    //
    // // if (isFirstLaunch) {
    // //   sharedPreferences.setBool(
    // //       MyHome.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);
    // // }
    //
    // return isFirstLaunch;
  }
}
