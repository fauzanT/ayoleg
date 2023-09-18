// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/otp/pin_objact.dart';
import 'package:ayoleg/register.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:package_info_plus/package_info_plus.dart';

class Otppageverifikasi extends StatefulWidget {
  // const Otp({Key key}) : super(key: key);
  static String tag = 'otp_page';

  const Otppageverifikasi({Key? key}) : super(key: key);

  @override
  _OtppageState createState() => _OtppageState();
}

class _OtppageState extends State<Otppageverifikasi> {
  bool isLoading = false;
  // static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  // Map<String, dynamic> _deviceData = <String, dynamic>{};
  // String? devices;
  var passotp = TextEditingController();
  String otpacak = "";
  String emailAkun = "";
  String foto = "";
  String namaregister = "";
  String emailregister = "";
  String genderregister = "";
  String nohpregister = "";
  String pinregister = "";
  String faceid = "";
  String avatarId = "";
  String mainSample = "";
  String codeotpregister = "";
  String token_notif = "";

  String imgios = "";

  bool visibleerorOTP = false;
  bool visibleBtnResend = false;
  bool visibleTextTimer = false;
  bool visibleTextwaktukirim = false;
  bool visiblecircular = false;
  bool visibletidakLengkap = false;

  TextEditingController pinotp1Controller = TextEditingController();
  TextEditingController pinotp2Controller = TextEditingController();
  TextEditingController pinotp3Controller = TextEditingController();
  TextEditingController pinotp4Controller = TextEditingController();
  TextEditingController pinotp5Controller = TextEditingController();
  TextEditingController pinotp6Controller = TextEditingController();

  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 120;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:'
      ' ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  // @override
  // void initState() {
  //   startTimeout();
  //   // _starttimeagain();
  //
  //   super.initState();
  // }

  String nohpakun = "";

