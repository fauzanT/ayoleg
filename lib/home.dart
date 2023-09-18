// ignore_for_file: unused_local_variable, constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ayoleg/account.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/team/relawan.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ayoleg/models/servicesmodel.dart';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:marquee_text/marquee_text.dart';
// import 'package:new_version/new_version.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';

// import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// final newVersion = NewVersion();
// const _url = 'https://apps.apple.com/id/app/ayoscan/id1390800335?l=id';
const _url =
    'https://play.google.com/store/apps/details?id=com.ayoscan.ayoscanid';

class _HomePageState extends State<HomePage> {
  Future<List<Datanewdukungan>>? futurenewdukungan;

  late Timer _timerForInter;
  List items = [];
  // late Timer _timerForInterupdate;
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
  String jobpendukung ="";
  String jumlahdonasi = "";

  bool colorOvo = false;
  bool colorLink = false;
  bool colorDana = false;
  bool colorShopee = false;
  bool visiblekodesaksiakun = false;
  bool visiblekoderelawanakun = false;
  bool visiblekodadmineakun = false;
  bool visibletargetpendukungakun =false;
  bool visiblenohpakun = false;
  bool visiblejobadmin = false;
  bool visiblejobrelawan = false;
  bool visiblejobpendukung = false;
  bool visiblejobsaksi = false;

  // LOGO
  bool logoOvo = false;
  bool logoLink = false;
  bool logoDana = false;
  bool logoShopee = false;

  //bool sukses menghubungkan atau tidak
  bool modelOvo = false;
  bool modelLink = false;
  bool modelDana = false;
  bool modelShopee = false;

  // int statusFoto = 0;

  late SharedPreferences sharedPrefs;

  bool colorOvo1 = true;
  bool colorLink1 = true;
  bool colorDana1 = true;
  bool colorShopee1 = true;

  //loading
  bool loadingOvo = false;

  //saldo
  int saldoOvo = 1;
  int cekSaldo = 0;
  bool saldoUzer = false;
  bool sambungAkun = true;
  int showCase = 1;

  bool versionCheck = false;

  bool lihatSaldo = false;
  bool isNotif = false;

  //transportasi
  bool cekMRT = false;
  bool visiblekodeakun = false;

  int mrt = 0;
  int tj = 0;
  int kci = 0;
  int lrt = 0;

  //ShowCase
  final GlobalKey globalKeyOne = GlobalKey();
  final GlobalKey globalKeyTwo = GlobalKey();
  final GlobalKey globalKeyThree = GlobalKey();
  final GlobalKey globalKeyFour = GlobalKey();
  final GlobalKey globalKeyFive = GlobalKey();

  YoutubePlayerController? _controller;

