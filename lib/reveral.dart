import 'dart:convert';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/login.dart';
import 'package:ayoleg/otp/otpverivikasi.dart';
import 'package:ayoleg/register.dart';
import 'package:ayoleg/registerpendukung.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Reveralcodepage extends StatefulWidget {
  const Reveralcodepage({Key? key}) : super(key: key);

  @override
  State<Reveralcodepage> createState() => _ReveralcodepageState();
}

class _ReveralcodepageState extends State<Reveralcodepage> {
  bool check = false;
  String nohp = "";
  String email = "";
  String Statusreferal = "";
  bool isLoading = false;
  int? _value;
  String radioButtonItem = "";
  var kodereveralpagecontrolel = TextEditingController();
  var nohreveralcontrolele = TextEditingController();

  bool visiblekodereveralpageValid = false;
  bool visiblekodereferalpagesalah = false;
  bool visiblnohpreveral = false;
  bool visiblekodereveralpage = false;
  bool visiblebuttonkodereveral = false;
  bool visiblebutttonnohpreveral = false;
  bool visiblenohpreferalpagesalah = false;
  bool visiblenohpreferalvalid = false;

  bool visiblesetujuprivacycek = true;
  bool visiblesetujuprivacynotcek = false;

  late SharedPreferences sharedPrefs;
  String Fotobanner1 = "";
  String Fotobanner2 = "";
  String Fotobanner3 = "";
  String Fotobanner4 = "";
  String Fotobanner5 = "";