  late SharedPreferences sharedPrefs;
  @override
  void initState() {
    super.initState();
    startTimeout();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      emailAkun = prefs.getString('emailregister')!;
      nohpakun = prefs.getString('nohpregister')!;
      // initPlatformState();
    });
  }

  // Future<void> initPlatformState() async {
  //   var deviceData = <String, dynamic>{};
  //   try {
  //     if (Platform.isAndroid) {
  //       devices = 'Android';
  //       deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
  //     } else if (Platform.isIOS) {
  //       devices = 'Iphone';
  //       deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
  //     }
  //   } on PlatformException {
  //     deviceData = <String, dynamic>{
  //       'Error:': 'Failed to get platform version.'
  //     };
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _deviceData = deviceData;
  //   });
  // }

  // Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  //   return <String, dynamic>{
  //     'model': build.model,
  //   };
  // }

  // Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  //   return <String, dynamic>{
  //     'model': data.model,
  //   };
  // }

  startTimeout([int? milliseconds]) {
    var duration = interval;

    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        visibleTextTimer = true;
        visibleTextwaktukirim = true;
        if (timer.tick >= timerMaxSeconds) {
          setState(() async {
            visiblecircular = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('otpregis');
            visibleBtnResend = true;
            visibleTextTimer = false;
          });
          timer.cancel();
        }
        // if (timer.tick >= timerMaxSeconds) {
        //   setState(() async {
        //     visibleBtnResend = true;
        //     visibleTextTimer = false;
        //     SharedPreferences prefs = await SharedPreferences.getInstance();
        //     prefs.remove('otpcode');
        //   });
        //   timer.cancel();
        // }
      });
    });
  }

  // _starttimeagain() async {
  //   if (timerMaxSeconds == 0) {
  //     setState(() {
  //       visibleBtnResend = true;
  //       visibleTextTimer = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        onBackPressed(); // Action to perform on back pressed
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: (isLoading)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator()),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Mohon Tunggu..",
                        style: TextStyle(fontFamily: 'poppins', fontSize: 15),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => onBackPressed(),
                          child: Icon(
                            Icons.arrow_back,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/images/logocaleg.png",
                              width: 200, height: 80)),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(1),
                          child: Column(
                            children: [
                              Text(
                                'Masukkan Kode OTP Anda',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 5,
                      ),

                      //
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,

                          children: [
                            Container(
                              width: 60,
                              height: size.height * 0.09,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: TextFormField(
                                  obscureText: false,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                    if (value.length == 0) {}
                                  },

                                  maxLength: 1,
                                  style: TextStyle(
                                      color: greenPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: pinotp1Controller,
                                  decoration: InputDecoration(
                                    filled: true,
                                    counterText: "",
                                    counter: Offstage(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: greenPrimary),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return null;
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: size.height * 0.09,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: TextFormField(
                                  obscureText: false,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                    if (value.length == 0) {
                                      FocusScope.of(context).previousFocus();
                                      setState(() {
                                        visibletidakLengkap = false;
                                        visibleerorOTP = false;
                                      });
                                    }
                                  },

                                  maxLength: 1,
                                  style: TextStyle(
                                      color: greenPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: pinotp2Controller,
                                  decoration: InputDecoration(
                                    filled: true,
                                    counterText: "",
                                    counter: Offstage(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return null;
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: size.height * 0.09,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: TextFormField(
                                  obscureText: false,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                    if (value.length == 0) {
                                      FocusScope.of(context).previousFocus();
                                      setState(() {
                                        visibletidakLengkap = false;
                                        visibleerorOTP = false;
                                      });
                                    }
                                  },

                                  maxLength: 1,
                                  style: TextStyle(
                                      color: greenPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: pinotp3Controller,
                                  decoration: InputDecoration(
                                    filled: true,
                                    counterText: "",
                                    counter: Offstage(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return null;
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: size.height * 0.09,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: TextFormField(
                                  obscureText: false,
                                  onChanged: (value) async {
                                    if (value.length == 1) {
                                      if (pinotp1Controller.text.isEmpty &&
                                          pinotp2Controller.text.isEmpty &&
                                          pinotp3Controller.text.isEmpty &&
                                          pinotp4Controller.text.isEmpty) {
                                        setState(() {
                                          visiblecircular = false;

                                          visibletidakLengkap = false;
                                          visibleerorOTP = false;
                                        });
                                      } else if (pinotp2Controller
                                              .text.isEmpty &&
                                          pinotp3Controller.text.isEmpty &&
                                          pinotp4Controller.text.isEmpty) {
                                        setState(() {
                                          visiblecircular = false;

                                          visibletidakLengkap = true;
                                          visibleerorOTP = false;
                                        });
                                      } else if (pinotp3Controller
                                              .text.isEmpty &&
                                          pinotp4Controller.text.isEmpty) {
                                        setState(() {
                                          visiblecircular = false;
                                          visibletidakLengkap = true;
                                          visibleerorOTP = false;
                                        });
                                      } else if (pinotp4Controller
                                          .text.isEmpty) {
                                        setState(() {
                                          visiblecircular = false;
                                          visibletidakLengkap = true;
                                          visibleerorOTP = false;
                                        });
                                      } else if (pinotp1Controller
                                          .text.isEmpty) {
                                        setState(() {
                                          visiblecircular = false;
                                          visibletidakLengkap = true;
                                          visibleerorOTP = false;
                                        });
                                      } else {
                                        setState(() async {
                                          visiblecircular = true;
                                          // verifyOTP();
                                          
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          String otpregis =
                                              prefs.getString('otpregis')!;
                                          if (pinotp1Controller.text +
                                                  pinotp2Controller.text +
                                                  pinotp3Controller.text +
                                                  pinotp4Controller.text ==
                                              otpregis) {
                                                 registerverifikasi();
                                            // registerAyotech();
                                            setState(() {
                                              visiblecircular = true;
                                              visibletidakLengkap = false;
                                              visibleerorOTP = false;
                                            });
                                          } else {
                                            visiblecircular = false;
                                            visibletidakLengkap = false;
                                            visibleerorOTP = true;
                                          }
                                        
                                        });
                                      }
                                    }
                                    if (value.length == 0) {
                                      FocusScope.of(context).previousFocus();
                                      setState(() {
                                        visibletidakLengkap = false;
                                        visibleerorOTP = false;
                                      });
                                    }
                                  },

                                  maxLength: 1,
                                  style: TextStyle(
                                      color: greenPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: pinotp4Controller,

                                  decoration: InputDecoration(
                                    filled: true,
                                    counterText: "",
                                    counter: Offstage(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: greenPrimary),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),

                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return null;
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: visibletidakLengkap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              //ROW 1
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text(
                                'OTP Tidak Lengkap !',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: visibleerorOTP,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              //ROW 1
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text(
                                'OTP Salah !',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: visiblecircular,
                        child: Padding(
                            //ROW 1
                            padding: EdgeInsets.fromLTRB(120, 5, 120, 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [CircularProgressIndicator()])
                                ])),
                      ),
                      SizedBox(
                        height: 0,
                      ),

                      Visibility(
                        visible: visibleTextTimer,
                        child: Column(
                          children: [
                            Padding(
                              //ROW 1
                              padding: EdgeInsets.fromLTRB(1, 1, 1, 10),
                              child: Text(
                                "Waktu Mengirim Ulang Kode OTP :",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                            Padding(
                              //ROW 1

                              padding: EdgeInsets.fromLTRB(5, 5, 10, 10),
                              child: Text(
                                timerText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: visibleBtnResend,
                        child: Padding(
                          //ROW 1
                          padding: EdgeInsets.fromLTRB(90, 5, 90, 10),

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: greenPrimary,
                              onPrimary: Colors.white,
                              shadowColor: Colors.blue.shade800,
                              elevation: 3,

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              //// HERE
                            ),
                            onPressed: () {
                              startTimeout();
                              setState(() async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove('otpregis');
                                visibletidakLengkap = false;
                                visibleerorOTP = false;
                                sendEmail();
                              });
                            },
                            child: Text(
                              'Kirim Ulang OTP',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'poppins',
                                color: whitePrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 150),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(1),
                          child: Column(
                            children: [
                              Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.all(7),
                                  decoration: const BoxDecoration(
                                    color: whitePrimary,
                                    shape: BoxShape.circle,
                                  ),
                                  child:
                                      Image.asset("assets/images/emaill.png")),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Kode OTP Telah Dikirim Ke Email',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                              Text(
                                emailAkun,
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          )),
                    ],
                  ))),
    );
  }

  pinRowInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: PinCodeTextField(
            controller: pinotp1Controller,
          ),
        ),
        Expanded(
          child: PinCodeTextField(
            controller: pinotp2Controller,
          ),
        ),
        Expanded(
          child: PinCodeTextField(
            controller: pinotp3Controller,
          ),
        ),
        Expanded(
          child: PinCodeTextField(
            controller: pinotp4Controller,
          ),
        ),
      ],
    );
  }

  // verifyOTP() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String emailregister = prefs.getString('emailregister')!;

  //   Map data = {
  //     'otp': pinotp1Controller.text +
  //         pinotp2Controller.text +
  //         pinotp3Controller.text +
  //         pinotp4Controller.text,
  //     'email': emailregister,
  //     'type': 'ayoscan'
  //   };
  //   dynamic jsonResponse;
  //   var response = await http
  //       .post(Uri.parse("https://ayoscan.id/api/mail/verifyOtp"), body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       setState(() {
  //         visiblecircular = true;
  //         // Navigator.pushReplacement(context,
  //         //     MaterialPageRoute(builder: (context) {
  //         //   return const CustomNavBar();

  //         // }));
  //         registerverifikasi();
  //       });
  //     } else {}
  //   } else {
  //     setState(() {
  //       visiblecircular = false;
  //       visibletidakLengkap = false;
  //       visibleerorOTP = true;
  //     });
  //   }
  // }

  cekEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailAkun = prefs.getString('emailregister')!;
  }

  // registerAyotech() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   foto = prefs.getString('foto')!;
  //   nohpregister = prefs.getString('nohpregister')!;
  //   genderregister = prefs.getString('gender')!;
  //   namaregister = prefs.getString('namaregister')!;
  //   emailregister = prefs.getString('emailregister')!;
  //   pinregister = prefs.getString('pinregister')!;
  //   token_notif = prefs.getString('token_notif')!;

  //   Map data = {
  //     'nohp': nohpregister,
  //     'name': namaregister,
  //     'gender': genderregister,
  //     'email': emailregister,
  //     'imgb64': foto,
  //     'pin': pinregister,
  //   };

  //   dynamic jsonResponse;
  //   var response = await http
  //       .post(Uri.parse("https://ayoscan.id/api/ayotech/register"), body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       //  ScaffoldMessenger.of(context)
  //       //   .showSnackBar(SnackBar(content: Text("Proses Data!")));
  //       setState(() {
  //         registerverifikasi();
  //       });
  //     } else {
  //       setState(() {
  //         visiblecircular = false;
  //       });

  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Register gagal!")));
  //     }
  //   } else {
  //     setState(() {
  //       visiblecircular = false;
  //     });
  //   }
  // }

  registerverifikasi() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    foto = prefs.getString('foto')!;
    nohpregister = prefs.getString('nohpregister')!;
    genderregister = prefs.getString('gender')!;
    namaregister = prefs.getString('namaregister')!;
    emailregister = prefs.getString('emailregister')!;
    pinregister = prefs.getString('pinregister')!;
    token_notif = prefs.getString('token_notif')!;

    Map data = {
      'nohp': nohpregister,
      'name': namaregister,
      'gender': genderregister,
      'email': emailregister,
      'imgb64': foto,
      'pin': pinregister,
      'deviceId': "",
      'tokenNotif': token_notif,
      'face_id': "",
      'avatar_id': "",
      'main_sample': "",
    };

    dynamic jsonResponse;
    var response = await http.post(Uri.parse("https://ayoscan.id/api/register"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        int id = jsonResponse['data']['id'];
        String pznpin = jsonResponse['data']['pzn'];
        createMagvie(id, namaregister, nohpregister, pznpin, foto);

        prefs.setString("token", jsonResponse['data']['nohp']);
        // prefs.setString("foto", jsonResponse['data']['imgb64']);
        prefs.setString("gender", jsonResponse['data']['gender']);
        prefs.setString("emailregister", jsonResponse['data']['usremail']);
        prefs.setString("namaregister", jsonResponse['data']['usrname']);
        prefs.setString("token", nohpregister);
        prefs.setString("pznpin", jsonResponse['data']['pzn']);
        prefs.setInt('iduser', jsonResponse['data']['id']);
        prefs.setInt("saldo", jsonResponse['data']['saldo_user']);

        Navigator.pushNamed(context, '/NavBar');

        setState(() {
          visiblecircular = false;
        });
      } else {
        setState(() {
          visiblecircular = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Daftar gagal, periksa jaringan anda!")));
      }
    } else {
      setState(() {
        visiblecircular = false;
      });
    }
  }

  createMagvie(
      int id, String nama, String nohp, String pznpin, String foto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {
      "id": "$id",
      "name": nama,
      "saldo": '0',
      "nohp": nohp,
      "imgb64": foto,
      "pin": pznpin,
    };

    var response = await http
        .post(Uri.parse("http://ayopay.co.id/api/create/person"), body: data);
    if (response.statusCode == 200) {
      prefs.setInt('iduser', id);
    } else {
      setState(() {
        visiblecircular = false;
      });
    }
  }

  Future sendEmail() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String emailregister = prefs.getString('emailregister')!;
    String namauser= prefs.getString("namaregister")!;
 final int min = 1000;
    final int max = 9999;
    var otpcodee = new Random().nextInt((max - min) + 1) + min;
    var otpacak = otpcodee.toString();
   

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_djte5n9';
  const templateId = 'template_looq5wl';
  const userId = 'e_d1c68qNH_pPlxv5';
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json',
      'origin': 'http://localhost'},//This line makes sure it works for all platforms.
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_name': namauser,
          'from_name': "AYOSCAN",
          'to_email': emailregister,
          'message': otpacak
        }
      }));

     if (response.statusCode == 200) {
        setState(() {
          visibleBtnResend = false;
            prefs.setString('otpregis', otpacak);
        });
       }
  // return response.statusCode;
}



  // createProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String foto = prefs.getString('foto')!;

  //   Map data = {
  //     'image': foto,
  //   };

  //   var jsonResponse;
  //   var response = await http.post(
  //       Uri.parse("https://ayoscan.id/api/face/createprofile"),
  //       body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       registerverifikasi(jsonResponse['id_face'], jsonResponse['avatar_id'],
  //           jsonResponse['main_sample_id']);
  //     }
  //   } else {
  //     createProfile();
  //   }
  // }

  // registerverifikasi() async {
  //   var device = Platform.isAndroid
  //       ? await deviceInfoPlugin.androidInfo
  //       : await deviceInfoPlugin.iosInfo;
  //   _deviceData = device.toMap();
  //   String model = _deviceData['model'];

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   foto = prefs.getString('foto')!;
  //   nohpregister = prefs.getString('nohpregister')!;
  //   genderregister = prefs.getString('gender')!;
  //   namaregister = prefs.getString('namaregister')!;
  //   emailregister = prefs.getString('emailregister')!;
  //   pinregister = prefs.getString('pinregister')!;
  //   // faceid = prefs.getString('faceid')!;
  //   // avatarId = prefs.getString('avatarid')!;
  //   // mainSample = prefs.getString('mainsampleid')!;
  //   token_notif = prefs.getString('token_notif')!;

  //   Map data = {
  //     'nohp': nohpregister,
  //     'name': namaregister,
  //     'gender': genderregister,
  //     'email': emailregister,
  //     'imgb64': foto,
  //     'pin': pinregister,
  //     'deviceId': model,
  //     'tokenNotif': token_notif,
  //     'face_id': "",
  //     'avatar_id': "",
  //     'main_sample': "",
  //   };

  //   dynamic jsonResponse;
  //   var response = await http.post(Uri.parse("https://ayoscan.id/api/register"),
  //       body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       prefs.setString("token", nohpregister);
  //       Navigator.pushNamed(context, 'NavBar');
  //     } else {
  //       setState(() {
  //         visiblecircular = false;
  //       });

  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Register gagal!")));
  //     }
  //   } else {
  //     setState(() {
  //       visiblecircular = false;
  //     });
  //   }
  // }
  onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              content: Container(
                height: 150,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const Text(
                      "Apakah Anda Yakin Tidak Ingin Melanjutkan Pendaftaran Ini ? ",
                      style: TextStyle(fontFamily: 'poppins', fontSize: 15),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          color: greenPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Tidak",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 15,
                                color: whitePrimary),
                          ),
                        ),
                        MaterialButton(
                          color: greenPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            // deleteBack();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Ya",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 15,
                                color: whitePrimary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  // otpGmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String emailregister = prefs.getString('emailregister')!;
  //   final int min = 1000;
  //   final int max = 9999;
  //   var otpcodee = new Random().nextInt((max - min) + 1) + min;
  //   var otpacak = otpcodee.toString();
  //   prefs.setString('otpregis', otpacak);

  //   Map data = {
  //     'subject': "OTP Ayoscan Anda",
  //     'title': "PIN baru dari Ayocan",
  //     'body': otpacak,
  //     'emailto': emailregister,
  //     'emailPurpouse': 'register',
  //     'forgot_type': 'forgot_pin'
  //   };
  //   dynamic jsonResponse;
  //   var response = await http
  //       .post(Uri.parse("https://ayoscan.id/api/sendEmail"), body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       setState(() {
  //         visibleBtnResend = false;
  //       });
  //     } else {
  //       print("Error");
  //     }
  //   }
  // }

  // deleteBack() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String z = prefs.getString('nohpregister')!;

  //   Map data = {'nohp': z};
  //   dynamic jsonResponse;
  //   var response = await http
  //       .post(Uri.parse("https://ayoscan.id/api/deleteBack"), body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => RegisterPage()),
  //       );
  //     } else {
  //       print("Error");
  //     }
  //   }
  // }

  // Future<String> otpverivikasi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   nohpregister = prefs.getString('nohpregister')!;
  //   DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  //   DateFormat timeformat = DateFormat("HH:mm:ss");
  //   String createDate = dateFormat.format(DateTime.now());
  //   String createtime = timeformat.format(DateTime.now());

  //   final int min = 1000;
  //   final int max = 9999;
  //   var otpcodee = new Random().nextInt((max - min) + 1) + min;
  //   var otpacak = otpcodee.toString();

  //   final body = {
  //     'is_Flash': false,
  //     'is_Unicode': false,
  //     'apiKey': "tuNcvoP4EbxseRQHx9MqP1cfLLcBwwNznqJ9qdyzTMI=",
  //     'message': "KODE RAHASIA AYOSCAN: " +
  //         otpacak +
  //         " BERLAKU HINGGA " +
  //         createDate +
  //         " " +
  //         createtime +
  //         " WIB WASPADA PENIPUAN! JANGAN BERIKAN KODE RAHASIA KE SIAPAPUN",
  //     'mobileNumbers': nohpregister,
  //     'clientId': "d3e7fd85-6e6f-4a0c-b9c9-2448b8f769f0",
  //     'senderId': "Ayoscan",
  //   };

  //   HttpClient httpClient = HttpClient();
  //   HttpClientRequest request = await httpClient
  //       .postUrl(Uri.parse("https://api.tcastsms.net/api/v2/SendSMS?"));
  //   request.headers.set('content-type', 'application/json');
  //   request.add(utf8.encode(json.encode(body)));
  //   HttpClientResponse response = await request.close();
  //   // todo - you should check the response.statusCode
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       visibleBtnResend = false;
  //       visibleTextTimer = true;
  //       prefs.setString("otpcode", otpacak);
  //     });

  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Code OTP Sedang di kirim!")));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Code OTP gagal terkirim!")));
  //   }
  //   String reply = await response.transform(utf8.decoder).join();
  //   httpClient.close();
  //   return reply;
  // }

  // Future<String> registerzipay() async {
  //   final body = {
  //     'token': 'a9Ip5mzSYtKiE6bxk423G2k6zPvpCfHj',
  //     'nohp': nohpakun,
  //   };

  //   HttpClient httpClient = HttpClient();
  //   HttpClientRequest request = await httpClient
  //       .postUrl(Uri.parse("https://ayoscan.id:7771/api/userzipay"));
  //   request.headers.set('content-type', 'application/json');
  //   request.add(utf8.encode(json.encode(body)));
  //   HttpClientResponse response = await request.close();
  //   // todo - you should check the response.statusCode
  //   if (response.statusCode == 200) {
  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("berhasil")));
  //   } else {
  //     // ScaffoldMessenger.of(context)
  //     //     .showSnackBar(SnackBar(content: Text("failed!")));
  //   }
  //   String reply = await response.transform(utf8.decoder).join();
  //   httpClient.close();
  //   return reply;
  // }
}
