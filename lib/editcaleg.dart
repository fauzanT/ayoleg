import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/account.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCalegpage extends StatefulWidget {
  const EditCalegpage({Key? key}) : super(key: key);

  @override
  State<EditCalegpage> createState() => _EditCalegpageState();
}

class _EditCalegpageState extends State<EditCalegpage> {
  late SharedPreferences sharedPrefs;

  bool isLoading = false;

  var visicontrolel = TextEditingController();
  var misicontrolel = TextEditingController();
  var programdanpengalamancontrolel = TextEditingController();
  var targetrelawancontrolel = TextEditingController();
  var TargetPendukungcontrolel = TextEditingController();
  var Targetsuaracontrolel = TextEditingController();
  var tugasadmincontrolel = TextEditingController();
  var tugasrelawancontrolel = TextEditingController();
  var tugaspendukungcontrolel = TextEditingController();
  var tugassaksicontrolel = TextEditingController();

  var Anggarancontrolel = TextEditingController();
  var janjicontrolel = TextEditingController();
  var websitecontrolel = TextEditingController();



  String passwordregister = "";
  String visicaleg = "";
  String misicaleg = "";
  String programcaleg = "";
  String jobadmin = "";
  String jobsaksi = "";
  String jobrelawan = "";
  String jobpendukung = "";
  String targetsuara ="";
  String targetrelawan = "";
  String targetpendukung = "";

  String anggaran = "0";
  String janjipolitik = "";
  String kdweb = "";


  bool visiblevisi = false;
  bool visiblemisi = false;
  bool visibleprogramdanpengalaman = false;
  bool visibletargetrelawan = false;
  bool visibletargetpendukung = false;
  bool visibletargetsuara = false;
  bool visibletugasadmin = false;
  bool visibletugasrelawan = false;
  bool visibletugaspendukung = false;
  bool visibletugassaksi = false;

  bool visibleanggaran = false;
  bool visiblejanji = false;





