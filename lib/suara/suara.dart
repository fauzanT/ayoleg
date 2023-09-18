// import 'dart:async';
// import 'dart:convert';

import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/berita/pesandetail.dart';
import 'package:ayoleg/berita/tambahberita.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:ayoleg/suara/suaradetail.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuaraPage extends StatefulWidget {
  const SuaraPage({Key? key}) : super(key: key);

  @override
  State<SuaraPage> createState() => _SuaraPagetate();
}

class _SuaraPagetate extends State<SuaraPage> {
  late SharedPreferences sharedPrefs;
  // Future<List<Datasaksi>>? futuresaksi;
  String radioButtonItem = "";
  int? _value;

  ScrollController? _controllerpesan;
  ScrollController? _controllertablesaksi;
  String kodecaleg = "";
  var _baseUrlpesan = '';
  var _baseUrltablesaksi = '';
  String? sradpt;
  String? srasah;
  String? srasrc;

  bool visibleerorpesan = false;
  bool visibletamahsuara = false;


  int _page = 0;
  int jumlahberitasaksi = 0;
  final int _limit = 5;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  bool visibleerortablesaksi = false;
  bool visiblelistsuara = false;

  String usrsts = "";
  String nohpAkun = "";

  List _postspesan = [];
  List _posttable = [];
  List filteredItemtablesaksi = [];
  List filteredItemsaksi = [];