  @override
  void initState() {
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        Fotobanner1 = prefs.getString('Fotobanner1')!;
        Fotobanner2 = prefs.getString('Fotobanner2')!;
        Fotobanner3 = prefs.getString('Fotobanner3')!;
        Fotobanner4 = prefs.getString('Fotobanner4')!;
        Fotobanner5 = prefs.getString('Fotobanner5')!;
        prefs.setString('fotoktpregister', "")!;
        prefs.setString('fotoregister', "")!;

        // email = prefs.getString('emailregister')!;
        // nohp = prefs.getString('nohpregister')!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                    )),
                // FadeInUp(
                //   duration: Duration(milliseconds: 400),
                //   child: Container(
                //     width: 100,
                //     height: 60,
                //     child: Image.asset("assets/images/logocaleg4.jpg"),
                //   ),
                // ),

                FadeInUp(
                  duration: Duration(milliseconds: 400),
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
              ],
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Center(
              //   child: FadeInUp(
              //     duration: Duration(milliseconds: 800),
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
              //               child: Image.network(
              //                 // widget.question.fileInfo[0].remoteURL,
              //                 Fotobanner1,
              //                 // width: 220,
              //                 // height: 220,
              //                 //
              //                 loadingBuilder: (context, child,
              //                         loadingProgress) =>
              //                     (loadingProgress == null)
              //                         ? child
              //                         : Center(
              //                             child: CircularProgressIndicator(),
              //                           ),
              //                 errorBuilder: (context, error, stackTrace) {
              //                   Future.delayed(
              //                     Duration(milliseconds: 0),
              //                     () {
              //                       if (mounted) {
              //                         setState(() {
              //                           CircularProgressIndicator();
              //                         });
              //                       }
              //                     },
              //                   );
              //                   return SizedBox.shrink();
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
              //                 Fotobanner2,
              //                 // width: 220,
              //                 // height: 220,
              //                 //
              //                 loadingBuilder: (context, child,
              //                         loadingProgress) =>
              //                     (loadingProgress == null)
              //                         ? child
              //                         : Center(
              //                             child: CircularProgressIndicator(),
              //                           ),
              //                 errorBuilder: (context, error, stackTrace) {
              //                   Future.delayed(
              //                     Duration(milliseconds: 0),
              //                     () {
              //                       if (mounted) {
              //                         setState(() {
              //                           CircularProgressIndicator();
              //                         });
              //                       }
              //                     },
              //                   );
              //                   return SizedBox.shrink();
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
              //                 loadingBuilder: (context, child,
              //                         loadingProgress) =>
              //                     (loadingProgress == null)
              //                         ? child
              //                         : Center(
              //                             child: CircularProgressIndicator(),
              //                           ),
              //                 errorBuilder: (context, error, stackTrace) {
              //                   Future.delayed(
              //                     Duration(milliseconds: 0),
              //                     () {
              //                       if (mounted) {
              //                         setState(() {
              //                           CircularProgressIndicator();
              //                         });
              //                       }
              //                     },
              //                   );
              //                   return SizedBox.shrink();
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
              //                 Fotobanner4,
              //                 // width: 220,
              //                 // height: 220,
              //                 //
              //                 loadingBuilder: (context, child,
              //                         loadingProgress) =>
              //                     (loadingProgress == null)
              //                         ? child
              //                         : Center(
              //                             child: CircularProgressIndicator(),
              //                           ),
              //                 errorBuilder: (context, error, stackTrace) {
              //                   Future.delayed(
              //                     Duration(milliseconds: 0),
              //                     () {
              //                       if (mounted) {
              //                         setState(() {
              //                           CircularProgressIndicator();
              //                         });
              //                       }
              //                     },
              //                   );
              //                   return SizedBox.shrink();
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
              //                 loadingBuilder: (context, child,
              //                         loadingProgress) =>
              //                     (loadingProgress == null)
              //                         ? child
              //                         : Center(
              //                             child: CircularProgressIndicator(),
              //                           ),
              //                 errorBuilder: (context, error, stackTrace) {
              //                   Future.delayed(
              //                     Duration(milliseconds: 0),
              //                     () {
              //                       if (mounted) {
              //                         setState(() {
              //                           CircularProgressIndicator();
              //                         });
              //                       }
              //                     },
              //                   );
              //                   return SizedBox.shrink();
              //                 },
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //       onPageChanged: (value) {
              //         print('Page changed: $value');
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


              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Pilih Jenis Dukungan Anda',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: greenPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),

              FadeInUp(
                duration: Duration(milliseconds: 900),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: greenPrimary,
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                // radioButtonItem = 'P';
                                visiblekodereveralpage = true;
                                visiblnohpreveral = false;
                                visiblebuttonkodereveral = true;
                                visiblebutttonnohpreveral = false;
                                _value = 1;

                                isLoading = false;
                                visiblekodereveralpageValid = false;
                                visiblekodereferalpagesalah = false;
                                visiblenohpreferalpagesalah = false;
                                visiblenohpreferalvalid = false;
                              });
                            },
                          ),
                          // const Icon(
                          //   Icons.male,
                          //   color: Colors.blueAccent,
                          // ),
                          const Text(
                            'Admin/Relawan/Saksi ',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: greenPrimary,
                            value: 2,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                // radioButtonItem = 'P';
                                visiblekodereveralpage = false;
                                visiblnohpreveral = true;
                                visiblebuttonkodereveral = false;
                                visiblebutttonnohpreveral = true;

                                isLoading = false;
                                visiblekodereveralpageValid = false;
                                visiblekodereferalpagesalah = false;
                                visiblenohpreferalpagesalah = false;
                                visiblenohpreferalvalid = false;
                                _value = 2;
                              });
                            },
                          ),
                          // const Icon(
                          //   Icons.female,
                          //   color: Colors.pinkAccent,
                          // ),
                          const Text(
                            'Pendukung',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Visibility(
                  visible: visiblnohpreveral,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Text(
                          'No. HP Referal',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1200),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: TextFormField(
                            style: const TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(r'^0+'),
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^1+'), //users can't type 0 at 1st position
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^2+'), //users can't type 0 at 1st position
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^3+'), //users can't type 0 at 1st position
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^4+'), //users can't type 0 at 1st position
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^5+'), //users can't type 0 at 1st position
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^6+'), //users can't type 0 at 1st position
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^7+'), //users can't type 0 at 1st position
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^9+'), //users can't type 0 at 1st position
                              ),
                            ],
                            controller: nohreveralcontrolele,
                            decoration: InputDecoration(
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
                              prefixIcon: Container(
                                margin: const EdgeInsets.only(
                                    top: 11.0, left: 10.0),
                                child: const Text(
                                  '62',
                                  style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 15,
                                      color: greenPrimary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              fillColor: whitePrimary,
                              hintText: "8xxxxx",
                              hintStyle: const TextStyle(color: greyPrimary),
                              filled: true,
                            ),
                            validator: (valueNum) {
                              if (valueNum == null || valueNum.isEmpty) {}
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            // onFieldSubmitted: (val) {
                            //   _saveForm();
                            // },
                            keyboardType: TextInputType.phone,
                            autofocus: false,
                          ),
                        ),
                      ),
                    ],
                  )),

              Visibility(
                visible: visiblekodereveralpage,
                child: FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    alignment: Alignment.center,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          color: greenPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      controller: kodereveralpagecontrolel,
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
                        prefixIcon: Icon(
                          Icons.key_outlined,
                          color: greenPrimary,
                        ),
                        fillColor: whitePrimary,
                        hintText: "Kode Referal",
                        hintStyle: TextStyle(color: greyPrimary),
                        filled: true,
                      ),
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      // validator: (valueMail) {
                      //   // if (valueMail == null || valueMail.isEmpty) {
                      //   //   return 'Email Tidak Boleh Kosong';
                      //   // }
                      //   // if (!RegExp(r'\S+@\S+\.\S+').hasMatch(valueMail)) {
                      //   //   return "Masukkan Email yang Valid";
                      //   // }
                      //   // return null;
                      // },
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visiblekodereveralpageValid,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                  child: Text(
                    'Masukkan Kode Referal !',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),

              Visibility(
                visible: visiblekodereferalpagesalah,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                  child: Text(
                    'Kode Referal Salah !',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),
              Visibility(
                visible: visiblenohpreferalpagesalah,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                  child: Text(
                    'No. HP Referal Salah !',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),
              Visibility(
                visible: visiblenohpreferalvalid,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                  child: Text(
                    'Masukkan No. HP Referal !',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),

              Row(
                children: [
                  Checkbox(
                      activeColor: greenPrimary,
                      value: check,
                      onChanged: (value) {
                        setState(() {
                          check = value!;
                        });
                      }),
                  Visibility(
                    visible: visiblesetujuprivacycek,
                    child:
                  Text(
                    "Menyetujui Semua Kebijakan Privasi Aplikasi Ayocaleg",
                    style: TextStyle(fontFamily: 'poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: textPrimary),
                  )
                  ),
                  Visibility(
                      visible: visiblesetujuprivacynotcek,
                      child:
                      Text(
                        "Menyetujui Semua Kebijakan Privasi Aplikasi Ayocaleg",
                        style: TextStyle(fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.red),
                      )
                  ),
                ],
              ),


              Visibility(
                visible: visiblebutttonnohpreveral,
                child: FadeInUp(
                  duration: Duration(milliseconds: 1300),
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
                            // isLoading = true;
                            visiblekodereveralpageValid = false;
                            visiblekodereferalpagesalah = false;
                            visiblenohpreferalpagesalah = false;
                            visiblenohpreferalvalid = false;

                             visiblesetujuprivacycek = true;
                             visiblesetujuprivacynotcek = false;

                            checkEmptypendukung();
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
                                  'Lanjut',
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
              ),

              Visibility(
                visible: visiblebuttonkodereveral,
                child: FadeInUp(
                  duration: Duration(milliseconds: 1300),
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

                            visiblekodereveralpageValid = false;
                            visiblekodereferalpagesalah = false;
                            visiblenohpreferalpagesalah = false;

                            visiblesetujuprivacycek = true;
                            visiblesetujuprivacynotcek = false;

                            checkEmptyperelawan();
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
                                  'Lanjut',
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
              ),
            ],
          ))),
    );
  }

  checkEmptypendukung() {
    if (nohreveralcontrolele.text.isEmpty) {
      setState(() {
        visiblekodereveralpageValid = false;
        visiblekodereferalpagesalah = false;
        visiblenohpreferalpagesalah = false;
        visiblenohpreferalvalid = true;

        isLoading = false;
      });
    } else {
      if (check == true) {
        setState(() {
          visiblekodereveralpageValid = false;
          visiblekodereferalpagesalah = false;
          visiblenohpreferalpagesalah = false;
          visiblenohpreferalvalid = false;
          isLoading = true;
          cekkodereveral();
        });
      }else{
        visiblekodereveralpageValid = false;
        visiblekodereferalpagesalah = false;
        visiblenohpreferalpagesalah = false;
        visiblenohpreferalvalid = false;

        visiblesetujuprivacycek = false;
        visiblesetujuprivacynotcek = true;
      }

    }
  }

  checkEmptyperelawan() {
    if (kodereveralpagecontrolel.text.isEmpty) {
      setState(() {
        visiblekodereveralpageValid = true;
        visiblekodereferalpagesalah = false;
        visiblenohpreferalpagesalah = false;
        visiblenohpreferalvalid = false;

        isLoading = false;
      });
    } else if (kodereveralpagecontrolel.text.length < 5) {
      setState(() {
        visiblekodereveralpageValid = false;
        visiblekodereferalpagesalah = true;
        visiblenohpreferalpagesalah = false;
        visiblenohpreferalvalid = false;

        isLoading = false;
      });
    } else {
      if (check == true) {
        setState(() {
          visiblekodereveralpageValid = false;
          visiblekodereferalpagesalah = false;
          visiblenohpreferalpagesalah = false;
          visiblenohpreferalvalid = false;
          isLoading = true;

          int startIndex = 0;
          int endIndex = 4;
          String resultkdcaleg =
          kodereveralpagecontrolel.text.substring(startIndex, endIndex);
          cekkodecaleg(resultkdcaleg);
        });
      }else{
        visiblekodereveralpageValid = false;
        visiblekodereferalpagesalah = false;
        visiblenohpreferalpagesalah = false;
        visiblenohpreferalvalid = false;

        visiblesetujuprivacycek = false;
        visiblesetujuprivacynotcek = true;
      }

    }
  }

  cekkodereveral() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {'usrhp': "62" + nohreveralcontrolele.text};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/ceknohp.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        if (jsonResponse['data'] != null) {
          prefs.setString("fotoktpkosong",
              "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dhB/6G//ALJQB7r4wn/4mVZVWNYn+3alc1XoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOe+JGh/wBveG/+nq0/f/8AxdeX/N7V7jXj/jDQ/wCwfElzbf8Afj/rlQB3/wADfEdt/Zv9m/8AL1aTf9/d9eS/Fr9ibUv+Ekubnwrdaf8AZbubz/sNx+6ki/3P9irum6Vc3/8Ax72txd16J4V8La5Yf8fGqXFp/wBMLefzaAPl3Xv2c/G2g/8AHx4X1D/t3/e/+gVxupWNzoP/AB8Wtxaf9fEHlV+h2meI7mwqzdeIbXXB9l1DS7e6A7T/AL3/ANDoA/OT7TR9pr7u174EfDfxb/x8eF9PtP8Ar3/0X/0CuJ179gPwTrv/ACDte1jSf+28V1H/AOP0AfI/2moa+iPEn/BOfW7D/kC69o93/wBfEEsUn/tSuB8Sfsd/EjQP+YDcXf8A14TxS/8A2ygDzv7TX2n+w1ov9g/s4/2l/wBBa8uLj/vj5E/9Ar5Q0H4H+Lde8Sf2bb+F9Y+1f9PEEsUcX++7191eFfB3/Cs/hLpuif8APpZxwf8AXWX+OgCnRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFVdT0Sz1v/AI/LaG4+q1aooAjttOtdO/49bdbf/dNSUUUAFFFFABRRRQA+1upbX7r/AKVbTxJeJ/y2aqNFAG0nje6T0/OqGoazNf8A3m21UooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA/9k=");
          prefs.setString("fotouserkosong",
              "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");

          if (jsonResponse['data']['usrsts'] == "A") {
            setState(() {
              isLoading = false;
              visiblenohpreferalpagesalah = false;
              visiblekodereveralpageValid = false;
              visiblekodereferalpagesalah = false;
              visiblenohpreferalvalid = false;
            });
          } else if (jsonResponse['data']['usrsts'] == "R") {
            setState(() {
              prefs.setString("kodereferal", jsonResponse['data']['usrhp']);
              prefs.setString("kodecaleg", jsonResponse['data']['usrkc']);
              prefs.setString(
                  "nohprelawanregister", jsonResponse['data']['usrhp']);
              prefs.setString("statusreferal", "P");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPendukungPage(),
                ),
              );
            });
          } else if (jsonResponse['data']['usrsts'] == "P") {
            setState(() {
              prefs.setString("kodereferal", jsonResponse['data']['usrhp']);
              prefs.setString("kodecaleg", jsonResponse['data']['usrkc']);
              prefs.setString(
                  "nohprelawanregister", jsonResponse['data']['usrhpr']);
              prefs.setString("statusreferal", "P");
              isLoading = false;
              visiblenohpreferalpagesalah = false;
              visiblekodereveralpageValid = false;
              visiblekodereferalpagesalah = false;
              visiblenohpreferalvalid = false;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPendukungPage(),
                ),
              );
            });
          } else {
            setState(() {
              isLoading = false;
              visiblenohpreferalpagesalah = true;
              visiblekodereveralpageValid = false;
              visiblekodereferalpagesalah = false;
              visiblenohpreferalvalid = false;
            });
          }
        } else {
          setState(() {
            isLoading = false;
            visiblenohpreferalpagesalah = true;
            visiblekodereveralpageValid = false;
            visiblekodereferalpagesalah = false;
            visiblenohpreferalvalid = false;
          });
        }
      }
      //  prefs.setString("token", jsonResponse['data']['nohp']);
    }
  }

  cekkodecaleg(String kdkc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {'kdkc': kdkc + "0"};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekkd.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        if (jsonResponse['kodecaleg'] != null) {
          prefs.setString("kodereferal", kodereveralpagecontrolel.text);
          prefs.setString("kodecaleg", jsonResponse['kodecaleg']['kdkc']);
          prefs.setString("nohprelawanregister", "-");
          prefs.setString("fotoktpkosong",
              "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dhB/6G//ALJQB7r4wn/4mVZVWNYn+3alc1XoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOe+JGh/wBveG/+nq0/f/8AxdeX/N7V7jXj/jDQ/wCwfElzbf8Afj/rlQB3/wADfEdt/Zv9m/8AL1aTf9/d9eS/Fr9ibUv+Ekubnwrdaf8AZbubz/sNx+6ki/3P9irum6Vc3/8Ax72txd16J4V8La5Yf8fGqXFp/wBMLefzaAPl3Xv2c/G2g/8AHx4X1D/t3/e/+gVxupWNzoP/AB8Wtxaf9fEHlV+h2meI7mwqzdeIbXXB9l1DS7e6A7T/AL3/ANDoA/OT7TR9pr7u174EfDfxb/x8eF9PtP8Ar3/0X/0CuJ179gPwTrv/ACDte1jSf+28V1H/AOP0AfI/2moa+iPEn/BOfW7D/kC69o93/wBfEEsUn/tSuB8Sfsd/EjQP+YDcXf8A14TxS/8A2ygDzv7TX2n+w1ov9g/s4/2l/wBBa8uLj/vj5E/9Ar5Q0H4H+Lde8Sf2bb+F9Y+1f9PEEsUcX++7191eFfB3/Cs/hLpuif8APpZxwf8AXWX+OgCnRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFVdT0Sz1v/AI/LaG4+q1aooAjttOtdO/49bdbf/dNSUUUAFFFFABRRRQA+1upbX7r/AKVbTxJeJ/y2aqNFAG0nje6T0/OqGoazNf8A3m21UooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA/9k=");
          prefs.setString("fotouserkosong",
              "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");

          if (jsonResponse['kodecaleg']['kdad'] ==
              kodereveralpagecontrolel.text) {
            setState(() {
              Statusreferal = "A";
              visiblenohpreferalpagesalah = false;
              visiblekodereveralpageValid = false;
              visiblekodereferalpagesalah = false;
              visiblenohpreferalvalid = false;
              isLoading = false;
              prefs.setString("statusreferal", Statusreferal);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            });
          } else if (jsonResponse['kodecaleg']['kdrlw'] ==
              kodereveralpagecontrolel.text) {
            setState(() {
              isLoading = false;
              visiblenohpreferalpagesalah = false;
              visiblekodereveralpageValid = false;
              visiblekodereferalpagesalah = false;
              visiblenohpreferalvalid = false;

              Statusreferal = "R";
              prefs.setString("statusreferal", Statusreferal);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            });
          } else if (jsonResponse['kodecaleg']['kdsks'] ==
              kodereveralpagecontrolel.text) {
            setState(() {
              isLoading = false;
              visiblenohpreferalpagesalah = false;
              visiblekodereveralpageValid = false;
              visiblekodereferalpagesalah = false;
              visiblenohpreferalvalid = false;

              Statusreferal = "S";
              prefs.setString("statusreferal", Statusreferal);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            });
          } else {
            setState(() {
              visiblenohpreferalpagesalah = false;
              visiblekodereveralpageValid = false;
              visiblekodereferalpagesalah = true;
              visiblenohpreferalvalid = false;
              isLoading = false;
            });
          }
        } else {
          setState(() {
            visiblenohpreferalpagesalah = false;
            visiblekodereveralpageValid = false;
            visiblekodereferalpagesalah = true;
            visiblenohpreferalvalid = false;
            isLoading = false;
          });
        }
        //  prefs.setString("token", jsonResponse['data']['nohp']);
      }
    }
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
}