  @override
  void initState() {
    setState(() {
      fetchDatanewdukungan();
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        // targetsuara = prefs.getString('targetsuara')!;
        // targetrelawan = prefs.getString('targetrelawan')!;
        // targetpendukung = prefs.getString('targetpendukung')!;
        // jumlahkursi =prefs.getString('jumlahkursi')!;

        fotoAkun = prefs.getString('fotoregister')!;
        namaAkun = prefs.getString('namaregister')!;
        nohpAkun = prefs.getString('nohpregister')!;
        // calonlegis = prefs.getString('calonlegis')!;
        usrsts = prefs.getString('status')!;
        fotocaleg = prefs.getString('fotocaleg')!;
        namacaleg = prefs.getString('namacaleg')!;
        usrtkccaleg = prefs.getString('usrtkccaleg')!;
        daerahpemilihan = prefs.getString('daerahpemilihan')!;
        kodeadmin = prefs.getString('kodeadmin')!;
        koderelawan = prefs.getString('koderelawan')!;
        kodesaksi = prefs.getString('kodesaksi')!;
        visicaleg = prefs.getString('visicaleg')!;
        misicaleg = prefs.getString('misicaleg')!;
        kodecaleg = prefs.getString('kodecaleg')!;
        programcaleg = prefs.getString('programcaleg')!;
        yotubecaleg = prefs.getString('yotubecaleg')!;

        jobadmin = prefs.getString('jobadmin')!;
        jobsaksi = prefs.getString('jobsaksi')!;
        jobrelawan = prefs.getString('jobrelawan')!;
        jobpendukung = prefs.getString('jobpendukung')!;

        futurenewdukungan = fetchGetDataNewDukungan(kodecaleg);

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
          });
        } else if (usrsts == "saksi") {
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
          });
        }  else {
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
          });
        }

        targetpendukung = prefs.getString('targetpendukunghome')!;

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
    _timerForInter.cancel();
    super.dispose();
  }

  Map<String, double> dataMappp = {
    "Boyolali": 18.47,
    "Kalten": 17.70,
    "Sukoharjo": 4.25,
    "Cosmetics": 3.51,
    "Other": 2.83,
  };

  List<Color> colorList = [
    const Color(0xffD95AF3),
    // const Color(0xff3EE094),
    // const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 134, 92, 1),
    ]
  ];

  final List<ChartDataInfo> indexChart = [
    ChartDataInfo('JakPus', 60.5, Color.fromRGBO(9, 0, 136, 1)),
    ChartDataInfo('JaSel', 30.5, Color.fromRGBO(147, 0, 119, 1)),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child:
        Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: whiteSecondary,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 150,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      greengradiens,
                      greenTap,
                    ],
                  ),
                  // color: isAppbarCollapsing ? greenPrimary : greenPrimary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: SafeArea(
                child:
                Stack(
                  children: [
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: InkWell(
                    //     onTap: () {
                    //       // updateStsNotif();
                    //     },
                    //     child:
                    //     Container(
                    //       width: 25,
                    //       height: 25,
                    //       margin: const EdgeInsets.only(right: 20, top: 5),
                    //       decoration: const BoxDecoration(
                    //         color: whitePrimary,
                    //         shape: BoxShape.circle,
                    //         boxShadow: [
                    //           BoxShadow(
                    //               blurRadius: 2,
                    //               color: shadowColor3,
                    //               spreadRadius: 2)
                    //         ],
                    //       ),
                    //       child: Stack(
                    //         children: [
                    //           // CircleAvatar(
                    //           //   backgroundColor: hijauprimary,
                    //           //   radius: 20,
                    //           //   child: Icon(
                    //           //     Icons.notifications_outlined,
                    //           //     color: whitePrimary,
                    //           //   ),
                    //           // ),
                    //           // isNotif
                    //           //     ? Container(
                    //           //         margin: EdgeInsets.only(left: 22, top: 7),
                    //           //         width: 12,
                    //           //         height: 12,
                    //           //         decoration: BoxDecoration(
                    //           //             color: Colors.red,
                    //           //             borderRadius:
                    //           //                 BorderRadius.circular(20)),
                    //           //       )
                    //           //     : Container(),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Column(
                      children: [Profilehome()],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body:
          WillPopScope(
              onWillPop: () {
                DateTime now = DateTime.now();

                if (ctime == null ||
                    now.difference(ctime) > Duration(seconds: 1)) {
                  ctime = now;
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ketuk 2 Kali Untuk Keluar')));
                  return Future.value(false);
                }
                SystemNavigator.pop();

                return Future.value(true);
              },
              child:
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [

                    SizedBox(
                      height: 200,
                    ),


                    // datanewdukungan(),
                    // SizedBox(
                    //   height: 20,
                    // ),
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
                            margin: const EdgeInsets.only( top: 20,bottom: 20),
                            alignment: Alignment.center,
                            // height: 30,
                            width: 350,
                            child: yotubecaleg.isNotEmpty
                                ? YoutubePlayer(
                              controller: _controller!,
                              liveUIColor: Colors.amber,
                              showVideoProgressIndicator: true,
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
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // datanewdukungan(),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              )

          ),
        ));
  }

  Widget datanewdukungan() {
    // final size = MediaQuery.of(context).size;
    return
      Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            "Dukungan Terbaru",
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontFamily: 'poppins',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
            overflow: TextOverflow.clip,
          ),
        ),
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              width: 70,
              height: 70,
              // Replace with your own item widget
              child:ClipRRect(
                // borderRadius: BorderRadius.circular(70),
                child: Image.network(
                  // widget.question.fileInfo[0].remoteURL,
                  item['usrft'],
                  width: 70,
                  height: 70,
                  //
                  loadingBuilder: (context, child,
                      loadingProgress) =>
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
              )
          );
        },
      )
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
      margin: EdgeInsets.only(
      left: 10, right: 10),
      alignment: Alignment.center,
      child:
          Image.network(
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
                      child:
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
                      child:
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
                      child:
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
                                Icons.people_alt_outlined,
                                color: greenPrimary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            nohpAkun.isNotEmpty
                                ? Text(
                              "No. HP Referal " + nohpAkun,
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
                      margin: EdgeInsets.only(left: 20, right: 20,bottom: 10),
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
                    )
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
      child:
      Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: whitePrimary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
          ],
        ),
        child:
        Column(
          children: [
            const SizedBox(
              height: 13,
            ),

        Visibility(
          visible: visiblejobadmin,
          child:Column(children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              // width: 100,
              decoration: BoxDecoration(
                color: whitePrimary,
                borderRadius: BorderRadius.circular(0),
                boxShadow: const [
                ],
              ),
              child:Text(
                "Tugas Admin",
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
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
                boxShadow: const [
                ],
              ),
              child:
              Row(
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
          ],)

        ),
        Visibility(
          visible: visiblejobrelawan,
          child:
            Container(

              child:Column(children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  // width: 100,
                  decoration: BoxDecoration(
                    color: whitePrimary,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: const [
                    ],
                  ),
                  child:Text(
                    "Tugas Relawan",
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: 'poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
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
                    boxShadow: const [
                    ],
                  ),
                  child:
                Row(
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
              ],)

            ),
        ),
        Visibility(
          visible: visiblejobpendukung,
          child:
            Container(

              child:Column(children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  // width: 100,
                  decoration: BoxDecoration(
                    color: whitePrimary,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: const [
                    ],
                  ),
                  child:Text(
                    "Tugas Pendukung",
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: 'poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
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
                    boxShadow: const [
                    ],
                  ),
                  child:
                Row(
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
              ],)

            ),
        ),
        Visibility(
          visible: visiblejobsaksi,
          child:
            Container(

              child:
              Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      // width: 100,
                      decoration: BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: const [
                        ],
                      ),
                      child:Text(
                        "Tugas Saksi",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
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
                  boxShadow: const [
                  ],
                ),
                child:
                    Row(
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
    return

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
    child:
    Center(
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
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  alignment: Alignment.center,
                  // height: 30,
                  width: 300,
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
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
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
                  margin: const EdgeInsets.only(bottom: 20, top: 10),
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

        ],
      ),
    )

      );
  }

  Widget Profilehome() {
    // Uint8List bytes = base64.decode(fotoAkun);
    return Container(
        alignment: Alignment.topLeft,
        margin:
            EdgeInsets.only(top: 40, left: 20, right: 20),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            color: putihprimary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: greenPrimary, width: 1)),
        child: Row(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: versionCheck
                  ? Container()
                  : Showcase(
                      key: globalKeyOne,
                      // overlayPadding: EdgeInsets.all(5),
                      // shapeBorder: CircleBorder(),
                      description: 'Ketuk Disini Untuk Melihat Akun Anda',
                      descTextStyle: TextStyle(fontFamily: 'poppins'),
                      child: GestureDetector(
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              // widget.question.fileInfo[0].remoteURL,
                              fotoAkun,
                              width: 60,
                              height: 60,
                              //
                              loadingBuilder: (context, child,
                                      loadingProgress) =>
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
                          )

                          // fotoAkun.isEmpty
                          //     ? Container(
                          //     width: 20,
                          //     height: 20,
                          //     child: CircularProgressIndicator())
                          //     : Container(
                          //   alignment: Alignment.topLeft,
                          //   child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(100),
                          //       child: Image.network(
                          //         fotoAkun,
                          //         width: 100,
                          //         height: 100,
                          //         fit: BoxFit.cover,
                          //       )),
                          // ),
                          ),
                    ),
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
                  child:
                    Container(
                      margin: const EdgeInsets.only(left: 0, top: 5),
                      child: Text(
                        "Target Pendukung : "+ targetpendukung,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'poppins',
                          color: Colors.orange,
                          fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
              ),
                    const SizedBox(
                      width: 5,
                    ),
                  ]),
            )

          ],
        ));
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
        Uri.parse("http://103.84.206.217/ayocalegapi/cekiddpl.php"),
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
            Uri.parse("http://103.84.206.217/ayocalegapi/jmldukungan.php"),
            body: data);
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          if (jsonResponse != null) {}
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
        Uri.parse("http://103.84.206.217/ayocalegapi/cekiddpl.php"),
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
            Uri.parse("http://103.84.206.217/ayocalegapi/jmldukungan.php"),
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
        Uri.parse("http://103.84.206.217/ayocalegapi/cekiddpl.php"),
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
            Uri.parse("http://103.84.206.217/ayocalegapi/jmldukungan.php"),
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
        Uri.parse("http://103.84.206.217/ayocalegapi/cekiddpl.php"),
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
            Uri.parse("http://103.84.206.217/ayocalegapi/jmldukungan.php"),
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
        Uri.parse("http://103.84.206.217/ayocalegapi/cekiddpl.php"),
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
            Uri.parse("http://103.84.206.217/ayocalegapi/jmldukungan.php"),
            body: data);
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          if (jsonResponse != null) {}
        }
      }
    }
  }


  cekkodecaleg(String kdkc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {'kdkc': kdkc};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://103.84.206.217/ayocalegapi/cekkd.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        //  prefs.setString("token", jsonResponse['data']['nohp']);

        setState(() async {
          // targetsuara =  int.parse(jsonResponse['kodecaleg']['kdts']);

          // SharedPreferences prefs = await SharedPreferences.getInstance();
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


  Future<void> fetchDatanewdukungan() async {
    final response = await http.get(Uri.parse('http://103.84.206.217/ayocalegapi/getnewdukungan.php?usrkc=GEL00'));
    if (response.statusCode == 200) {
      setState(() {
        items = json.decode(response.body);

      });
    }
  }

}


class ChartDataInfo {
  ChartDataInfo(this.year, this.value, [this.color]);

  final String year;
  final double value;
  final Color? color;
}

class ChartData {
  ChartData(this.mobile, this.sale, [this.color]);

  final String mobile;
  final double sale;
  final Color? color;
}
