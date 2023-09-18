// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/login.dart';
import 'package:ayoleg/lupapin/lupapin.dart';
import 'package:ayoleg/otp/pin_objact.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OtpForgot extends StatefulWidget {

  static String tag = 'otp_page';

  const OtpForgot({Key? key}) : super(key: key);

  @override
  _OtpForgot createState() => _OtpForgot();
}

class _OtpForgot extends State<OtpForgot> {
  var passotp = TextEditingController();
  String otpacak = "";
  String foto = "";
  String namaregister = "";
  String emailregister = "";
  String genderregister = "";
  String nohpregister = "";
  String pinregister = "";
  String codeotpregister = "";
  String imgios = "";

  bool visibleerorOTP = false;
  bool visibleBtnResend = false;
  bool visibleTextTimer = false;
  bool visibleTextwaktukirim = true;
  bool isLoading = false;
  TextEditingController pinotp1Controller = TextEditingController();
  TextEditingController pinotp2Controller = TextEditingController();
  TextEditingController pinotp3Controller = TextEditingController();
  TextEditingController pinotp4Controller = TextEditingController();

  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 120;

  int currentSeconds = 0;
  late SharedPreferences sharedPrefs;

  String otpacakpin = "";

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:'
      ' ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  // @override
  // void initState() {
  //   startTimeout();
  //   // _starttimeagain();
  //   super.initState();
  // }
  String emailAkun = "";

  @override
  void initState() {
    super.initState();
    startTimeout();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      setState(() {
        emailAkun = prefs.getString('emailregister')!;

        if (prefs.getString('otpcode')! == "") {
          codeotpregister = otpacak;
        } else {
          codeotpregister = prefs.getString('otpcode')!;
        }
        nohpregister = prefs.getString('nohpregister')!;
      });
    });
  }

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
            visibleBtnResend = true;
            visibleTextTimer = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('otpcode');
          });
          timer.cancel();
        }
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: ListView(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LupaPin()));
                    },
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
                    child: Image.asset("assets/images/ayoscan_logo.jpeg",
                        width: 200, height: 80)),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(1),
                    child: Text(
                      'Masukkan Kode OTP Anda',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )),

//
//                 Container(
//                   padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
//                   decoration: BoxDecoration(
//                     color: Colors.greencolorold,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     children: [
// //                      SizedBox(height: size.height * 0.06),
//                       _pinRowInputs(),
//                     ],
//                   ),
//                 ),

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
                                fontFamily: 'poppins',
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
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: greenPrimary),
                                  borderRadius: BorderRadius.circular(12)),
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
                                visibleerorOTP = false;
                              }
                            },

                            maxLength: 1,
                            style: TextStyle(
                                fontFamily: 'poppins',
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
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: greenPrimary),
                                  borderRadius: BorderRadius.circular(12)),
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
                                visibleerorOTP = false;
                              }
                            },

                            maxLength: 1,
                            style: TextStyle(
                                fontFamily: 'poppins',
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
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: greenPrimary),
                                  borderRadius: BorderRadius.circular(12)),
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
                                SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                    if (value.length == 1) {

                                      setState(() {
                                  isLoading = true;
                               
                                 
                                                  
                                          String otpregis =
                                              prefs.getString('otpregis')!;
                                          if (pinotp1Controller.text +
                                                  pinotp2Controller.text +
                                                  pinotp3Controller.text +
                                                  pinotp4Controller.text ==
                                              otpregis) {
                                                     sendforgot();

                                         
                                          } else {
                                            FocusScope.of(context).previousFocus();
                              
                                          }
                                });
                                      } else {
                                          setState(() {
                                             isLoading = true;
                                  visibleerorOTP = false;
                                });
                                      }
                                   
                                    // if (value.length == 0) {
                                    //   FocusScope.of(context).previousFocus();
                                    //   setState(() {
                                    //     visibletidakLengkap = false;
                                    //     visibleerorOTP = false;
                                    //   });
                                    // }
                                  },
                            // onChanged: (value) async {
                            //   if (value.length == 1) {
                            //     setState(() {
                            //       isLoading = true;
                            //       verifyOTP();
                            //     });
                            //   }
                            //   if (value.length == 0) {
                            //     FocusScope.of(context).previousFocus();
                            //     setState(() {
                            //       visibleerorOTP = false;
                            //     });
                            //   }
                            // },

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
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: greenPrimary),
                                  borderRadius: BorderRadius.circular(12)),
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
                  visible: isLoading,
                  child: Padding(
                      //ROW 1
                      padding: EdgeInsets.fromLTRB(120, 5, 120, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                        minimumSize: Size(80, 40), //////// HERE
                      ),
                      onPressed: () {
                        startTimeout();
                        setState(() {
                          visibleerorOTP = false;

                          sendEmail();
                          visibleBtnResend = false;
                          visibleTextTimer = true;
                        });
                      },
                      child: Text(
                        'Kirim Ulang OTP',
                        style: TextStyle(fontFamily: 'poppins'),
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
                            child: Image.asset("assets/images/emaill.png")),
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
            )));
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

  Future _onpindialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nohpAkun = prefs.getString('nohpregister');
    Map data = {
      'subject': "PIN Baru Dari Ayoscan",
      'title': "PIN baru dari Ayocan",
      'body': otpacakpin,
      'nohp': nohpAkun,
      'emailPurpouse': "forgot",
      'forgot_type': 'forgot_pin'
    };

    dynamic jsonResponse;
    var response = await http
        .post(Uri.parse("https://ayoscan.id/api/sendEmail"), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    title: new Text('Ayoscan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        )),
                    content: new Text(
                      'PIN Baru Ayoscan Anda Sudah Dikirim Ke Email Anda, Silahkan Cek Email Anda !',
                      style: TextStyle(
                        fontFamily: 'poppins',
                      ),
                    ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: greenPrimary),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  }));
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'poppins',
                                  ),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ));
      }
    } else {
      print("Error");
    }
  }

  verifyOTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String emailregister = prefs.getString('emailregister')!;

    Map data = {
      'otp': pinotp1Controller.text +
          pinotp2Controller.text +
          pinotp3Controller.text +
          pinotp4Controller.text,
      'email': emailregister,
      'type': 'ayoscan'
    };
    dynamic jsonResponse;
    var response = await http
        .post(Uri.parse("https://ayoscan.id/api/mail/verifyOtp"), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          sendforgot();
        });
      } else {}
    } else {
      setState(() {
        isLoading = false;
        visibleerorOTP = true;
      });
    }
  }
