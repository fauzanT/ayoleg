import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/account.dart';
import 'package:ayoleg/component/colors/colors.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';


class UbahPaswordpage extends StatefulWidget {
  const UbahPaswordpage({Key? key}) : super(key: key);

  @override
  State<UbahPaswordpage> createState() => _UbahPaswordpageState();
}

class _UbahPaswordpageState extends State<UbahPaswordpage> {

  var passwordbarucontrolel = TextEditingController();
  var passwordlamacontrolel = TextEditingController();
  late SharedPreferences sharedPrefs;
  bool visiblepasswordlamaValid = false;
  bool visiblepaswordbaruValid = false;
  bool visiblepaswodtidaksamaValid = false;
  bool isLoading = false;
  String passwordregister = "";
  @override
  void initState() {
    setState(() {

      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        passwordregister = prefs.getString('passwordregister')!;

      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                            return AccountPage();
                          }));
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Ubah Kata Sandi",
                    style:
                    TextStyle(fontFamily: 'poppins', color: whitePrimary),
                  ),
                  Container(
                    width: 17,
                  )
                ],
              )),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child:

            ////untuk android
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          controller: passwordlamacontrolel,
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
                            //   Icons.newspaper,
                            //   color: greenPrimary,
                            // ),
                            fillColor: whitePrimary,
                            labelText: "Kata Sandi Saat Ini",
                            labelStyle: TextStyle(color: greyPrimary,fontSize: 12),

                            filled: true,
                              counterText: "",
                              counterStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.red,
                                  fontSize: 8)
                          ),
                          maxLength: 20,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visiblepasswordlamaValid,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Kata Sandi Saat Ini !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          controller: passwordbarucontrolel,
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
                            //   Icons.newspaper_outlined,
                            //   color: greenPrimary,
                            // ),
                            fillColor: whitePrimary,
                            labelText: "Kata Sandi Baru",
                            labelStyle: TextStyle(color: greyPrimary,fontSize: 12),
                            filled: true,
                              counterText: "",
                              counterStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.red,
                                  fontSize: 8)
                          ),
                          maxLength: 20,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visiblepaswordbaruValid,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Kata Sandi Baru Minimal 6 Karakter !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: visiblepaswodtidaksamaValid,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Kata Sandi Saat Ini Salah !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),


                    FadeInUp(
                      duration: Duration(milliseconds: 1400),
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
                              checkEmpty();

                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Simpan',
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

                    SizedBox(
                      height: 10,
                    ),
                  ],)

              ],
            ),

          )),
    );
  }

  checkEmpty() {
    if (passwordlamacontrolel.text.isEmpty) {
      setState(() {
        visiblepasswordlamaValid = true;
        visiblepaswordbaruValid = false;
        visiblepaswodtidaksamaValid = false;
        isLoading = false;

      });

    } else if (passwordbarucontrolel.text.isEmpty) {
      setState(() {
        visiblepasswordlamaValid = false;
        visiblepaswordbaruValid = true;
        visiblepaswodtidaksamaValid = false;
        isLoading = false;

      });
    } else if (passwordbarucontrolel.text.length <6) {
      setState(() {
        visiblepasswordlamaValid = false;
        visiblepaswordbaruValid = true;
        visiblepaswodtidaksamaValid = false;
        isLoading = false;

      });
    } else if (passwordlamacontrolel.text != passwordregister) {
      setState(() {
        visiblepasswordlamaValid = false;
        visiblepaswordbaruValid = false;
        visiblepaswodtidaksamaValid = true;
        isLoading = false;

      });
    }
    else {
      setState(() {
        visiblepasswordlamaValid = false;
        visiblepaswordbaruValid = false;
        visiblepaswodtidaksamaValid = false;
        isLoading = true;

        ubahpasword();
      });

    }
  }

  ubahpasword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String nohpAkun = prefs.getString('nohpregister')!;

    Map data = {
      'usrhp': nohpAkun,
      'usrpas': passwordbarucontrolel.text,

    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/updatepass.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          prefs.setString("passwordregister", passwordbarucontrolel.text);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const AccountPage();
              }));
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Ubah Data Berhasil !")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Ubah Data Gagal !")));
      }
    } else {}
  }

  Future sendEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String emailregister = prefs.getString('emailregister')!;
    String namaregister = prefs.getString("namaregister")!;


    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_ae3hebe';
    const templateId = 'template_yn06mpd';
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
            'to_email': "g7.teknologi@gmail.com",
            'message': "Hi... Admin Ayocaleg, saya butuh bantuan " + namaregister
          }
        }));

    if (response.statusCode == 200) {
      // setState(() {
      //   visibleBtnResend = false;
      //     prefs.setString('otpregis', otpacak);
      // });
    }
    // return response.statusCode;
  }
}
