import 'dart:convert';
import 'dart:io';

// import 'package:image_picker_web/image_picker_web.dart';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/berita/pesan.dart';
import 'package:ayoleg/cameraktp/viewimage.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:ayoleg/suara/suara.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
// import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class SuaraDetailpage extends StatefulWidget {
  const SuaraDetailpage({Key? key}) : super(key: key);

  @override
  State<SuaraDetailpage> createState() => _SuaraDetailpageState();
}

class _SuaraDetailpageState extends State<SuaraDetailpage> {

  String ftc1 = "";
  String sratps = "";
  String sradpl = "";
  String srapr = "";
  String srakt = "";
  String srakct = "";
  String srakl = "";
  String sradpt = "";
  String srasah = "";
  String srasrc = "";
  String sravlnm = "";
  String namasaksi = "";
  bool visibleadmin = false;
  bool visiblebtnadmin = false;
  bool visibletotaldpt = false;
  bool visibletotalsuarasah = false;
  bool visibletotalsuaracaleg = false;
  bool visibletotdptvalid = false;
  bool visibletotdptnontvalid = false;
  bool visibletotsssnotvalid =false;
  bool visibletotsssvalid = false;
  bool visibletotcalegnotvalid = false;
  bool visibletotcalegvalid = false;


  var totaldptcontrolel = TextEditingController();
  var totalsahtcontrolel = TextEditingController();
  var totalsuaracalegcontrolel = TextEditingController();

  late SharedPreferences sharedPrefs;
  String usrsts ="";

