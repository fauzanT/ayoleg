// ignore_for_file: unused_field, unused_local_variable

import 'dart:convert';
import 'dart:io';
// import 'dart:io' show Platform;
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/camera.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/component/navbar/navbarpendukung.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
// import 'package:ayoleg/lupapin/lupapin.dart';
import 'package:ayoleg/register.dart';
import 'package:ayoleg/reveral.dart';
import 'package:ayoleg/welcome/welcome.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:camera/camera.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  bool _passwordVisible = false;

  String tokennotife = "";
  late SharedPreferences sharedPrefs;
  String Fotobanner1 = "";
  String Fotobanner2 = "";
  String Fotobanner3 = "";
  String Fotobanner4 = "";
  String Fotobanner5 = "";

  @override
  void initState() {

    cekbanner();
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        // tokennotife = prefs.getString('token_notif')!;
        Fotobanner1 = prefs.getString('Fotobanner1')!;
        Fotobanner2 = prefs.getString('Fotobanner2')!;
        Fotobanner3 = prefs.getString('Fotobanner3')!;
        Fotobanner4 = prefs.getString('Fotobanner4')!;
        Fotobanner5 = prefs.getString('Fotobanner5')!;


      });
    });

    super.initState();
  }
  var nohpcontrollel = TextEditingController();
  var passwordcontrolel = TextEditingController();

  final String requiredNumber = '123456';
  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController pin3Controller = TextEditingController();
  TextEditingController pin4Controller = TextEditingController();
  TextEditingController pin5Controller = TextEditingController();
  TextEditingController pin6Controller = TextEditingController();

  bool visiblenohp = false;
  bool visiblepassword = false;
  bool visiblepasswordvalid = false;
  bool visibleerorlogin = false;
  bool visiblepinsalah = false;
  bool visiblelogindevice = false;
  bool visiblenohpkurangdari9 = false;
  bool visiblepinblmlengkap = false;
  bool visiblepinsalahh = false;
  bool visibleUwisLogin = false;
  String device = "";
  String stslog = "";
  String stspesan = "";

  bool isLoading = false;
  bool visible = false;

  String? selectedOption; // Store the selected option
  List<String> options = ['Option 1', 'Option 2', 'Option 3']; // List of options

  Future<void> onBackPressed() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  const WelcomePage()));
      // Navigator.pushNamedAndRemoveUntil(
      //     context, '/WelcomePage', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    return WillPopScope(
      onWillPop: () async {
        onBackPressed(); // Action to perform on back pressed
        return false;
      },
      child: Stack(
        children: [
          Container(
            color: whitePrimary,
            height: size.height,
            width: size.width,
            // child: Image.asset(
            //   "assets/images/g7.png",
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   alignment: Alignment.bottomCenter,
            // ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              // toolbarHeight: 100,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    // FadeInUp(
                    //   duration: const Duration(milliseconds: 400),
                    //   child: Container(
                    //     width: 100,
                    //     height: 80,
                    //     child: Image.asset("assets/images/logocaleg4.jpg"),
                    //   ),
                    // ),

                    FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      child: InkWell(
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
                          child: const Icon(Icons.support_agent),
                        ),
                        onTap: () {
                          setState(() async {

                            openWhatsapp();
                          });
                        },
                      ),
                    )

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         openwhatsapp();
                    //       },
                    //       child:
                    //     ),
                    //     // const Text(
                    //     //   'Bantuan',
                    //     //   style: TextStyle(
                    //     //       color: textPrimary,
                    //     //       fontSize: 12,
                    //     //       fontWeight: FontWeight.bold),
                    //     // ),
                    //   ],
                    // ),
                  ]),
              backgroundColor: whitePrimary,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: whitePrimary,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              elevation: 0,
            ),
            body:
            SingleChildScrollView(
              child: Column(
                children: [
                  // const Center(
                  //
                  //   child: Text(
                  //     'Masuk',
                  //     style: TextStyle(
                  //         color: textPrimary,
                  //         fontSize: 25,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // Center(
                  //   child: FadeInUp(
                  //     duration: const Duration(milliseconds: 800),
                  //     child: ImageSlideshow(
                  //       // width: size.width,
                  //       // height: size.width,
                  //       height: 250,
                  //       initialPage: 0,
                  //       children: [
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child:   Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner1,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder: (context, child, loadingProgress) =>
                  //                 (loadingProgress == null)
                  //                     ? child
                  //                     : const Center(
                  //                   child: CircularProgressIndicator(),
                  //                 ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     const Duration(milliseconds: 0),
                  //                         () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           const CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return const SizedBox.shrink();
                  //                 },
                  //               ),
                  //
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child:Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner2,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder: (context, child, loadingProgress) =>
                  //                 (loadingProgress == null)
                  //                     ? child
                  //                     : const Center(
                  //                   child: CircularProgressIndicator(),
                  //                 ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     const Duration(milliseconds: 0),
                  //                         () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           const CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return const SizedBox.shrink();
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child: Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner3,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder: (context, child, loadingProgress) =>
                  //                 (loadingProgress == null)
                  //                     ? child
                  //                     : const Center(
                  //                   child: CircularProgressIndicator(),
                  //                 ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     const Duration(milliseconds: 0),
                  //                         () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           const CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return const SizedBox.shrink();
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child:Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner4,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder: (context, child, loadingProgress) =>
                  //                 (loadingProgress == null)
                  //                     ? child
                  //                     : const Center(
                  //                   child: CircularProgressIndicator(),
                  //                 ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     const Duration(milliseconds: 0),
                  //                         () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           const CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return const SizedBox.shrink();
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child: Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner5,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder: (context, child, loadingProgress) =>
                  //                 (loadingProgress == null)
                  //                     ? child
                  //                     : const Center(
                  //                   child: CircularProgressIndicator(),
                  //                 ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     const Duration(milliseconds: 0),
                  //                         () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           const CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return const SizedBox.shrink();
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //
                  //       ],
                  //       onPageChanged: (value) {
                  //         // print('Page changed: $value');
                  //       },
                  //       autoPlayInterval: 5000,
                  //       isLoop: true,
                  //     ),
                  //   ),
                  // ),
                  Center(
                    child: Container(
                      width: 180,
                      height: 200,
                      child: Image.asset(
                        'assets/images/logocaleg4.jpg',
                        // height: 80,
                      ),
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   width: 50,
                  //   child: Image.asset('assets/images/avatarlogin.png'),
                  // ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    child: const Row(
                      children: [
                        SizedBox(
                            width: 20,
                          height: 20,
                        ),
                        Text(
                          "No. HP",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  FadeInUp(
                    duration: const Duration(milliseconds: 900),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^0+'),
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^1+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^2+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^3+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^4+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^5+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^6+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^7+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^9+'), //users can't type 0 at 1st position
                          ),
                        ],
                        controller: nohpcontrollel,
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                nohpcontrollel.clear();
                                passwordcontrolel.clear();

                                setState(() {

                                  visiblenohpkurangdari9 = false;
                                  isLoading = false;
                                  visiblenohp = false;
                                  visiblepassword = false;
                                  visiblelogindevice = false;
                                  visibleerorlogin = false;
                                  visiblepinsalah = false;
                                  visiblenohpkurangdari9 = false;
                                  visiblepinblmlengkap = false;
                                  visiblepinsalahh = false;
                                  visiblepasswordvalid = false;

                                });
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: greenPrimary,
                              )),
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(
                                top: 12.0, left: 10.0, right: 10.0),
                            child: const Text(
                              '+62',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  color: greenPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          fillColor: whitePrimary,
                          hintText: "8xxxxxxxxxx",
                          hintStyle: const TextStyle(
                              fontFamily: 'poppins', color: greyPrimary),
                          filled: true,
                        ),
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblenohpkurangdari9,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'No. HP Tidak Valid !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visiblenohp,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'Masukkan No. HP !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 25),
                          child: const Text(
                            "Kata Sandi",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // _obscureText
                        //     ? Container(
                        //         padding: EdgeInsets.only(right: 20),
                        //         child: IconButton(
                        //             onPressed: () {
                        //               setState(() {
                        //                 _obscureText = false;
                        //               });
                        //             },
                        //             icon: Icon(
                        //               Icons.visibility,
                        //               color: greenPrimary,
                        //             )))
                        //     : Container(
                        //         padding: EdgeInsets.only(right: 20),
                        //         child: IconButton(
                        //             onPressed: () {
                        //               setState(() {
                        //                 _obscureText = true;
                        //               });
                        //             },
                        //             icon: Icon(
                        //               Icons.visibility_off,
                        //               color: greenPrimary,
                        //             )))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: TextFormField(

                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        controller: passwordcontrolel,
                          obscureText: !_passwordVisible,
                        decoration:  InputDecoration(

                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greenPrimary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greenPrimary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greenPrimary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greenPrimary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: greenPrimary,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          fillColor: whitePrimary,
                          hintText: "Kata Sandi",
                          hintStyle: const TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        autofocus: false,

                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                  ),

                  Visibility(
                    visible: visiblepassword,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'Masukkan Kata Sandi !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visiblepasswordvalid,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'Kata Sandi Salah !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: visibleerorlogin,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'No. HP Belum Terdaftar !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visiblelogindevice,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'No. HP Sudah Masuk Di Device Lain !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visiblepinsalahh,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'Password Salah !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visibleUwisLogin,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'Akun Sudah Login Di Device Lain !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
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
                          setState(() {
                            isLoading = true;

                            signIn();

                          });
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
                                    'Masuk',
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

                  FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum Punya Akun ?',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            color: textPrimary,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Navigator.pushNamed(context, '/RegisterPage');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Reveralcodepage()));


                          },
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // FadeInUp(
                  //   duration: Duration(milliseconds: 1600),
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (BuildContext context) =>
                  //                   const LupaPin()));
                  //     },
                  //     child: const Text(
                  //       'Lupa PIN',
                  //       style: TextStyle(
                  //         fontFamily: 'poppins',
                  //         color: greenPrimary,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15,
                  //         decoration: TextDecoration.underline,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 300,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // cektrobLOG() async {
  //   Map data = {
  //     'nama_app': 'ayoscan',
  //   };
  //   dynamic jsonResponse;
  //   var response = await http.post(Uri.parse("https://ayoscan.id/api/cekTrob"),
  //       body: data);

  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);

  //     if (jsonResponse != null) {
  //       setState(() {
  //         stspesan = jsonResponse['datacek']['pesan'];
  //         stslog = jsonResponse['datacek']['sts_log'];
  //       });
  //     } else {
  //       pesantroble(jsonResponse['datacek']['pesan']);
  //     }
  //   } else {
  //     pesantroblegaguan();
  //   }
  // }

  Future pesantroble(String trob) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Image.asset(
                'assets/trob.png',
                height: 100,
                width: 100,
              ),
              content: Text(trob),
              actions: <Widget>[
                // ignore: deprecated_member_use
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  Future pesantroble500() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Image.asset(
                'assets/trob.png',
                height: 100,
                width: 100,
              ),
              content: const Text(
                  "Terjadi Gangguan Jaringan, Silahkan Periksa Jaringan"),
              actions: <Widget>[
                // ignore: deprecated_member_use
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context, false),
                ),
                // ignore: deprecated_member_use
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

  // String generateMd5(String input) {
  //   return md5.convert(utf8.encode(input)).toString();
  // }

  signIn() async {
    if (nohpcontrollel.text.isEmpty) {
      setState(() {
        visiblepasswordvalid = false;
        visiblenohpkurangdari9 = false;
        visiblenohp = true;
        visiblepassword = false;
        isLoading = false;
        visiblelogindevice = false;
        visibleerorlogin = false;
        visiblepinsalah = false;
        visiblepinsalahh = false;
        visiblepinblmlengkap = false;
        visibleUwisLogin = false;
      });
    }else if (nohpcontrollel.text.length < 9) {
      setState(() {
        visiblepasswordvalid = false;
        visiblenohpkurangdari9 = true;
        visiblenohp = false;
        visiblepassword = false;
        isLoading = false;
        visiblelogindevice = false;
        visibleerorlogin = false;
        visiblepinsalah = false;
        visiblepinsalahh = false;
        visiblepinblmlengkap = false;
        visibleUwisLogin = false;
      });
    } else if (passwordcontrolel.text.isEmpty) {
      setState(() {
        visiblepasswordvalid = false;
        visiblenohpkurangdari9 = false;
        visiblenohp = false;
        visiblepassword = true;
        isLoading = false;
        visiblelogindevice = false;
        visibleerorlogin = false;
        visiblepinsalah = false;
        visiblepinblmlengkap = false;
        visiblepinsalahh = false;
        visibleUwisLogin = false;
      });
    } else {
      setState(() {
        visiblepasswordvalid = false;
        visiblenohpkurangdari9 = false;
        isLoading = true;
        ceknohp();
        visiblenohp = false;
        visiblepassword = false;
        visiblelogindevice = false;
        visibleerorlogin = false;
        visiblepinsalah = false;
        visiblepinblmlengkap = false;
        visiblepinsalahh = false;
      });
    }
  }


  ceknohp() async {
    Map data = {'usrhp': "62" + nohpcontrollel.text};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/ceknohp.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        if (jsonResponse['data'] != null) {

          if(jsonResponse['data']['usract'] == "N"){
            setState(() {
              _ondialogact();
              visiblenohpkurangdari9 = false;
              isLoading = false;
              visiblenohp = false;
              visiblepassword = false;
              visiblelogindevice = false;
              visibleerorlogin = false;
              visiblepinsalah = false;
              visiblenohpkurangdari9 = false;
              visiblepinblmlengkap = false;
              visiblepinsalahh = false;
              visiblepasswordvalid = false;
            });

          }else{
            if(jsonResponse['data']['usrpas'] == passwordcontrolel.text){
              setState(() {
                masuklogin();
                visiblepasswordvalid = false;
                visiblenohpkurangdari9 = false;
                isLoading = true;
                visiblenohp = false;
                visiblepassword = false;
                visiblelogindevice = false;
                visibleerorlogin = false;
                visiblepinsalah = false;
                visiblenohpkurangdari9 = false;
                visiblepinblmlengkap = false;
                visiblepinsalahh = false;
              });

            }else{
              setState(() {
                visiblenohpkurangdari9 = false;
                isLoading = false;
                visiblenohp = false;
                visiblepassword = false;
                visiblelogindevice = false;
                visibleerorlogin = false;
                visiblepinsalah = false;
                visiblenohpkurangdari9 = false;
                visiblepinblmlengkap = false;
                visiblepinsalahh = false;
                visiblepasswordvalid = true;
              });
            }
          }


        } else {
          setState(() {
            visiblenohpkurangdari9 = false;
            isLoading = false;
            visiblenohp = false;
            visiblepassword = false;
            visiblelogindevice = false;
            visibleerorlogin = true;
            visiblepinsalah = false;
            visiblenohpkurangdari9 = false;
            visiblepinblmlengkap = false;
            visiblepinsalahh = false;
            visiblepasswordvalid = false;
          });
        }

      }
    }
  }

  masuklogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String tokenNotif = prefs.getString('token_notif')!;

    Map data = {
      'usrhp': "62" + nohpcontrollel.text,
      'usrpas': passwordcontrolel.text,
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/login.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        if (jsonResponse['datalogin'] != null) {
          setState(() {
            prefs.setString("nohpregister", jsonResponse['datalogin']['usrhp']);
            prefs.setString("namaregister", jsonResponse['datalogin']['usrnm']);
            prefs.setString('usrsts', jsonResponse['datalogin']['usrsts']);
            prefs.setString('fotoregister', jsonResponse['datalogin']['usrft']);

            prefs.setString("kodecaleg", jsonResponse['datalogin']['usrkc']);
            prefs.setString("nikregister", jsonResponse['datalogin']['usrnik']);

            prefs.setString("gender", jsonResponse['datalogin']['usrjk']);
            prefs.setString(
                "emailregister", jsonResponse['datalogin']['usrema']);

            prefs.setString("kodereferal", jsonResponse['datalogin']['usrkp']);
            prefs.setString(
                "passwordregister", jsonResponse['datalogin']['usrpas']);
            // prefs.setString(
            //     "tgglbergabung", jsonResponse['datalogin']['usrdd'] +" "+jsonResponse['datalogin']['usrtd'] );
            // prefs.setString(
            //     "tanggallahirregis", jsonResponse['datalogin']['usrtlh']);
            // prefs.setString(
            //     "agamaregister", jsonResponse['datalogin']['usragm']);
            // prefs.setString(
            //     "statuskawinregis", jsonResponse['datalogin']['usrsp']);
            // prefs.setString(
            //     "pekerjaanregister", jsonResponse['datalogin']['usrpkj']);
            prefs.setString(
                "daerahpemilihan", jsonResponse['datalogin']['usrdpl']);
            prefs.setString(
                "profinsi1register", jsonResponse['datalogin']['usrpr1']);
            prefs.setString(
                "kota1register", jsonResponse['datalogin']['usrkt1']);
            prefs.setString(
                "kecamatan1register", jsonResponse['datalogin']['usrkec1']);
            prefs.setString(
                "kelurahan1register", jsonResponse['datalogin']['usrkel1']);
            prefs.setString("rw1register", jsonResponse['datalogin']['usrrw1']);
            prefs.setString("rt1register", jsonResponse['datalogin']['usrrt1']);
            prefs.setString(
                "alamatktp1register", jsonResponse['datalogin']['usralm1']);
            prefs.setString("notpsgister", jsonResponse['datalogin']['usrtps']);
            prefs.setString("showcase", "1");
            updatetoken();



            if (jsonResponse['datalogin']['usrsts'] == "A") {
              setState(() {
                prefs.setString('status', "Admin");
                prefs.setString('token', "admin");
                cekkodecaleg(jsonResponse['datalogin']['usrkc']);
                cekcalegadmin(jsonResponse['datalogin']['usrkc']);

              });
            }
            else if (jsonResponse['datalogin']['usrsts'] == "R") {
              setState(() {
                prefs.setString('status', "Relawan");
                prefs.setString("nohprelawancaleg", jsonResponse['datalogin']['usrhp']);
                prefs.setString('token', "relawan");
                cekkodecaleg(jsonResponse['datalogin']['usrkc']);
                cekcalegrelawan(jsonResponse['datalogin']['usrkc']);

              });
            }
            else if (jsonResponse['datalogin']['usrsts'] == "P") {
              setState(() {
                prefs.setString('status', "Pendukung");
                prefs.setString("nohprelawancaleg", jsonResponse['datalogin']['usrhp']);
                prefs.setString('token', "Pendukung");
                cekkodecaleg(jsonResponse['datalogin']['usrkc']);
                cekcalegpendukung(jsonResponse['datalogin']['usrkc'],jsonResponse['datalogin']['usrhp']);


              });
            }
            else if (jsonResponse['datalogin']['usrsts'] == "C") {
              setState(() {
                prefs.setString('status', "Calon Legislatif");
                cekkodecaleg(jsonResponse['datalogin']['usrkc']);
                cekcalegadmin(jsonResponse['datalogin']['usrkc']);
                prefs.setString('token', "admin");
              });
            } else {
              setState(() {

                prefs.setString('token', "saksi");
                prefs.setString('status', "Saksi");
                prefs.setString("usrdpl", jsonResponse['datalogin']['usrdpl']);
                prefs.setString("usrtps", jsonResponse['datalogin']['usrtps']);
                cekkodecaleg(jsonResponse['datalogin']['usrkc']);
                cekcalegrelawan(jsonResponse['datalogin']['usrkc']);
              });
            }
            prefs.setString("fotoktpkosong",
                "/9j/4AAQSkZJRgABAQEAYABgAAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCADOAOADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9pvt1zR9uuabRQA77dc0fbrmm0UAO+3XNH265ptFADvt1zR9uuabRQA77dc0fbrmm0UAO+3XNH265ptFADvt1zR9uuabRQA77dc0fbrmm0UAO+3XNH265ptFADvt1zR9uuabRQA77dc0fbrmm0UAO+3XNH265ptFADvt1zR9uuabRQA77dc0fbrmm0UAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRUlAEdFb02h6boOm/adRuv+29xP5UdZNnrnhLXv+Qdr2n/APf+gCvRW1/wh1z/AMu91b1Vm8OXP/PrQBn0U+aCmUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABVzQYPt+p21ZuparbWH+kXF1b2lHw98cW2valc/Z/wDl0h/19AHnn7YHim5v/Emm6b/y62kPn/8AbV68p03SrnXdS+zW9rcXd1/07webJW38cvEf9vfFnW7n/pt5H/fHyV7l+xd4d+w/Da51Bv8Aj5vbvGT/AM804H83oA8Ahvtb8JH/AJjGk/8Af2Gt/SP2i/Fmgj/kKfa/+u8EUtfYF5p8GoJ++ghuPqAa5fXPgV4T8Qr/AKRoOn/9sV8n/wBAoA8U0f8AbE1L/mI6Xp93/wBe8/lV0mm/tUeEr/8A5CGl6haf9sPO/wDQK1dd/Yx8N6h/x73WsWfHTz/OjH/fdcbrf7EetWY/4luvafd/9fFv5P8A8coA7zTfH/gnXv8Aj3163tP+2/lf+h1uQ+Fba/8A+Pe6t7uvnLxH+zd418Jn7RcaX9stR/z7z+d/45XDWerXNh/x73Vxaf8AXv8AuqAPrybwrc1n1zv7K/xb1Lx3/aWm6hdfav7JhjuIJ/8Alp5f9x67LxJ/yErmgDPooooAKKKKACiiigAooooAKKKKACiiigAoqHUr77Bptzc/8+leZ698TtS17/p0tf8Ap3/+LoA77XvGOm6D/wAfF1/2w/5aVx2vfFu5vv8AkHf6J/6Mrk/m9qPm9qAH3l9c3w+03F1cXdem/AyD7B4c1LUv+m3/AKBHXl/ze1ej6xP/AMIl+zhc/wDXnJ/5G/8A26APnjUtV+36lc3H/P3NJcf9919o/s+aL/YHwW8N2v8A05if/vv5/wD2eviHTYP7Q1K2tv8An7mjt/8Avuv0K0rTxYabb2+f+PeIRfoP8KALlFFFABRRRQAV8EfEK+tr/wAba3c2/wDx6/2lceR/38r7d8ca4PCfgzVNQ/58rSS4/wC+Er8+fPoA+kP2J9K/4lutal/02jg/74j3/wDs6V6BqU/27Urmsj9mOx/sH4A6bc/8/fmX/wD5Eq/QAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBDqVj9v025tv+fuGvF7yx+wal9muK9urzr4taF9h1L+0v+fv/wBG0Acn83tR83tR83tR83tQAkMH2/8A0auy/a61X+wfhLbab/z93kcH/bJE3/8AxFZHw3sft/jbTf8Art9o/wC+PnrI/be8R/8AFS6Jpv8Az6QyT/8Afb//AGFAHI/s2aL/AMJT8afDluei3f2j/viPfX3pXxX+xXNb6H401rxJqH/Hr4e0h7ief/f/AMvWt8X/ANuLWvFn+i+Ff+JVaf8APY/8fEv/AMRQB9YQ6vbS3zWy3Fu1xbjMsQb50GP7tXq+B/gH8Wbj4b/Fi21q6urg2l3+4vgf+WsT/wDLT/2pX294i8Y6X4Q0kX2o6la2dmo/1002B+H96gDaqGW5FomZm/EV89/Er9vTTdO/0fwrpjaw3/Pxcnyrf/vj77fhXz/8QPjb4j+K+f7Y1Ke6tW5MH+pto/8AgFAH0/8AtMfFvTdQ+AniQ6PqlvdFpo9KlmgP7sSO43x7v9zPSvj7zq9M+JH/ABSX7LvgnTf+hhvLjVp//QE/9DSuE+Felf8ACW/EjRNN/wCfu8j/APRnz0AfbGm6V/wiXw303Tf+fSzt4Kyq3vG0/wDx7Vg0AFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFZfjDQ/7e8N3Nv/AN+P+utalFAHh3ze1Hze1b/xI0P7B4k/6dbv9/8A/F1gfN7UAdr8B7H/AIqO5uf+fSH/ANDrxP8Aao8R/wBvfGzW/wDp08uw/wC+I/8A4uvof4BWX/FNXNz/AM/c3/oFfHXjbxH/AG9421LUv+fu8kn/APIlAHt37JvhS2+Jnw58aeG7fUrfS9U1U25z/rfMtk/+zzS+Iv2GvGuhjNsdP1f/AK95/Kk/8fr59hvvsH+k2/8Aon/oyu18O/tL+PvCo/ceJ9Xb/r4m86L/AMfoAteKvg74t8Jf8hHQdYtP+m/kfu/++0rE1LXLnXv+Pi6uLv7J+4/0ifzfK/2K9P8ADP8AwUN8a6af+Jha6Tq3/bExSf8AjldMf20fAPjz/kavAf8A23t/Kuv/AI29AHgXze1Phg+3/wCjf8/de8Gz+Afjr/j31LUPCl1284yxRn/v5vjq74e/Zh8N6D4l03xFb+PNB1XQdJuo7iczzR8RJ8/+sR8UAcP+2lcfYfGuh+G/+hf0G2g/7a/52VF+xbof9vfH62uf+gTDJP8A+Q9n/s9cP8efHlv8R/jP4i1m3bda3N2BCf8AntGnyJ/6BXtX/BOvQv8AkZNb/wCudhB/6G//ALJQB7r4wn/4mVZVWNYn+3alc1XoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOe+JGh/wBveG/+nq0/f/8AxdeX/N7V7jXj/jDQ/wCwfElzbf8Afj/rlQB3/wADfEdt/Zv9m/8AL1aTf9/d9eS/Fr9ibUv+Ekubnwrdaf8AZbubz/sNx+6ki/3P9irum6Vc3/8Ax72txd16J4V8La5Yf8fGqXFp/wBMLefzaAPl3Xv2c/G2g/8AHx4X1D/t3/e/+gVxupWNzoP/AB8Wtxaf9fEHlV+h2meI7mwqzdeIbXXB9l1DS7e6A7T/AL3/ANDoA/OT7TR9pr7u174EfDfxb/x8eF9PtP8Ar3/0X/0CuJ179gPwTrv/ACDte1jSf+28V1H/AOP0AfI/2moa+iPEn/BOfW7D/kC69o93/wBfEEsUn/tSuB8Sfsd/EjQP+YDcXf8A14TxS/8A2ygDzv7TX2n+w1ov9g/s4/2l/wBBa8uLj/vj5E/9Ar5Q0H4H+Lde8Sf2bb+F9Y+1f9PEEsUcX++7191eFfB3/Cs/hLpuif8APpZxwf8AXWX+OgCnRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFVdT0Sz1v/AI/LaG4+q1aooAjttOtdO/49bdbf/dNSUUUAFFFFABRRRQA+1upbX7r/AKVbTxJeJ/y2aqNFAG0nje6T0/OqGoazNf8A3m21UooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA/9k=");

            prefs.setString("targetpendukunghome", jsonResponse['datalogin']['usrtpd']);




          });
        } else {
          setState(() {
            isLoading = false;
            visibleerorlogin = true;
          });
        }
      } else {
        setState(() {
          isLoading = false;
          visibleerorlogin = true;
        });
      }
    } else {
      setState(() {
        isLoading = false;
        visibleerorlogin = true;
      });
    }
  }

  updatetoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokennotife = prefs.getString('token_notif')!;
    Map data = {
      'usrhp': "62" + nohpcontrollel.text,
      'tkn': tokennotife,

    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/updatetoken.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
      } else {
      }
    } else {}
  }

  cekkodecaleg(String kdkc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {'kdkc': kdkc};

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
          // prefs.setString('jumlahkursi', jsonResponse['kodecaleg']['kdjk']);
          prefs.setString('kdweb', jsonResponse['kodecaleg']['kdweb']);






          // prefs.setInt("targetsuara", jsonResponse['kodecaleg']['kdts']);
          // prefs.setInt("targetrelawan", jsonResponse['kodecaleg']['kdtr']);
          // prefs.setInt("targetpendukung", jsonResponse['kodecaleg']['kdpd']);
          // prefs.setInt("jumlahkursi", jsonResponse['kodecaleg']['kdjk']);

          // SharedPreferences prefs = await SharedPreferences.getInstance();
        });
      } else {}
    }
  }

  cekcalegadmin(String usrkc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {'usrkc': usrkc, 'usrsts': "C"};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekcaleg.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          prefs.setString('tokencaleg', jsonResponse['data']['tkn']);
          prefs.setString("namacaleg", jsonResponse['data']['usrnm']);
          prefs.setString('usrtkccaleg', jsonResponse['data']['usrtkc']);

          tokennotife = prefs.getString('token_notif')!;
          notifyLogin(tokennotife);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const CustomNavBar();
              }));
          isLoading = false;
          visibleerorlogin = false;

        });
      } else {}
    }
  }
  cekcalegrelawan(String usrkc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {'usrkc': usrkc, 'usrsts': "C"};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekcaleg.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          prefs.setString('tokencaleg', jsonResponse['data']['tkn']);
          prefs.setString("namacaleg", jsonResponse['data']['usrnm']);
          prefs.setString('usrtkccaleg', jsonResponse['data']['usrtkc']);
          tokennotife = prefs.getString('token_notif')!;
          notifyLogin(tokennotife);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const CustomNavRelawanBar();
              }));
          isLoading = false;
          visibleerorlogin = false;

        });
      } else {}
    }
  }
  cekcalegpendukung(String usrkc,String nohppendukung) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    Map data = {'usrkc': usrkc, 'usrsts': "C"};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekcaleg.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          prefs.setString("nohppendukungpendukungg", nohppendukung);
          prefs.setString('tokencaleg', jsonResponse['data']['tkn']);
          prefs.setString("namacaleg", jsonResponse['data']['usrnm']);
          prefs.setString('usrtkccaleg', jsonResponse['data']['usrtkc']);
          tokennotife = prefs.getString('token_notif')!;
          notifyLogin(tokennotife);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const CustomNavPendukungBar();
              }));
          isLoading = false;
          visibleerorlogin = false;

        });
      } else {}
    }
  }
  Future _ondialogact() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Image.asset(
                'assets/images/notfound.png',
                height: 100,
                width: 100,
              ),
              content:    Text(
                "                Akun Tidak Ada !",
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: greenPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),

                  onPressed: () {
                    Navigator.pop(context, false);

                        nohpcontrollel.clear();
                    passwordcontrolel.clear();
                  },
                ),
              ],
            ));
  }



  Future<String> notifyLogin(String token) async {
    // prefs.setString('tokencaleg', jsonResponse['data']['tkn']);

    final body = {
      "to" : token,
      "notification" : {
        "body" : "Selamat Datang Aplikasi Ayocaleg",
        "title": "Berhasil Masuk"
      }
    };

    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse("https://fcm.googleapis.com/fcm/send"));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'key = AAAAfPCPk3E:APA91bFJL-PIwHPisx821MZbmqEGq0EF_wWXDzf3ZpWGbV_7NZQBUy751J68ljDkGjXsd68upJE9E8GYGjOQN4eKpcnKAhlJpJc96Ee9tu4hUeZgIL8Glh90Sl6_N5MFDx_ihGBXC_vK');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    if (response.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("berhasil")));
    } else {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("failed!")));
    }
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
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