  @override
  void initState() {

    cektotinfo();
    setState(() {

      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        kodecaleg = prefs.getString('kodecaleg')!;
        // futuresaksi = fetchGetDatasaksi(kodecaleg);
        usrsts = prefs.getString('usrsts')!;
        nohpAkun = prefs.getString('nohpregister')!;

        _baseUrltablesaksi = 'http://aplikasiayocaleg.com/ayocalegapi/getsaksi.php?srakc=' +
            kodecaleg;

        _baseUrlpesan = 'http://aplikasiayocaleg.com/ayocalegapi/getberita.php?brtkc=' +
            kodecaleg +
            "&brtsts=S";

        _firstLoadpesan();

        _controllerpesan = ScrollController()..addListener(_loadMorepesan);
        _firstLoadsaksi();
        _controllertablesaksi = ScrollController()..addListener(_loadMoresaksi);

        cektotdatasuara();


        if(usrsts=="S") {
          setState(() {
            visibletamahsuara = true;
          });

        }else{
          setState(() {
            visibletamahsuara = false;
          });

        }
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: WillPopScope(
          onWillPop: () => Future.value(false),
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

                // backgroundColor: greenPrimary,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  labelStyle: TextStyle(fontFamily: 'poppins'),
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text(
                        "Perhitungan Suara",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Info Saksi",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),

                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'Suara',
                      style:
                      TextStyle(fontFamily: 'poppins', color: whitePrimary),
                    ),
                    Container(
                      width: 17,
                    )
                  ],
                )),
            body: TabBarView(children: [
              datasuara(),
              infosuara(),

            ]),
          ),
        ));
  }

  Widget datasuara() {
    final size = MediaQuery.of(context).size;
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(left: 20,top: 20),
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

                      // _baseUrltablesaksi = 'http://aplikasiayocaleg.com/ayocalegapi/getsaksifilter.php?srakc=' +
                      //     kodecaleg+
                      //     "&stsvald=Y";
                      //
                      cektotdatasuaraY();
                      // _firstLoadsaksi();
                      // _controllertablesaksi = ScrollController()..addListener(_loadMoresaksi);
                      // radioButtonItem = 'Y';
                      filterItemtablesaksi("Y");
                      _value = 1;
                    });
                  },
                ),

                const Text(
                  'Tervalidasi',
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
                      // radioButtonItem = 'N';
                      // _baseUrltablesaksi = 'http://aplikasiayocaleg.com/ayocalegapi/getsaksifilter.php?srakc=' +
                      //     kodecaleg+
                      //     "&stsvald=N";
                      cektotdatasuaraN();
                      // _firstLoadsaksi();
                      // _controllertablesaksi = ScrollController()..addListener(_loadMoresaksi);
                      filterItemtablesaksi("N");
                      _value = 2;
                    });
                  },
                ),

                const Text(
                  'Belum Di Validasi',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 12,
                      color: greenPrimary,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),

      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[

        Container(
            width: 380,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 2, top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: gradient5),
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 60.0,
                      width: 40,
                      child: Table(
                        border: TableBorder(
                            horizontalInside: BorderSide(color: Colors.white),
                            right: BorderSide(color: Colors.white)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: gradient5,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0))),
                              children: [
                                Container(
                                    height: 60.0,
                                    child: Center(
                                        child: Text(
                                      'Saksi',
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 11,
                                          color: Colors.black),
                                      // style: myLabelTextStyle,
                                    ))),
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      height: 60.0,
                      width: 120,
                      child: Table(
                        border: TableBorder(
                            horizontalInside: BorderSide(color: Colors.white),
                            right: BorderSide(color: Colors.white)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: gradient5,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0))),
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: 60.0,
                                    child: Center(
                                        child: Text(
                                      'Daerah Pemilihan',
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 11,
                                          color: Colors.black),
                                      // style: myLabelTextStyle,
                                    ))),
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      width: 40,
                      child: Table(
                        border: TableBorder(
                            horizontalInside: BorderSide(color: Colors.white),
                            right: BorderSide(color: Colors.white)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: gradient5,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0))),
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: 60.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'No.',
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 10,
                                              color: Colors.black),
                                          // style: myLabelTextStyle,
                                        ),
                                        Text(
                                          'TPS',
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 10,
                                              color: Colors.black),
                                          // style: myLabelTextStyle,
                                        )
                                      ],
                                    )),
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      height: 60.0,
                      width: 40,
                      child: Table(
                        border: TableBorder(
                            horizontalInside: BorderSide(color: Colors.white),
                            right: BorderSide(color: Colors.white)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: gradient5,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0))),
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: 60.0,
                                    child: Center(
                                        child: Text(
                                      'DPT',
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 10,
                                          color: Colors.black),
                                      // style: myLabelTextStyle,
                                    ))),
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      width: 40,
                      child: Table(
                        border: TableBorder(
                            horizontalInside: BorderSide(color: Colors.white),
                            right: BorderSide(color: Colors.white)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: gradient5,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0))),
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: 60.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Suara',
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 10,
                                              color: Colors.black),
                                          // style: myLabelTextStyle,
                                        ),
                                        Text(
                                          'Sah',
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 10,
                                              color: Colors.black),
                                          // style: myLabelTextStyle,
                                        )
                                      ],
                                    )),
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      width: 40,
                      child: Table(
                        border: TableBorder(
                            horizontalInside: BorderSide(color: Colors.white),
                            right: BorderSide(color: Colors.white)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: gradient5,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0))),
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: 60.0,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Suara',
                                          style: const TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 10,
                                              color: Colors.black),
                                          // style: myLabelTextStyle,
                                        ),
                                        Text(
                                          'Caleg',
                                          style: const TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 10,
                                              color: Colors.black),
                                          // style: myLabelTextStyle,
                                        )
                                      ],
                                    ))),
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      height: 60.0,
                      width: 45,
                      child: Table(
                        border: TableBorder.symmetric(
                            inside: BorderSide(color: gradient5)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: gradient5,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(0.0))),
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: 60.0,
                                    child: Center(
                                        child: Text(
                                      'Valid',
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 10,
                                          color: Colors.black),
                                      // style: myLabelTextStyle,
                                    )))
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),

                datasaksi(),

              ],
            )),
      ]),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 5),
        height: 30,
        width: 380,
        decoration: BoxDecoration(
          // color: shadowColor4,
          // border: Border.all(color: shadowColor2),
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30.0,
              width: 200,
              child: Table(
                border: TableBorder(
                    horizontalInside: BorderSide(color: shadowColor2),
                    right: BorderSide(color: gradient5)),
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          color: shadowColor2,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(0.0))),
                      children: [
                        Container(
                            height: 30.0,
                            child: Center(
                                child: Text(
                              'Total : ',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 12,
                                  color: Colors.black),
                              // style: myLabelTextStyle,
                            ))),
                      ]),
                ],
              ),
            ),
            Container(
              height: 30.0,
              width: 80,
              child: Table(
                border: TableBorder(
                    horizontalInside: BorderSide(color: shadowColor2),
                    right: BorderSide(color: gradient5)),
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          color: shadowColor2,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(0.0))),
                      children: [
                        Container(
                          height: 30.0,
                          width: 40,
                          child: Table(
                            border: TableBorder(
                                horizontalInside:
                                    BorderSide(color: shadowColor2),
                                right: BorderSide(color: gradient5)),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                      color: shadowColor2,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0.0))),
                                  children: [
                                    Container(
                                      height: 30.0,
                                      child: Center(
                                          child: sradpt != null
                                              ? Text(
                                                  CurrencyFormat.convertToIdr(
                                                      int.parse(sradpt!), 0),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'poppins',
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : Text(
                                                  "0",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'poppins',
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 40,
                          child: Table(
                            border: TableBorder(
                                horizontalInside:
                                    BorderSide(color: shadowColor2),
                                right: BorderSide(color: gradient5)),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                      color: shadowColor2,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0.0))),
                                  children: [
                                    Container(
                                      height: 30.0,
                                      child: Center(
                                          child: srasah!= null
                                              ? Text(
                                                  CurrencyFormat.convertToIdr(
                                                      int.parse(srasah!), 0),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'poppins',
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : Text(
                                                  "0",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'poppins',
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            Container(
              height: 30.0,
              width: 40,
              child: Table(
                border: TableBorder(
                    horizontalInside: BorderSide(color: shadowColor2),
                    right: BorderSide(color: gradient5)),
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          color: shadowColor2,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(0.0))),
                      children: [
                        Container(
                          height: 30.0,
                          child: Center(
                              child: srasrc!= null
                                  ? Text(
                                      CurrencyFormat.convertToIdr(
                                          int.parse(srasrc!), 0),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget datasaksi() {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
          child: CircularProgressIndicator(),
        )
            :
        SingleChildScrollView(
          child:
          Container(
            child: Column(
              children: [
                SizedBox(

                  child:
                  SingleChildScrollView(

                    child:
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItemtablesaksi.length,
                      controller: _controllertablesaksi,
                      itemBuilder: (_, index) =>


                          GestureDetector(
                            onTap: () async {
                              setState(() async {
                                SharedPreferences prefs =
                                await SharedPreferences
                                    .getInstance();
                                prefs.setString("srahp",
                                  filteredItemtablesaksi[index]["srahp"]);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const SuaraDetailpage()));
                              });
                            },
                            child:     Row(
                              children: [
                                Container(
                                    height: 30.0,
                                    width: 40,
                                    child: Center(
                                      child: Table(
                                        border: TableBorder(
                                            horizontalInside:
                                            BorderSide(
                                                color: Colors.blue
                                                    .shade400),
                                            right: BorderSide(
                                                color: Colors
                                                    .blue.shade400)),
                                        children: [
                                          TableRow(
                                              decoration:
                                              BoxDecoration(
                                                // color: shadowColor4,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          0.0))),
                                              children: [
                                                Center(
                                                    child: Text(
                                                      filteredItemtablesaksi[index]["nmsra"],
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'poppins',
                                                          fontSize: 9,
                                                          color: Colors
                                                              .black),
                                                    ))
                                              ]),
                                        ],
                                      ),
                                    )),
                                Container(
                                    height: 30.0,
                                    width: 120,
                                    child: Center(
                                      child: Table(
                                        border: TableBorder(
                                            horizontalInside:
                                            BorderSide(
                                                color: Colors.blue
                                                    .shade400),
                                            right: BorderSide(
                                                color: Colors
                                                    .blue.shade400)),
                                        children: [
                                          TableRow(
                                              decoration:
                                              BoxDecoration(
                                                // color: shadowColor4,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          0.0))),
                                              children: [
                                                Center(
                                                    child: Text(
                                                      filteredItemtablesaksi[index]["sradpl"],

                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'poppins',
                                                          fontSize: 9,
                                                          color: Colors
                                                              .black),
                                                    ))
                                              ]),
                                        ],
                                      ),
                                    )),
                                Container(
                                    height: 30.0,
                                    width: 40,
                                    child: Center(
                                      child: Table(
                                        border: TableBorder(
                                            horizontalInside:
                                            BorderSide(
                                                color: Colors.blue
                                                    .shade400),
                                            right: BorderSide(
                                                color: Colors
                                                    .blue.shade400)),
                                        children: [
                                          TableRow(
                                              decoration:
                                              BoxDecoration(
                                                // color: shadowColor4,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          0.0))),
                                              children: [
                                                Center(
                                                    child: Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                          int.parse(
                                                              filteredItemtablesaksi[index]["sratps"]),
                                                          0),
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'poppins',
                                                          fontSize: 9,
                                                          color: Colors
                                                              .black),
                                                    ))
                                              ]),
                                        ],
                                      ),
                                    )),
                                Container(
                                    height: 30.0,
                                    width: 40,
                                    child: Center(
                                      child: Table(
                                        border: TableBorder(
                                            horizontalInside:
                                            BorderSide(
                                                color: Colors.blue
                                                    .shade400),
                                            right: BorderSide(
                                                color: Colors
                                                    .blue.shade400)),
                                        children: [
                                          TableRow(
                                              decoration:
                                              BoxDecoration(
                                                // color: shadowColor4,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          0.0))),
                                              children: [
                                                Center(
                                                    child: Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                          int.parse(filteredItemtablesaksi[index]["sradpt"]),
                                                          0),
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'poppins',
                                                          fontSize: 9,
                                                          color: Colors
                                                              .black),
                                                    ))
                                              ]),
                                        ],
                                      ),
                                    )),
                                Container(
                                    height: 30.0,
                                    width: 40,
                                    child: Center(
                                      child: Table(
                                        border: TableBorder(
                                            horizontalInside:
                                            BorderSide(
                                                color: Colors.blue
                                                    .shade400),
                                            right: BorderSide(
                                                color: Colors
                                                    .blue.shade400)),
                                        children: [
                                          TableRow(
                                              decoration:
                                              BoxDecoration(
                                                // color: shadowColor4,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          0.0))),
                                              children: [
                                                Center(
                                                    child: Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                          int.parse(filteredItemtablesaksi[index]["srasah"]
                                                          ),
                                                          0),
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'poppins',
                                                          fontSize: 9,
                                                          color: Colors
                                                              .black),
                                                    ))
                                              ]),
                                        ],
                                      ),
                                    )),
                                Container(
                                    height: 30.0,
                                    width: 40,
                                    child: Center(
                                      child: Table(
                                        border: TableBorder(
                                            horizontalInside:
                                            BorderSide(
                                                color: Colors.blue
                                                    .shade400),
                                            right: BorderSide(
                                                color: Colors
                                                    .blue.shade400)),
                                        children: [
                                          TableRow(
                                              decoration:
                                              BoxDecoration(
                                                // color: shadowColor4,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          0.0))),
                                              children: [
                                                Center(
                                                    child: Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                          int.parse(filteredItemtablesaksi[index]["srasrc"]
                                                          ),
                                                          0),
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'poppins',
                                                          fontSize: 9,
                                                          color: Colors
                                                              .black),
                                                    ))
                                              ]),
                                        ],
                                      ),
                                    )),
                                Container(
                                    height: 30.0,
                                    width: 47,
                                    child: Center(
                                      child: Table(
                                        children: [
                                          TableRow(
                                              decoration:
                                              BoxDecoration(
                                                // color: shadowColor4,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          0.0))),
                                              children: [
                                                Center(
                                                    child: Text(
                                                      filteredItemtablesaksi[index]["sravlnm"],

                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'poppins',
                                                          fontSize: 9,
                                                          color: Colors
                                                              .black),
                                                    ))
                                              ]),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),


                    ),
                  ),
                ),

                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),


              ],
            ),
          ),
        ),
        Visibility(
          visible: visibleerortablesaksi,
          child: Center(
            child: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/images/riwayatnon.png',
                  //   scale: 3.5,
                  // ),
                  SizedBox(height: 15),
                  const Text(
                    'Data Tidak Ada !',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: greenPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget infosuara() {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
          child: CircularProgressIndicator(),
        )
            :
        RefreshIndicator(
          // Set the onRefresh callback to the fetchData method
          onRefresh: _refreshList,
          child:
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),

          child:
          Container(
            margin: const EdgeInsets.only(
                bottom: 70),
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => filterIteminfosaksi(value),
                    decoration: InputDecoration(
                      labelText: 'Cari',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Visibility(
                    visible: visiblelistsuara,
                    child:
                SizedBox(

                  child:
                  SingleChildScrollView(

                    child:
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItemsaksi.length,
                      controller: _controllerpesan,
                      itemBuilder: (_, index) => Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: ListTile(
                          title: GestureDetector(
                              onTap: () async {
                                setState(() async {
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                                  prefs.setString(
                                      "idberita", filteredItemsaksi[index]["idb"]);
                                  // prefs.setString('nohprelawan', data[index].usrhp!);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const PesanDetailpage()));
                                  // Navigator.pop(context);
                                });
                              },
                              child: Container(

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    InkWell(
                                      child: Container(
                                        child: ListTile(
                                          tileColor: whitePrimary,
                                          leading: Image.network(
                                            // widget.question.fileInfo[0].remoteURL,

                                            filteredItemsaksi[index]["brtft"],
                                            width: 80,
                                            height: 80,
                                            //
                                            loadingBuilder: (context, child,
                                                loadingProgress) =>
                                            (loadingProgress == null)
                                                ? child
                                                : CircularProgressIndicator(),
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                          title: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer_outlined,
                                                    size: 17,
                                                  ),
                                                  Text(
                                                    filteredItemsaksi[index]
                                                    ["brtdp"] +
                                                        " " +
                                                        filteredItemsaksi[index]
                                                        ["brttp"],
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                  ),
                                                  filteredItemsaksi[
                                                  index]
                                                  [
                                                  "brthp"] ==
                                                      nohpAkun
                                                      ? Align(
                                                    alignment:
                                                    Alignment
                                                        .topRight,
                                                    child:
                                                    IconButton(
                                                      onPressed:
                                                          () {
                                                        dialogdeleteinfo(
                                                            filteredItemsaksi[index]
                                                            [
                                                            "idb"]);
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .delete_outline,
                                                        color:
                                                        gradient6,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  )
                                                      : usrsts == "A"
                                                      ? Align(
                                                    alignment:
                                                    Alignment
                                                        .topRight,
                                                    child:
                                                    IconButton(
                                                      onPressed:
                                                          () {
                                                        dialogdeleteinfo(filteredItemsaksi[index]
                                                        [
                                                        "idb"]);
                                                      },
                                                      icon:
                                                      Icon(
                                                        Icons
                                                            .delete_outline,
                                                        color:
                                                        gradient6,
                                                        size:
                                                        25,
                                                      ),
                                                    ),
                                                  )
                                                      : usrsts ==
                                                      "C"
                                                      ? Align(
                                                    alignment:
                                                    Alignment.topRight,
                                                    child:
                                                    IconButton(
                                                      onPressed:
                                                          () {
                                                        dialogdeleteinfo(filteredItemsaksi[index]["idb"]);
                                                      },
                                                      icon:
                                                      Icon(
                                                        Icons.delete_outline,
                                                        color: gradient6,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  )
                                                      : Text(
                                                    " ",
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                //2 or more line you want
                                                filteredItemsaksi[index]["brtnm"],

                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                //2 or more line you want
                                                filteredItemsaksi[index]["brtjdl"],

                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),

                          // subtitle: Text(_posts[index]['body']),
                        ),
                      ),
                    ),
                  ),
                ),
                ),

                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),


              ],
            ),
          ),
        ),
    ),
        Visibility(
          visible: visibleerorpesan,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/riwayatnon.png',
                    scale: 3.5,
                  ),
                  SizedBox(height: 15),
                  const Text(
                    'Data Tidak Ada !',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: greenPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),



        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: new EdgeInsets.fromLTRB(00, 0, 10, 70),
              child: FadeInUp(
                duration: Duration(milliseconds: 1300),
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: greenPrimary,
                      onPrimary: whitePrimary,
                      shadowColor: shadowColor,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(100, 40), //////// HERE
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text(
                      'Total : ' + CurrencyFormat.convertToIdr(jumlahberitasaksi, 0),
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: whitePrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )),
    Visibility(
    visible: visibletamahsuara,
    child:
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: new EdgeInsets.fromLTRB(00, 0, 10, 120),
              child: FadeInUp(
                duration: Duration(milliseconds: 1300),
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: greenPrimary,
                      onPrimary: whitePrimary,
                      shadowColor: shadowColor,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(100, 40), //////// HERE
                    ),
                    onPressed: () {
                      setState(() async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("brtsts", "S");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const Tambahnewspage()));
                      });
                    },
                    child: Icon(
                      Icons.add_card,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )),
    ),

      ],
    );
  }

  cektotinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;

    Map data = {'brtkc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmlinfo.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          jumlahberitasaksi = jsonResponse['jumlahpesan'];

          if(jsonResponse['jumlahpesan']==0){
            setState(() {
              visiblelistsuara = false;
              visibleerorpesan = true;
            });
          }else{
            setState(() {
              visiblelistsuara = true;
              visibleerorpesan = false;
            });
          }
        });
      }
    }
  }

  cektotdatasuara() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'srakc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cektotsaksi.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          sradpt = jsonResponse['sradpt']['sum'];
          srasah = jsonResponse['srasah']['sum'];
          srasrc = jsonResponse['srasrc']['sum'];
          if(sradpt == null){
            visibleerortablesaksi = true;
          }else{
            visibleerortablesaksi = false;
          }

        });
      }
    }
  }

  cektotdatasuaraY() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'srakc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cektotsaksi.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {

          sradpt = jsonResponse['sradpty']['sum'];
          srasah = jsonResponse['srasahy']['sum'];
          srasrc = jsonResponse['srasrcy']['sum'];

       if(sradpt == null){
         visibleerortablesaksi = true;
       }else{
         visibleerortablesaksi = false;
       }

        });
      }
    }
  }

  cektotdatasuaraN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'srakc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cektotsaksi.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          sradpt = jsonResponse['sradptn']['sum'];
          srasah = jsonResponse['srasahn']['sum'];
          srasrc = jsonResponse['srasrcn']['sum'];

          if(sradpt == null){
            visibleerortablesaksi = true;
          }else{
            visibleerortablesaksi = false;
          }

        });
      }
    }
  }




  void _loadMorepesan() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controllerpesan!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrlpesan&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postspesan.addAll(fetchedPosts);
            filteredItemsaksi = _postspesan;
            // visibleerorrelawan = false;
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          setState(() {
            _hasNextPage = false;
          });
        }
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
  void _firstLoadpesan() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrlpesan&_page=$_page&_limit=$_limit"));
      setState(() {
        _postspesan = json.decode(res.body);
        filteredItemsaksi = _postspesan;

        // visiblelistsuara = true;
        // visibleerorpesan = false;

      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          // visiblelistsuara = false;
          // visibleerorpesan = true;

        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMoresaksi() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controllerpesan!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrltablesaksi&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posttable.addAll(fetchedPosts);
            filteredItemtablesaksi = _posttable;
            // visibleerorrelawan = false;
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          setState(() {
            _hasNextPage = false;

          });
        }
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
  void _firstLoadsaksi() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrltablesaksi&_page=$_page&_limit=$_limit"));
      setState(() {
        _posttable = json.decode(res.body);

        filteredItemtablesaksi = _posttable;


        // visibleerortablesaksi = false;

      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {

          // visibleerortablesaksi = true;

        });
      }
    }
    setState(() {

      _isFirstLoadRunning = false;
    });
  }

  void filterIteminfosaksi(String query) {
    setState(() {
      filteredItemsaksi = _postspesan
          .where((item) => item['brtjdl'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void filterItemtablesaksi(String query) {
    setState(() {
      filteredItemtablesaksi = _posttable
          .where((item) => item['stsvald'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  Future<void> _refreshList() async {
    // Simulate a time-consuming operation here.
    // await Future.delayed(Duration(seconds: 2));

    // await Future.delayed(Duration(seconds: 2));

    // setState(() {
    //   events = EventsList();
    // });
    setState(() {
      _firstLoadpesan();
      _controllerpesan = ScrollController()..addListener(_loadMorepesan);
      _firstLoadsaksi();
      _controllertablesaksi = ScrollController()..addListener(_loadMoresaksi);

      cektotinfo();();
    });
    // print("Refresh Pressed");
    // return null;


  }

  deleteinfo(String idb) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {
      'idb': idb,
      'stsact': "N",
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/updatestsbrt.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _refreshList();

        });
      } else {}
    } else {}
  }

  Future dialogdeleteinfo(String idb) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Icon(
              Icons.delete_forever,
              color: gradient6,
              size: 50,
            ),
          ),
          content: Text(
            "Yakin Hapus Pesan Ini ?",
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: const Text(
                    'Batal',
                    style:
                    const TextStyle(fontSize: 12, color: shadowColor3),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context, false);
                    });
                  },
                ),
                TextButton(
                  child: const Text(
                    'Hapus',
                    style:
                    const TextStyle(fontSize: 12, color: greenPrimary),
                  ),
                  onPressed: () {
                    setState(() {
                      deleteinfo(idb);
                      Navigator.pop(context, false);
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }

}