  @override
  void initState() {
    cekdatasaksi();

    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        usrsts = prefs.getString('usrsts')!;

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
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             SuaraPage()));
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Perhitungan Suara',
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
              child:Column(children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(top:20),

                          child:     ftc1.isEmpty
                              ? Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator())
                              : Container(
                            alignment: Alignment.center,
                            child: Image.network(
                              ftc1,
                              // width: 100,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),),
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("fotoview",ftc1);
                          prefs.setString("navfoto", "suara");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ZoomableImage(),
                            ),
                          );
                        },
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Saksi',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),

                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: greenPrimary)),
                        child:Text(
                          "  "+namasaksi,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'No. TPS',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),

                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: greenPrimary)),
                        child:Text(
                          "  "+sratps,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Daerah Pemilihan',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),


                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: greenPrimary)),
                        child:Text(
                          "  "+sradpl,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Provinsi',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),


                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: greenPrimary)),
                        child:Text(
                          "  "+srapr,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Kota',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),

                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: greenPrimary)),
                        child:Text(
                          "  "+srakt,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Kecamatan',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),

                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: greenPrimary)),
                        child:Text(
                          "  "+srakct,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Kelurahan',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),

                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: greenPrimary)),
                        child:Text(
                          "  "+srakl,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Total DPT',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Visibility(
                        visible: visibletotdptvalid,
                        child:
                        Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: greenPrimary)),
                          child:Text(
                            "  "+sradpt,
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: visibletotdptnontvalid,
                        child:
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
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            inputFormatters: <TextInputFormatter>[

                              FilteringTextInputFormatter.deny(
                                RegExp(r'^0+'),
                              ),

                            ],
                            controller: totaldptcontrolel,
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
                              labelText: "Total DPT",
                              labelStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.grey,
                                  fontSize: 12),

                              filled: true,
                            ),

                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                          ),
                        ),
                      ),
                      ),

                      Visibility(
                        visible: visibletotaldpt,
                        child: const Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                          child: Text(
                            'Masukkan Total DPT !',
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
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Total Semua Suara Sah',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Visibility(
                        visible: visibletotsssnotvalid,
                        child:
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
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            inputFormatters: <TextInputFormatter>[

                              FilteringTextInputFormatter.deny(
                                RegExp(r'^0+'),
                              ),

                            ],
                            controller: totalsahtcontrolel,
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
                              labelText: "Total Semua Suara Sah",
                              labelStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.grey,
                                  fontSize: 12),

                              filled: true,
                            ),

                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                          ),
                        ),
                      ),
                      ),
                      Visibility(
                        visible: visibletotsssvalid,
                        child:
                        Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: greenPrimary)),
                          child:Text(
                            "  "+srasah,
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: visibletotalsuarasah,
                        child: const Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                          child: Text(
                            'Masukkan Total Semua Suara Sah !',
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
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Total Suara Caleg',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Visibility(
                        visible: visibletotcalegnotvalid,
                        child:
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
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            inputFormatters: <TextInputFormatter>[

                              FilteringTextInputFormatter.deny(
                                RegExp(r'^0+'),
                              ),

                            ],
                            controller: totalsuaracalegcontrolel,
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
                              labelText: "Total Suara Caleg",
                              labelStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.grey,
                                  fontSize: 12),

                              filled: true,
                            ),

                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                          ),
                        ),
                      ),
                      ),
                      Visibility(
                        visible: visibletotcalegvalid,
                        child:
                        Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: greenPrimary)),
                          child:Text(
                            "  "+srasrc,
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: visibletotalsuaracaleg,
                        child: const Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                          child: Text(
                            'Masukkan Total Suara Caleg !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ),


                      Visibility(
                        visible: visibleadmin,
                        child:Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin:
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            child: Text(
                              'Validasi Admin',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            height: 50,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: greenPrimary)),
                            child:Text(
                              "  "+sravlnm,
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),

                        ],)

                      ),

                      Visibility(
                        visible: visiblebtnadmin,
                        child:
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 20),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: greenPrimary,
                              onPrimary: whitePrimary,
                              shadowColor: shadowColor,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: const Size(250, 40), //////// HERE
                            ),
                            onPressed: () {


                              checkEmpty();
                            },
                            child: Text(
                              "Validasi Dan Simpan",
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),

              ],)



          )),
    );
  }

  checkEmpty() {
    if (totaldptcontrolel.text.isEmpty) {
      setState(() {
         visibletotaldpt = true;
         visibletotalsuarasah = false;
         visibletotalsuaracaleg = false;
      });
    } else if (totalsahtcontrolel.text.isEmpty) {
      setState(() {
         visibletotaldpt = false;
         visibletotalsuarasah = true;
         visibletotalsuaracaleg = false;
      });
    } else if (totalsuaracalegcontrolel.text.isEmpty) {
      setState(() {
        visibletotaldpt = false;
        visibletotalsuarasah = false;
        visibletotalsuaracaleg = true;
      });
    } else {
      setState(() {
        visibletotaldpt = false;
        visibletotalsuarasah = false;
        visibletotalsuaracaleg = false;

        updatesuara();
      });
    }
  }


    updatesuara() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String srahp = prefs.getString('srahp')!;
      String namaregister = prefs.getString('namaregister')!;
      String nohpregister = prefs.getString('nohpregister')!;

      Map data = {
        'srahp': srahp,
        'sravlnm': namaregister,
        'nohpad': nohpregister,
        'srapr': srapr,
        'srakt': srakt,
        'srakct': srakct,
        'srakl': srakl,
        'sradpt': totaldptcontrolel.text,
        'srasah': totalsahtcontrolel.text,
        'srasrc': totalsuaracalegcontrolel.text,
        'stsvald': 'Y',


      };

      dynamic jsonResponse;
      var response = await http.post(
          Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/updatesuara.php"),
          body: data);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text("Validasi Berhasil")));

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const CustomNavBar();
              }));

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Data Berhasil Di Validasi !")));
        } else {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text("Validasi Gagal!")));
        }
      } else {}
    }
    cekdatasaksi() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String kodecaleg = prefs.getString('kodecaleg')!;
      String nohsaksi = prefs.getString('srahp')!;

      Map data = {
        'srakc': kodecaleg,
        'srahp': nohsaksi,
      };

      dynamic jsonResponse;
      var response = await http.post(
          Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/ceksra.php"),
          body: data);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          if (jsonResponse['data'] != null) {
            setState(() {
              ftc1 = jsonResponse['data']['ftc1'];
              sratps = jsonResponse['data']['sratps'];
              sradpl = jsonResponse['data']['sradpl'];
              srapr = jsonResponse['data']['srapr'];
              srakt = jsonResponse['data']['srakt'];
              srakct = jsonResponse['data']['srakct'];
              srakl = jsonResponse['data']['srakl'];
              sradpt = jsonResponse['data']['sradpt'];
              srasah = jsonResponse['data']['srasah'];
              srasrc = jsonResponse['data']['srasrc'];
              String sravld = jsonResponse['data']['sravld'];
              sravlnm = jsonResponse['data']['sravlnm'];
              namasaksi = jsonResponse['data']['nmsra'];

              if(usrsts=="A") {
                if (sravld == "N") {
                  setState(() {
                    visibleadmin = false;
                    visiblebtnadmin = true;

                    visibletotdptnontvalid = true;
                    visibletotdptvalid=false;

                    visibletotsssnotvalid =true;
                    visibletotsssvalid = false;

                    visibletotcalegnotvalid = true;
                    visibletotcalegvalid = false;
                  });
                } else {
                  setState(() {

                    visibletotcalegnotvalid = false;
                    visibletotcalegvalid = true;

                    visibletotsssnotvalid =false;
                    visibletotsssvalid = true;

                    visibletotdptnontvalid = false;
                    visibletotdptvalid=true;
                    visibleadmin = true;
                    visiblebtnadmin = false;
                  });
                }

              }else if(usrsts=="C") {
                if (sravld == "N") {
                  setState(() {
                    visibleadmin = false;
                    visiblebtnadmin = true;

                    visibletotdptnontvalid = true;
                    visibletotdptvalid=false;

                    visibletotsssnotvalid =true;
                    visibletotsssvalid = false;

                    visibletotcalegnotvalid = true;
                    visibletotcalegvalid = false;
                  });
                } else {
                  setState(() {

                    visibletotcalegnotvalid = false;
                    visibletotcalegvalid = true;

                    visibletotsssnotvalid =false;
                    visibletotsssvalid = true;

                    visibletotdptnontvalid = false;
                    visibletotdptvalid=true;
                    visibleadmin = true;
                    visiblebtnadmin = false;
                  });
                }

              }else{
                setState(() {

                  visibletotcalegnotvalid = false;
                  visibletotcalegvalid = true;

                  visibletotsssnotvalid =false;
                  visibletotsssvalid = true;

                  visibletotdptnontvalid = false;
                  visibletotdptvalid=true;
                  visibleadmin = true;
                  visiblebtnadmin = false;
                });
              }

              totaldptcontrolel.text = sradpt;
              totalsahtcontrolel.text = srasah;
              totalsuaracalegcontrolel.text = srasrc;

            });
          } else {
            setState(() {

            });
          }
        } else {

        }
      } else {

      }
    }
  }