Future sendEmail() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String emailregister = prefs.getString('emailregister')!;
    // String namauser= prefs.getString("namaregister")!;
 final int min = 1000;
    final int max = 9999;
    var otpcodee = new Random().nextInt((max - min) + 1) + min;
    var otpacak = otpcodee.toString();
     prefs.setString('otpregis', otpacak);

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
          'to_name': " ",
          'from_name': "AYOSCAN",
          'to_email': emailregister,
          'message': otpacak
        }
      }));

       if (response.statusCode == 200) {
      
       }
  // return response.statusCode;
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
  //     'subject': "OTP Lupa PIN Dari Ayoscan",
  //     'title': "OTP dari Ayocan",
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
  //     } else {
  //       print("Error");
  //     }
  //   }
  // }

  // Future kirimOtpEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove("otpcode");

  //   final int min = 1000;
  //   final int max = 9999;
  //   var otpcodee = new Random().nextInt((max - min) + 1) + min;
  //   otpacak = otpcodee.toString();
  //   String? nohpAkun = prefs.getString('nohpregister');

  //   setState(() {
  //     prefs.remove("otpcode");
  //     prefs.setString("otpcode", otpacak);
  //   });

  //   Map data = {
  //     'subject': "OTP Lupa PIN Dari Ayoscan",
  //     'title': "OTP Lupa PIN Ayoscan",
  //     'body': otpacak,
  //     'nohp': nohpAkun,
  //     'emailPurpouse': 'forgot',
  //     'forgot_type': 'forgot_otp'
  //   };

  //   dynamic jsonResponse;
  //   var response = await http
  //       .post(Uri.parse("https://ayoscan.id/api/sendEmail"), body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       // Navigator.pushReplacement(context,
  //       //     MaterialPageRoute(builder: (context) {
  //       //   return CustomNavBar();
  //       // }));
  //     }
  //   } else {
  //     print("Error");
  //   }
  // }

  // Future<String> otpverivikasi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  //   DateFormat timeformat = DateFormat("HH:mm:ss");
  //   String createDate = dateFormat.format(DateTime.now());
  //   String createtime = timeformat.format(DateTime.now());

  //   final int min = 1000;
  //   final int max = 9999;
  //   var otpcodee = new Random().nextInt((max - min) + 1) + min;
  //   codeotpregister = otpcodee.toString();

  //   prefs.setString("otpcode", codeotpregister);

  //   final body = {
  //     'is_Flash': false,
  //     'is_Unicode': false,
  //     'apiKey': "tuNcvoP4EbxseRQHx9MqP1cfLLcBwwNznqJ9qdyzTMI=",
  //     'message': "KODE RAHASIA AYOSCAN: " +
  //         codeotpregister +
  //         " BERLAKU HINGGA " +
  //         createDate +
  //         " " +
  //         createtime +
  //         " WIB WASPADA PENIPUAN! JANGAN BERIKAN KODE RAHASIA KE SIAPAPUN",
  //     'mobileNumbers': nohpregister,
  //     'clientId': "d3e7fd85-6e6f-4a0c-b9c9-2448b8f769f0",
  //     'senderId': "Ayoscan",
  //   };

  //   HttpClient httpClient = new HttpClient();
  //   HttpClientRequest request = await httpClient
  //       .postUrl(Uri.parse("https://api.tcastsms.net/api/v2/SendSMS?"));
  //   request.headers.set('content-type', 'application/json');
  //   request.add(utf8.encode(json.encode(body)));
  //   HttpClientResponse response = await request.close();
  //   // todo - you should check the response.statusCode
  //   if (response.statusCode == 200) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Code OTP Sedang Dikirim!")));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Code OTP gagal terkirim!")));
  //   }
  //   String reply = await response.transform(utf8.decoder).join();
  //   httpClient.close();
  //   return reply;
  // }

  sendforgot() async {
    // ignore: unused_local_variable
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nohp = prefs.getString('nohpregister')!;
    final int min = 100000;
    final int max = 999999;
    var otpcodee = new Random().nextInt((max - min) + 1) + min;
    otpacakpin = otpcodee.toString();

    Map data = {'nohp': nohp, 'usrpin': otpacakpin, 'forgot': 'true'};

    var jsonResponse;
    var response = await http
        .post(Uri.parse("https://ayoscan.id/api/updatePin"), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        setState(() {
          _onpindialog();
        });
      }
    }
  }
}
