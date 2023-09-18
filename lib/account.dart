// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ayoleg/cameraktp/editfoto.dart';
import 'package:ayoleg/cameraktp/viewimage.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/component/navbar/navbarpendukung.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/editcaleg.dart';
import 'package:ayoleg/login.dart';
import 'package:ayoleg/otp/password.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Timer _timerForInter;

  bool loading = false;
  bool visibleubahdatacaleg = false;

  bool visibleemailvalid = false;
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
  var emailpesancontrolel = TextEditingController();


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
  String usrsts = "";
  String usrstslogin = "";
  String tgglbergabung = "";
  bool visiblepanduan = false;

  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    _startUp();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      nohpAkun = prefs.getString('nohpregister')!;
      usrsts = prefs.getString('status')!;
      usrstslogin = prefs.getString('usrsts')!;
      cekidrelawan(nohpAkun);

      if (usrsts == "Admin") {
        setState(() {
          visibleubahdatacaleg = true;
          visiblepanduan = true;
        });
      } else if (usrsts == "Calon Legislatif") {
        setState(() {
          visibleubahdatacaleg = true;
          visiblepanduan = true;
        });
      }else if (usrsts == "Relawan") {
        setState(() {
          visibleubahdatacaleg = false;
          visiblepanduan = true;
        });
      } else {
        setState(() {
          visibleubahdatacaleg = false;
          visiblepanduan = false;

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
  Future<void> onBackPressed() async {
    setState(() {

      if (usrstslogin == "A") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return const CustomNavBar();
            }));

      } else if (usrstslogin == "C") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return const CustomNavBar();
            }));

      } else if (usrstslogin == "R") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return const CustomNavRelawanBar();
            }));

      }else if (usrstslogin == "P") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return const CustomNavPendukungBar();
            }));

      }else if (usrstslogin == "S") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return const CustomNavRelawanBar();
            }));

      }

    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () async {
      onBackPressed(); // Action to perform on back pressed
      return false;
    },
    child:
      Stack(
      children: [
        Scaffold(
          appBar: AppBar(
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
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (usrstslogin == "A") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return const CustomNavBar();
                            }));

                      } else if (usrstslogin == "C") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return const CustomNavBar();
                            }));

                      } else if (usrstslogin == "R") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return const CustomNavRelawanBar();
                            }));

                      }else if (usrstslogin == "P") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return const CustomNavPendukungBar();
                            }));

                      }else if (usrstslogin == "S") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return const CustomNavRelawanBar();
                            }));

                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Profil",
                    style:
                    TextStyle(fontFamily: 'poppins', color: whitePrimary),
                  ),
                  Container(
                    width: 17,
                  )
                ],
              )),
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
                         Container(
                          // margin: const EdgeInsets.only(
                          //     top: 10),
                          height: 330.0,
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
                              child:
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(top:20),
                                child:       ClipOval(
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
                                // fotoAkun.isEmpty
                                //     ? Container(
                                //     width: 20,
                                //     height: 20,
                                //     child: CircularProgressIndicator())
                                //     : Container(
                                //   alignment: Alignment.center,
                                //   child: ClipRRect(
                                //       borderRadius:
                                //       BorderRadius.circular(100),
                                //       child: Image.network(
                                //         fotoAkun,
                                //         width: 100,
                                //         height: 100,
                                //         fit: BoxFit.cover,
                                //       )),
                                // ),
                              ),
                              onTap: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("fotoview",fotoAkun);
                                prefs.setString("navfoto", "akun");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ZoomableImage(),
                                  ),
                                );
                              },
                            ),

                            InkWell(
                              child:
                            Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.settings,
                                      size: 20,
                                      color: whitePrimary,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'UBAH FOTO',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: whitePrimary,
                                      ),
                                    )
                                  ],
                                )),
                              onTap: () async {

                                  await availableCameras().then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditFotoPage(cameras: value))));


                              },
                            ),
                            Container(
                                // padding:
                                //     const EdgeInsets.symmetric(vertical: ),
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
                                      status,
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
                            Column(
                              // mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                        return UbahPaswordpage();
                                                      }));

                                              // updatePinDialog();
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              padding: const EdgeInsets.all(7),
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
                                              child: const Icon(Icons.pin),
                                            ),
                                          ),
                                          const Text(
                                            'Ubah',
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            'Kata Sandi',
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          // Even Padding On All Sides
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 20, 0)),

                                      Visibility(
                                        visible: visibleubahdatacaleg,
                                        child:
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushReplacement(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                          return EditCalegpage();
                                                        }));

                                                // updatePinDialog();
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                padding: const EdgeInsets.all(7),
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
                                                child: const Icon(Icons.person),
                                              ),
                                            ),
                                            const Text(
                                              'Ubah',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              'Data Caleg',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          // Even Padding On All Sides
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 20, 0)),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {

                                                bottomdialogbantuan();

                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              padding: const EdgeInsets.all(7),
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
                                              child: const Icon(
                                                  Icons.support_agent),
                                            ),
                                          ),
                                          const Text(
                                            'Hubungi',
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            'Bantuan',
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 5,
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
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
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
                                            Icons.person,
                                            color: greenPrimary,
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
                                  Container(
                                    width: 300,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red[800],
                                        onPrimary: Colors.white,
                                        shadowColor: shadowColor,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        minimumSize:
                                            const Size(200, 30), //////// HERE
                                      ),
                                      onPressed: () async {
                                        logoutDialog();



                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: const Text(
                                          'Keluar',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'poppins',
                                            color: whitePrimary,
                                          ),
                                        ),
                                      ),
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
        ),

        // Align(
        //     alignment: Alignment.topRight,
        //     child: Container(
        //       padding: new EdgeInsets.fromLTRB(0, 40, 10, 0),
        //       child:
        //
        //       FadeInUp(
        //         duration: Duration(milliseconds: 1300),
        //         child: Container(
        //           child: ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               primary: greenPrimary,
        //               onPrimary: whitePrimary,
        //               shadowColor: shadowColor,
        //               elevation: 3,
        //               shape:
        //
        //               RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(20),
        //               ),
        //               minimumSize: const Size(50, 40), //////// HERE
        //             ),
        //             onPressed: () {
        //               setState(() {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) =>
        //                         const SettingAkunpage()));
        //               });
        //             },
        //             child: CircleAvatar(
        //               backgroundColor: hijauprimary,
        //               radius: 20,
        //               child: Icon(
        //                 Icons.settings,
        //                 color: whitePrimary,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     )),
      ],
    ),
    );
  }
  
  logoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: SizedBox(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Yakin Ingin Keluar ?',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: greenPrimary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'BATAL',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: whitePrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: whitePrimary,
                      ),
                      TextButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          Navigator.of(context).pop();

                          prefs.remove('usrsts');
                          prefs.remove('fotoregister');
                          prefs.remove('kodecaleg');
                          prefs.remove('nikregister');
                          prefs.remove('namaregister');
                          prefs.remove('gender');
                          prefs.remove('emailregister');
                          prefs.remove('nohpregister');
                          prefs.remove('kodereferal');

                          prefs.remove('passwordregister');
                          prefs.remove('tempatlahirregis');
                          prefs.remove('tanggallahirregis');
                          prefs.remove('agamaregister');
                          prefs.remove('statuskawinregis');
                          prefs.remove('pekerjaanregister');
                          prefs.remove('daerahpemilihan');

                          prefs.remove('profinsi1register');
                          prefs.remove('kota1register');
                          prefs.remove('kecamatan1register');
                          prefs.remove('kelurahan1register');
                          prefs.remove('kelurahan1register');
                          prefs.remove('rw1register');
                          prefs.remove('rt1register');
                          prefs.remove('alamatktp1register');
                          prefs.remove('notpsgister');
                          prefs.remove('nohprelawancaleg');
                          prefs.remove('status');
                          prefs.remove('token');
                          prefs.remove('cekkodecaleg');
                          prefs.remove('cekcalegadmin');
                          prefs.remove('nohppendukungpendukungg');
                          prefs.remove('fotocaleg');
                          prefs.remove('showcase');



                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                        },
                        child: const Text(
                          'YA',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: whitePrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  cekidrelawan(String usrhp) async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
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
            prefs.setString('fotoregister', jsonResponse['data']['usrft']);
            prefs.setString('fotoregisterubah', jsonResponse['data']['usrft']);
            daerahpemilihan = jsonResponse['data']['usrdpl'];
  tgglbergabung = jsonResponse['data']['usrdd'] +" "+jsonResponse['data']['usrtd'];


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
              });
            }
            // umur = jsonResponse['data']['usrnm'];
            alamatktp1 = jsonResponse['data']['usralm1'] +
                ", " +
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

            alamatktp2 = jsonResponse['data']['usralm2'] +
                ", " +
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

  bottomdialogbantuan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            margin: const EdgeInsets.only(left: 0, top: 40, bottom: 40),
            child:
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 400),
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              // margin: const EdgeInsets.only(left: 10),
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
                              child: const Icon(Icons.support_agent),
                            ),
                            onTap: () {
                              setState(() async {
                                openWhatsapp();
                                Navigator.pop(context, false);
                                // const url =
                                //     'https://api.whatsapp.com/send?phone=+6285100506394';
                                // await launchUrl(Uri.parse(url));
                                // openwhatup();
                              });
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() async {
                              openWhatsapp();
                              Navigator.pop(context, false);
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Bantuan',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: greenPrimary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'WhatsApp',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: greenPrimary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 400),
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              // margin: const EdgeInsets.only(left: 0),
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
                              child: const Icon(Icons.attach_email),
                            ),
                            onTap: () {
                              setState(() {
                                dialogemailsend();
                                // Navigator.pop(context, false);

                              });
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if(emailakun == "-"){
                                Navigator.pop(context, false);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text("Alamat Email Anda Tidak Valid !")));
                              }else{
                                dialogemailsend();
                              }

                              // Navigator.pop(context, false);
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Bantuan',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: greenPrimary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: greenPrimary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                      Visibility(
                      visible: visiblepanduan,
          child:
                  FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 400),
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              // margin: const EdgeInsets.only(left: 10),
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
                              child: const Icon(Icons.book_outlined),
                            ),
                            onTap: () {
                              setState(() async {
                                String url = "https://panduanmenang.ayocaleg.com/";
                                var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                                if(urllaunchable){
                                  await launch(url); //launch is from url_launcher package to launch URL
                                }else{
                                  print("URL can't be launched.");
                                }
                                // String url =
                                //     'https://panduanmenang.ayocaleg.com/';
                                // await launchUrl(Uri.parse(url));

                                Navigator.pop(context, false);
                                // openwhatup();
                              });
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() async {
                              String url = "https://panduanmenang.ayocaleg.com/";
                              var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                              if(urllaunchable){
                                await launch(url); //launch is from url_launcher package to launch URL
                              }else{
                                print("URL can't be launched.");
                              }
                              Navigator.pop(context, false);
                            });
                          },
                          child: const Text(
                            'Panduan',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )),

                  FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 400),
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              // margin: const EdgeInsets.only(left: 10),
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
                              child: const Icon(Icons.voice_chat),
                            ),
                            onTap: () {
                              setState(() async {
                                String url = "https://youtube.com/playlist?list=PLfWMrxPsGMT9UkHc_4ZH4o2gJrJFIrnFT&si=stT3OFr_8euEhnsp";
                                var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                                if(urllaunchable){
                                  await launch(url); //launch is from url_launcher package to launch URL
                                }else{
                                  print("URL can't be launched.");
                                }

                                Navigator.pop(context, false);
                              });
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() async {
                              String url = "https://youtube.com/playlist?list=PLfWMrxPsGMT9UkHc_4ZH4o2gJrJFIrnFT&si=stT3OFr_8euEhnsp";
                              var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                              if(urllaunchable){
                                await launch(url); //launch is from url_launcher package to launch URL
                              }else{
                                print("URL can't be launched.");
                              }
                              Navigator.pop(context, false);
                            });
                          },
                          child: const Text(
                            'Tutorial',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          );
        });
  }

  Future sendEmail(String pesan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String emailregister = prefs.getString('emailregister')!;
    String namaregister = prefs.getString("namaregister")!;

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_ae3hebe';
    const templateId = 'template_r1l4ozo';
    const userId = 'BDXVKB6k_Bfwu0_YT';
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost'
        }, //This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_name': " ",
            'from_name': emailregister,
            'to_email': "ayocaleg@gmail.com",
            'message':
            pesan
          }
        }));

    if (response.statusCode == 200) {
      setState(() {
        dialogemialberhasil();
      });
    }else{

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Pesan Gagal, Ulangi Kembali !")));
    }
    // return response.statusCode;
  }

  openWhatsapp() async {
    const url =
        'https://api.whatsapp.com/send?phone=+6282111814206&text=Hi.. Admin Ayocaleg, saya mau bertanya?';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future dialogemailsend() {

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title:  Text(
            "Pesan Ke Email Admin AyoCaleg",
            style: TextStyle(
                fontFamily: 'poppins',
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold),),

          content:
          TextFormField(
            style: const TextStyle(
                fontFamily: 'poppins',
                color: Colors.black,
                fontSize: 13,
                height: 2
            ),
            controller: emailpesancontrolel,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: greenPrimary, width: 2),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: greenPrimary, width: 2),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              errorBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: greenPrimary, width: 2),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: greenPrimary, width: 2),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              // prefixIcon: Icon(
              //   Icons.person,
              //   color: Colors.black,
              // ),

              fillColor: whitePrimary,
              labelText: "Pesan...",
              labelStyle: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.grey,
                  fontSize: 12),
              filled: true,
            ),

            keyboardType: TextInputType.multiline,
            minLines: 1,
            //Normal textInputField will be displayed
            maxLines: 1000000,
            //
            // keyboardType: TextInputType.text,
            autofocus: false,
            textCapitalization: TextCapitalization.sentences,

          ),


          actions: <Widget>[
            Row(children: [
              TextButton(
                child: const Text('Batal'),
                onPressed: () {
                  setState(() {
                    emailpesancontrolel.clear();

                    Navigator.pop(context, false);

                  });
                },
              ),
              TextButton(
                child: const Text('Kirim'),
                onPressed: () {
                  if (emailpesancontrolel.text.isEmpty) {
                    setState(() {
                      emailpesancontrolel.clear();
                      dialogemaildiisis();

                      // Navigator.pop(context, false);
                    });
                  }else{
                    setState(() {

                      sendEmail(emailpesancontrolel.text);
                      Navigator.pop(context, false);
                      emailpesancontrolel.clear();
                    });
                  }

                },
              ),
            ],)

          ],
        ));
  }
  Future dialogemialberhasil() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Image.asset(
                'assets/images/emaill.png',
                height: 100,
                width: 100,
              ),
              content: const Text("Pesan Terkirim !"),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context, false);
                    });
                  },
                ),
              ],
            ));
  }

  Future dialogemaildiisis() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(

          content: const Text("Pesan Harus Di Isi !"),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, false);
                });
              },
            ),
          ],
        ));
  }

}

