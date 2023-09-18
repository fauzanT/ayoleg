import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/account.dart';

import 'package:ayoleg/component/colors/colors.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';


class SettingAkunpage extends StatefulWidget {
  const SettingAkunpage({Key? key}) : super(key: key);

  @override
  State<SettingAkunpage> createState() => _SettingAkunpageState();
}

class _SettingAkunpageState extends State<SettingAkunpage> {

  var passwordbarucontrolel = TextEditingController();
  var passwordlamacontrolel = TextEditingController();
  late SharedPreferences sharedPrefs;
  bool visiblepasswordlamaValid = false;
  bool visiblepaswordbaruValid = false;
  bool visiblepaswodtidaksamaValid = false;
  bool visibleubahpasswordValid = false;
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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    return DefaultTabController(
      length: 3,
      child:
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
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Setting",
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


                FadeInUp(
                  duration: Duration(milliseconds: 1400),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'Ubah Password -> ',
                      //   style: TextStyle(
                      //     fontFamily: 'poppins',
                      //     color: textPrimary,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            visibleubahpasswordValid = true;
                          });

                        },
                        child: const Text(
                          ' Ubah Password -> UBAH',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: visibleubahpasswordValid,
                    child:
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
                                hintText: "Password Lama",
                                hintStyle: TextStyle(
                                    fontFamily: 'poppins', color: greyPrimary),
                                filled: true,
                              ),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
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
                              'Masukkan password lama !',
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
                                  fontSize: 14,
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
                                hintText: "Password Baru",
                                hintStyle: TextStyle(color: greyPrimary),
                                filled: true,
                              ),
                              keyboardType: TextInputType.number,
                              autofocus: false,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: visiblepaswordbaruValid,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                            child: Text(
                              'Masukkan Pasword Baru!',
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
                              'PAssword Lama Tidak Sama!',
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
                                    'Ubah',
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
              ],))


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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return const AccountPage();
            }));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Berhasil Di Rubah")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Gagal Di Rubah!!")));
      }
    } else {}
  }


}