  @override
  void initState() {
    setState(() {
      // cekkodecaleg();
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        visicaleg = prefs.getString('visicaleg')!;
        misicaleg = prefs.getString('misicaleg')!;
        programcaleg = prefs.getString('programcaleg')!;
        jobadmin = prefs.getString('jobadmin')!;
        jobsaksi = prefs.getString('jobsaksi')!;
        jobrelawan = prefs.getString('jobrelawan')!;
        jobpendukung = prefs.getString('jobpendukung')!;
        targetsuara = prefs.getString('targetsuara')!;
        targetrelawan = prefs.getString('targetrelawan')!;
        targetpendukung = prefs.getString('targetpendukung')!;
        anggaran = prefs.getString('anggaran')!;
        janjipolitik = prefs.getString('janjipolitik')!;
        kdweb = prefs.getString('kdweb')!;

        visicontrolel.text = visicaleg;
         misicontrolel.text = misicaleg;
         programdanpengalamancontrolel.text = programcaleg;
         targetrelawancontrolel.text = targetrelawan;
         TargetPendukungcontrolel.text = targetpendukung;
         Targetsuaracontrolel.text = targetsuara;
         tugasadmincontrolel.text = jobadmin;
         tugasrelawancontrolel.text = jobrelawan;
         tugaspendukungcontrolel.text = jobpendukung;
         tugassaksicontrolel.text = jobsaksi;

         Anggarancontrolel.text = anggaran;
         janjicontrolel.text = janjipolitik;
        websitecontrolel.text = kdweb;

      });
    });

    super.initState();
  }
  Future<void> onBackPressed() async {
    setState(() {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return const AccountPage();
          }));
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
                    "Ubah Data Caleg",
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
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child:Text(
                        'VISI Caleg',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          controller: visicontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "VISI Caleg",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),

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
                      ),
                    ),
                    Visibility(
                      visible: visiblevisi,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan VISI Caleg !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'MISI Caleg',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          controller: misicontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "MISI Caleg",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),
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
                      ),
                    ),
                    Visibility(
                      visible: visiblemisi,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan MISI Caleg !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Program Dan Pengalaman',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          controller: programdanpengalamancontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Program Dan Pengalaman",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),
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
                      ),
                    ),
                    Visibility(
                      visible: visibleprogramdanpengalaman,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Program Dan Pengalaman !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Target Relawan',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1100),
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

                          ],
                          controller: targetrelawancontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Target Relawan",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),

                            filled: true,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                        ),
                      ),
                    ),


                    Visibility(
                      visible: visibletargetrelawan,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Target Relawan !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Target Pendukung',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1100),
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

                          ],
                          controller: TargetPendukungcontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Target Pedukung",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),

                            filled: true,
                          ),

                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                        ),
                      ),
                    ),


                    Visibility(
                      visible: visibletargetpendukung,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Target Pendukung !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Target Suara',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1100),
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

                          ],
                          controller: Targetsuaracontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Target Suara",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),

                            filled: true,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visibletargetsuara,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Target Suara !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Anggaran',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1100),
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
                            // FilteringTextInputFormatter.deny(
                            //   RegExp(r'^0+'),
                            // ),

                          ],
                          controller: Anggarancontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Anggaran",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),

                            filled: true,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visibleanggaran,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Anggaran !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Janji/Kontrak Politik',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          controller: janjicontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Janji/kontrak Politik",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),
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
                      ),
                    ),
                    Visibility(
                      visible: visiblejanji,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Janji/Kontrak Politik !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),


                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Tugas Admin',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          controller: tugasadmincontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Tugas Admin",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),
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
                      ),
                    ),
                    Visibility(
                      visible: visibletugasadmin,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Tugas Admin !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),


                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Tugas Relawan',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          controller: tugasrelawancontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Tugas Relawan",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),
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
                      ),
                    ),

                    Visibility(
                      visible: visibletugasrelawan,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Tugas Relawan !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Tugas Pendukung',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          controller: tugaspendukungcontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Tugas Pendukung",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),
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
                      ),
                    ),

                    Visibility(
                      visible: visibletugaspendukung,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Tugas Pendukung !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child:Text(
                        'Tugas Saksi',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          controller: tugassaksicontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Tugas Saksi",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),
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
                      ),
                    ),

                    Visibility(
                      visible: visibletugassaksi,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Masukkan Tugas Saksi !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child:Text(
                        'Alamat Website Caleg',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          controller: websitecontrolel,
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

                            fillColor: whitePrimary,
                            labelText: "Website",
                            labelStyle: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.grey,
                                fontSize: 11),

                          ),

                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          //Normal textInputField will be displayed
                          maxLines: 1000000,
                          //
                          // keyboardType: TextInputType.phone,
                          autofocus: false,
                          textCapitalization: TextCapitalization.sentences,
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
                  ],
                )
              ],
            ),
          )),
    );
  }

  checkEmpty() {


    if (visicontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
         visiblevisi = true;
         visiblemisi = false;
         visibleprogramdanpengalaman = false;
         visibletargetrelawan = false;
         visibletargetpendukung = false;
         visibletargetsuara = false;
         visibletugasadmin = false;
         visibletugasrelawan = false;
         visibletugaspendukung = false;
         visibletugassaksi = false;
        isLoading = false;

      });
    }else if (misicontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = true;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = false;
        visibletargetpendukung = false;
        visibletargetsuara = false;
        visibletugasadmin = false;
        visibletugasrelawan = false;
        visibletugaspendukung = false;
        visibletugassaksi = false;
        isLoading = false;

      });
    }else if (programdanpengalamancontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = true;
        visibletargetrelawan = false;
        visibletargetpendukung = false;
        visibletargetsuara = false;
        visibletugasadmin = false;
        visibletugasrelawan = false;
        visibletugaspendukung = false;
        visibletugassaksi = false;
        isLoading = false;

      });
    }else if (targetrelawancontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = true;
        visibletargetpendukung = false;
        visibletargetsuara = false;
        visibletugasadmin = false;
        visibletugasrelawan = false;
        visibletugaspendukung = false;
        visibletugassaksi = false;
        isLoading = false;

      });
    }else if (TargetPendukungcontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = false;
        visibletargetpendukung = true;
        visibletargetsuara = false;
        visibletugasadmin = false;
        visibletugasrelawan = false;
        visibletugaspendukung = false;
        visibletugassaksi = false;
        isLoading = false;

      });
    }else if (Targetsuaracontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = false;
        visibletargetpendukung = false;
        visibletargetsuara = true;
        visibletugasadmin = false;
        visibletugasrelawan = false;
        visibletugaspendukung = false;
        visibletugassaksi = false;
        isLoading = false;

      });
    }else if (Anggarancontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= true;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = false;
        visibletargetpendukung = false;
        visibletargetsuara = false;
        visibletugasadmin = false;
        visibletugasrelawan = false;
        visibletugaspendukung = false;
        visibletugassaksi = false;
        isLoading = false;

      });
    }else if (janjicontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =true;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = false;
        visibletargetpendukung = false;
        visibletargetsuara = false;
        visibletugasadmin = false;
        visibletugasrelawan = false;
        visibletugaspendukung = false;
        visibletugassaksi = false;
        isLoading = false;
      });
    }else if (tugasadmincontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = false;
        visibletargetpendukung = false;
        visibletargetsuara = false;
        visibletugasadmin = true;
        visibletugasrelawan = false;
        visibletugaspendukung = false;
        visibletugassaksi = false;
        isLoading = false;

      });
    }else if (tugasrelawancontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = false;
        visibletargetpendukung = false;
        visibletargetsuara = false;
        visibletugasadmin = false;
        visibletugasrelawan = true;
        visibletugaspendukung = false;
        visibletugassaksi = false;
        isLoading = false;

      });
    }else if (tugaspendukungcontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = false;
        visibletargetpendukung = false;
        visibletargetsuara = false;
        visibletugasadmin = false;
        visibletugasrelawan = false;
        visibletugaspendukung = true;
        visibletugassaksi = false;
        isLoading = false;

      });
    }else if (tugassaksicontrolel.text.isEmpty) {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
        visiblevisi = false;
        visiblemisi = false;
        visibleprogramdanpengalaman = false;
        visibletargetrelawan = false;
        visibletargetpendukung = false;
        visibletargetsuara = false;
        visibletugasadmin = false;
        visibletugasrelawan = false;
        visibletugaspendukung = false;
        visibletugassaksi = true;
        isLoading = false;

      });
    } else {
      setState(() {
        visibleanggaran= false;
        visiblejanji =false;
    visiblevisi = false;
    visiblemisi = false;
    visibleprogramdanpengalaman = false;
    visibletargetrelawan = false;
    visibletargetpendukung = false;
    visibletargetsuara = false;
    visibletugasadmin = false;
    visibletugasrelawan = false;
    visibletugaspendukung = false;
    visibletugassaksi = false;
    isLoading = true;
    ubahdatacaleg();

      });
    }
  }
  ubahdatacaleg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;

    if (websitecontrolel.text.isEmpty) {
      websitecontrolel.text = '-';
    }

    Map data = {

      'kdweb': websitecontrolel.text,
      'kdbgt': Anggarancontrolel.text,
      'kdjkp': janjicontrolel.text,
      'kdkc': kodecaleg,
      'kdvs': visicontrolel.text,
      'kdms': misicontrolel.text,
      'kdts': Targetsuaracontrolel.text,
      'kdtr': targetrelawancontrolel.text,
      'kdpd': TargetPendukungcontrolel.text ,
      'kdpp': programdanpengalamancontrolel.text,
      'kdjdad': tugasadmincontrolel.text ,
      'kdjdsk': tugassaksicontrolel.text,
      'kdjdrl': tugasrelawancontrolel.text,
      'kdjdpd':  tugaspendukungcontrolel.text ,
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/updatecaleg.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {

        cekkodecaleg();
        if(jsonResponse["response"]["status"]=="1") {
          setState(() {

          });

        }else{
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Ubah Data Gagal, periksa Data Kembali !")));
          });

        }



      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Ubah Data Gagal !")));
      }
    } else {}
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

        setState(() async {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Ubah Data Berhasil !")));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const AccountPage();
              }));
          prefs.setString('fotocaleg', jsonResponse['kodecaleg']['kdft']);
          prefs.setString("kodeadmin", jsonResponse['kodecaleg']['kdad']);
          prefs.setString("koderelawan", jsonResponse['kodecaleg']['kdrlw']);
          prefs.setString("kodesaksi", jsonResponse['kodecaleg']['kdsks']);
          prefs.setString("visicaleg", jsonResponse['kodecaleg']['kdvs']);
          prefs.setString("misicaleg", jsonResponse['kodecaleg']['kdms']);
          prefs.setString("programcaleg", jsonResponse['kodecaleg']['kdpp']);
          prefs.setString("yotubecaleg", jsonResponse['kodecaleg']['kdcu']);
          prefs.setString('kdweb', jsonResponse['kodecaleg']['kdweb']);

          prefs.setString('jobadmin', jsonResponse['kodecaleg']['kdjdad']);
          prefs.setString('jobsaksi', jsonResponse['kodecaleg']['kdjdsk']);
          prefs.setString('jobrelawan', jsonResponse['kodecaleg']['kdjdrl']);
          prefs.setString('jobpendukung', jsonResponse['kodecaleg']['kdjdpd']);

          prefs.setString('targetsuara', jsonResponse['kodecaleg']['kdts']);
          prefs.setString('targetrelawan', jsonResponse['kodecaleg']['kdtr']);
          prefs.setString('targetpendukung', jsonResponse['kodecaleg']['kdpd']);

          prefs.setString('anggaran', jsonResponse['kodecaleg']['kdbgt']);
          prefs.setString('janjipolitik', jsonResponse['kodecaleg']['kdjkp']);



        });
      } else {}
    }
  }
}
