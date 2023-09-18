import 'dart:convert';
import 'dart:math';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/otp/otpverivikasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

class OTPPAGE extends StatefulWidget {
  const OTPPAGE({Key? key}) : super(key: key);

  @override
  State<OTPPAGE> createState() => _OTPPAGEState();
}

class _OTPPAGEState extends State<OTPPAGE> {
  String nohp = "";
  String email = "";
  bool isLoading = false;
  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        email = prefs.getString('emailregister')!;
        nohp = prefs.getString('nohpregister')!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const RegisterPin(),
        //   ),
        // );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const RegisterPin(),
                    //   ),
                    // );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  )),
              Center(
                child: Container(
                  width: 150,
                  height: 120,
                  child: Image.asset("assets/images/ayoscan_logo.jpeg"),
                ),
              ),
              Container(
                width: 50,
              )
            ],
          ),
        ),
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
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset("assets/images/otpp.png"),
                    ),
                    SizedBox(
                      height: 120,
                    ),
                    InkWell(
                      onTap: () {
                        otpGmail();
                      },
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                otpGmail();
                              },
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(7),
                                  decoration: const BoxDecoration(
                                    color: whitePrimary,
                                    shape: BoxShape.circle,
                                  ),
                                  child:
                                      Image.asset("assets/images/emaill.png")),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Kirim OTP Melalui Email',
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  email,
                                  style: TextStyle(
                                      fontFamily: 'poppins', fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        dialogNull();
                      },
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                dialogNull();
                              },
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(7),
                                  decoration: const BoxDecoration(
                                    color: whitePrimary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                      "assets/images/whatsapp.png")),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Kirim OTP Melalui WhatsApp',
                                  style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "+" + nohp,
                                  style: TextStyle(
                                      fontFamily: 'poppins', fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  otpGmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String emailregister = prefs.getString('emailregister')!;
    final int min = 1000;
    final int max = 9999;
    var otpcodee = new Random().nextInt((max - min) + 1) + min;
    var otpacak = otpcodee.toString();
    prefs.setString('otpregis', otpacak);

    Map data = {
      'subject': "OTP Ayoscan Anda",
      'title': "OTP dari Ayocan",
      'body': otpacak,
      'emailto': emailregister,
      'emailPurpouse': 'register',
    };
    dynamic jsonResponse;
    var response = await http
        .post(Uri.parse("https://ayoscan.id/api/sendEmail"), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Otppageverifikasi();
        }));
      } else {
        print("Error");
      }
    }
  }

  datauser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nohp = prefs.getString('nohpregister')!;
    email = prefs.getString('emailregister')!;
  }

  Future dialogNull() {
    return showDialog(
        context: context,
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width / 5,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Image.asset(
                  'assets/trob.png',
                  height: 100,
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
                        style: TextStyle(fontFamily: 'poppins', fontSize: 15)),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  // ignore: deprecated_member_use
                ],
              ),
            ));
  }

  // onBackPressed() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(30)),
  //             content: Container(
  //               height: 150,
  //               decoration:
  //                   BoxDecoration(borderRadius: BorderRadius.circular(20)),
  //               child: Column(
  //                 children: [
  //                   const Text(
  //                     "Apakah Anda Yakin Tidak Ingin Melanjutkan Pendaftaran Ini ? ",
  //                     style: TextStyle(fontFamily: 'poppins', fontSize: 15),
  //                   ),
  //                   SizedBox(
  //                     height: 40,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       MaterialButton(
  //                         color: greenPrimary,
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10)),
  //                         onPressed: () {
  //                           Navigator.of(context).pop();
  //                         },
  //                         child: Text(
  //                           "Tidak",
  //                           style: TextStyle(
  //                               fontFamily: 'poppins',
  //                               fontSize: 15,
  //                               color: whitePrimary),
  //                         ),
  //                       ),
  //                       MaterialButton(
  //                         color: greenPrimary,
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10)),
  //                         onPressed: () {
  //                           setState(() {
  //                             isLoading = true;
  //                           });
  //                           // deleteBack();
  //                           Navigator.of(context).pop();
  //                         },
  //                         child: Text(
  //                           "Ya",
  //                           style: TextStyle(
  //                               fontFamily: 'poppins',
  //                               fontSize: 15,
  //                               color: whitePrimary),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ));
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

  openWhatsapp() async {
    const url =
        'https://api.whatsapp.com/send?phone=+6287700092197&text=Hi.. Admin Ayoscan, saya mau bertanya?';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openGmail() async {
    const url = 'mailto:ayoscan@gmail.com?subject=Support%20Ayoscan&body=';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
