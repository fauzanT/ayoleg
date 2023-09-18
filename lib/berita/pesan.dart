import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/berita/agenda.dart';
import 'package:ayoleg/berita/pesandetail.dart';
import 'package:ayoleg/berita/tambahberita.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pesanpage extends StatefulWidget {
  const Pesanpage({Key? key}) : super(key: key);

  @override
  State<Pesanpage> createState() => _PesanpageState();
}

class _PesanpageState extends State<Pesanpage> {
  // Future<List<Databerita>>? futureberita;
  // Future<List<Databeritaagenda>>? futureagenda;
  // Future<List<Databerita>>? futureactivity;
  // Future<List<Databerita>>? futurepesan;

  var _baseUrlberita = '';
  var _baseUrlagenda = '';
  var _baseUrlactivity = '';
  var _baseUrlpesan = '';
  var _baseUrlpesancaleg = '';
  int _page = 0;
  final int _limit = 10;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  List _postsberita = [];
  List _postsagenda = [];
  List _postsactivity = [];
  List _postspesan = [];
  List _postspesancaleg = [];

  List filteredItemberita = [];
  List filteredItemsagenda = [];
  List filteredItemkegiatanrelawan = [];
  List filteredItemskegiatancampanye = [];
  List filteredItemspesancaleg = [];

  ScrollController? _controllerberita;
  ScrollController? _controllagenda;
  ScrollController? _controlleractivity;
  ScrollController? _controllerpesan;
  ScrollController? _controllerpesancaleg;

  late Timer _timerForInter;
  File? imageFile;
  String kodecaleg = "";
  String nohpAkun = "";
  bool visibleerorberita = false;
  bool visibleeroragenda = false;
  bool visibleerorpesan = false;
  bool visibleeroractivity = false;
  bool visibleberitatambah = false;
  bool visibleagendatambah = false;
  bool visibleactivitytambah = false;
  bool visiblepesantambah = false;
  bool visibleerorpesancaleg = false;

  bool visiblehapuskegiatancampanye = false;
  bool visiblehapuskegiatanrelawan = false;
  bool visiblehapusagenda = false;
  bool visiblehapusinfo = false;

  bool visiblelistberita = false;
  bool visiblelistagenda = false;
  bool visiblelistactivity = false;
  bool visiblelistpesan = false;
  bool visiblelistpesancaleg = false;

  int jumlahberita = 0;
  int jumlahagenda = 0;
  int jumlahkegiatanrelawan = 0;
  int jumlahkegiatankampanye = 0;
  int jumlahpesancaleg = 0;

  late SharedPreferences sharedPrefs;
  String usrsts = "";

  @override
  void initState() {
    cektotinfo();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      kodecaleg = prefs.getString('kodecaleg')!;
      nohpAkun = prefs.getString('nohpregister')!;

      usrsts = prefs.getString('usrsts')!;
      _baseUrlberita =
          'http://aplikasiayocaleg.com/ayocalegapi/getberita.php?brtkc=' +
              kodecaleg +
              "&brtsts=B";
      _baseUrlagenda =
          'http://aplikasiayocaleg.com/ayocalegapi/getberita.php?brtkc=' +
              kodecaleg +
              "&brtsts=A";
      _baseUrlactivity =
          'http://aplikasiayocaleg.com/ayocalegapi/getberita.php?brtkc=' +
              kodecaleg +
              "&brtsts=D";
      _baseUrlpesan =
          'http://aplikasiayocaleg.com/ayocalegapi/getberita.php?brtkc=' +
              kodecaleg +
              "&brtsts=P";
      _baseUrlpesancaleg =
          'http://aplikasiayocaleg.com/ayocalegapi/getberita.php?brtkc=' +
              kodecaleg +
              "&brtsts=C";

      _firstLoberita();
      _firstLoadagenda();
      _firstLoadactivity();
      _firstLoadpesan();
      _firstLoadpesancaleg();

      _controllerberita = ScrollController()..addListener(_loadMorberita);
      _controllagenda = ScrollController()..addListener(_loadMoreagenda);
      _controlleractivity = ScrollController()..addListener(_loadMoreactivity);
      _controllerpesan = ScrollController()..addListener(_loadMorepesan);
      _controllerpesancaleg = ScrollController()
        ..addListener(_loadMorepesancaleg);
      // nohpAkun = prefs.getString('nohpregister')!;
      // fetchDatainbox(nohpAkun);

      if (usrsts == "A") {
        visibleberitatambah = true;
        visibleagendatambah = true;
        visibleactivitytambah = false;
        visiblepesantambah = true;

         visiblehapuskegiatancampanye = true;
         visiblehapuskegiatanrelawan = true;
         visiblehapusagenda = true;
         visiblehapusinfo = true;
      } else if (usrsts == "C") {
        visibleberitatambah = true;
        visibleagendatambah = true;
        visibleactivitytambah = false;
        visiblepesantambah = true;

        visiblehapuskegiatancampanye = true;
        visiblehapuskegiatanrelawan = true;
        visiblehapusagenda = true;
        visiblehapusinfo = true;
      } else if (usrsts == "R") {
        visibleberitatambah = true;
        visibleagendatambah = false;
        visibleactivitytambah = true;
        visiblepesantambah = false;

        visiblehapuskegiatancampanye = false;
        visiblehapuskegiatanrelawan = false;
        visiblehapusagenda = false;
        visiblehapusinfo = false;
      } else {
        visibleberitatambah = true;
        visibleagendatambah = false;
        visibleactivitytambah = false;
        visiblepesantambah = false;

        visiblehapuskegiatancampanye = false;
        visiblehapuskegiatanrelawan = false;
        visiblehapusagenda = false;
        visiblehapusinfo = false;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _timerForInter.cancel();
    super.dispose();
  }

  var ctime;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
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
                  labelColor: gradient6,
                  tabs: [
                    Tab(
                      child: Text(
                        "Berita",
                        style:
                            const TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Agenda",
                        style:
                            const TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Kegiatan Relawan",
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Kegiatan Kampanye",
                        style:
                            const TextStyle(fontSize: 9, color: Colors.white),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Pesan",
                        style:
                            const TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   icon: Icon(
                    //     Icons.arrow_back_ios,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Text(
                      'Info',
                      style:
                          TextStyle(fontFamily: 'poppins', color: whitePrimary),
                    ),
                    Container(
                      width: 17,
                    )
                  ],
                )),
            body: TabBarView(children: [
              databerita(),
              dataagenda(),
              dataactivitas(),
              datapesan(),
              datapesancaleg(),
            ]),
          ),
        ));
  }

  Widget databerita() {
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
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) => filterItemberita(value),
                            decoration: InputDecoration(
                              labelText: 'Cari',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: visiblelistberita,
                            child:
                        SizedBox(
                          child: SingleChildScrollView(
                            child:
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredItemberita.length,
                              controller: _controllerberita,
                              itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: ListTile(
                                    title: Stack(children: <Widget>[
                                  GestureDetector(
                                      onTap: () async {
                                        setState(() async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          prefs.setString("idberita",
                                              filteredItemberita[index]["idb"]);
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                child: ListTile(
                                                  tileColor: whitePrimary,
                                                  leading: Image.network(
                                                    // widget.question.fileInfo[0].remoteURL,

                                                    filteredItemberita[index]
                                                        ["brtft"],
                                                    width: 80,
                                                    height: 80,
                                                    //
                                                    loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) =>
                                                        (loadingProgress ==
                                                                null)
                                                            ? child
                                                            : CircularProgressIndicator(),
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      Future.delayed(
                                                        Duration(
                                                            milliseconds: 0),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .timer_outlined,
                                                            size: 17,
                                                          ),
                                                          Text(
                                                            filteredItemberita[
                                                                        index]
                                                                    ["brtdp"] +
                                                                " " +
                                                                filteredItemberita[
                                                                        index]
                                                                    ["brttp"],
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontSize: 9,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          filteredItemberita[
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
                                                                          filteredItemberita[index]
                                                                              [
                                                                              "idb"],filteredItemberita[index]
                                                                      ["brtft"]);
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
                                                                          dialogdeleteinfo(filteredItemberita[index]
                                                                              [
                                                                              "idb"],filteredItemberita[index]
                                                                          ["brtft"]);
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
                                                                              dialogdeleteinfo(filteredItemberita[index]["idb"],filteredItemberita[index]
                                                                              ["brtft"]);
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
                                                        filteredItemberita[
                                                            index]["brtnm"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        //2 or more line you want
                                                        filteredItemberita[
                                                            index]["brtjdl"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                  // subtitle: Text(
                                                  //   //2 or more line you want
                                                  //   // maxLines: 2,
                                                  //   _postspesan[index]["brtbrt"],
                                                  //
                                                  //   overflow: TextOverflow.ellipsis,
                                                  //   style: const TextStyle(
                                                  //       fontFamily: 'poppins',
                                                  //       color: textPrimary,
                                                  //       fontWeight: FontWeight.bold,
                                                  //       fontSize: 11),
                                                  // ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  // Visibility(
                                  //   visible: visiblehapusinfo,
                                  //   child: Align(
                                  //     alignment: Alignment.topRight,
                                  //     child: IconButton(
                                  //       onPressed: () {
                                  //         dialogdeleteinfo(
                                  //             filteredItemberita[index]["idb"]);
                                  //       },
                                  //       icon: Icon(
                                  //         Icons.delete_outline,
                                  //         color: gradient6,
                                  //         size: 25,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ])),
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
                              child:
                                  Text('You have fetched all of the content'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
        Visibility(
          visible: visibleerorberita,
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
                      'Total : ' + CurrencyFormat.convertToIdr(jumlahberita, 0),
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
          visible: visibleberitatambah,
          child: Align(
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
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("brtsts", "B");
                          prefs.remove('fotoimage');
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

  Widget dataagenda() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                // Set the onRefresh callback to the fetchData method
                onRefresh: _refreshList,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) => filterItemagenda(value),
                            decoration: InputDecoration(
                              labelText: 'Cari',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: visiblelistagenda,
                            child:
                        SizedBox(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredItemsagenda.length,
                              controller: _controllagenda,
                              itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: ListTile(
                                    title: Stack(children: <Widget>[
                                  GestureDetector(
                                      onTap: () async {
                                        setState(() async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          prefs.setString(
                                              "idberita",
                                              filteredItemsagenda[index]
                                                  ["idb"]);
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                child: ListTile(
                                                  tileColor: whitePrimary,
                                                  leading: Image.network(
                                                    filteredItemsagenda[index]
                                                        ["brtft"],

                                                    width: 100,
                                                    height: 100,
                                                    //
                                                    loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) =>
                                                        (loadingProgress ==
                                                                null)
                                                            ? child
                                                            : CircularProgressIndicator(),
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      Future.delayed(
                                                        Duration(
                                                            milliseconds: 0),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .timer_outlined,
                                                            size: 17,
                                                          ),
                                                          Text(
                                                            filteredItemsagenda[
                                                                        index]
                                                                    ["brtdp"] +
                                                                " " +
                                                                filteredItemsagenda[
                                                                        index]
                                                                    ["brttp"],
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontSize: 9,
                                                                color: Colors
                                                                    .black),
                                                          ),

                                                          filteredItemsagenda[
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
                                                                    filteredItemsagenda[index]
                                                                    [
                                                                    "idb"],filteredItemsagenda[index]
                                                                ["brtft"]);
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
                                                                dialogdeleteinfo(filteredItemsagenda[index]
                                                                [
                                                                "idb"],filteredItemsagenda[index]
                                                                    ["brtft"]);
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
                                                                dialogdeleteinfo(filteredItemsagenda[index]["idb"],filteredItemsagenda[index]
                                                                    ["brtft"]);
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
                                                        filteredItemsagenda[
                                                            index]["brtnm"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        //2 or more line you want
                                                        filteredItemsagenda[
                                                            index]["brtjdl"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .timer_outlined,
                                                            size: 17,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "WAKTU Agenda ",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'poppins',
                                                                    fontSize: 9,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                filteredItemsagenda[
                                                                            index]
                                                                        [
                                                                        "tmagd"] +
                                                                    " " +
                                                                    filteredItemsagenda[
                                                                            index]
                                                                        [
                                                                        "dtagd"],
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'poppins',
                                                                    fontSize: 9,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  // Visibility(
                                  //     visible: visiblehapusagenda,
                                  //     child:
                                  //     Align(
                                  //       alignment: Alignment.topRight,
                                  //       child: IconButton(
                                  //         onPressed: () {
                                  //           dialogdeleteinfo(
                                  //               filteredItemsagenda[index]
                                  //                   ["idb"]);
                                  //         },
                                  //         icon: Icon(
                                  //           Icons.delete_outline,
                                  //           color: gradient6,
                                  //           size: 25,
                                  //         ),
                                  //       ),
                                  //     ),
                                  // ),
                                ])

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
                              child:
                                  Text('You have fetched all of the content'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
        Visibility(
          visible: visibleeroragenda,
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
                      'Total : ' + CurrencyFormat.convertToIdr(jumlahagenda, 0),
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
          visible: visibleagendatambah,
          child: Align(
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
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("brtsts", "A");
                          prefs.remove('fotoimage');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Tambahagendapage()));
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

  Widget dataactivitas() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                // Set the onRefresh callback to the fetchData method
                onRefresh: _refreshList,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) =>
                                filterItemkegiatanrelawan(value),
                            decoration: InputDecoration(
                              labelText: 'Cari',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: visiblelistactivity,
                            child:
                        SizedBox(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredItemkegiatanrelawan.length,
                              controller: _controlleractivity,
                              itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: ListTile(
                                    title: Stack(children: <Widget>[
                                  GestureDetector(
                                      onTap: () async {
                                        setState(() async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          prefs.setString(
                                              "idberita",
                                              filteredItemkegiatanrelawan[index]
                                                  ["idb"]);
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                child: ListTile(
                                                  tileColor: whitePrimary,
                                                  leading: Image.network(
                                                    // widget.question.fileInfo[0].remoteURL,
                                                    filteredItemkegiatanrelawan[
                                                        index]["brtft"],

                                                    width: 100,
                                                    height: 100,
                                                    //
                                                    loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) =>
                                                        (loadingProgress ==
                                                                null)
                                                            ? child
                                                            : CircularProgressIndicator(),
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      Future.delayed(
                                                        Duration(
                                                            milliseconds: 0),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .timer_outlined,
                                                            size: 17,
                                                          ),
                                                          Text(
                                                            filteredItemkegiatanrelawan[
                                                                        index]
                                                                    ["brtdp"] +
                                                                " " +
                                                                filteredItemkegiatanrelawan[
                                                                        index]
                                                                    ["brttp"],
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontSize: 9,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          filteredItemkegiatanrelawan[
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
                                                                    filteredItemkegiatanrelawan[index]
                                                                    [
                                                                    "idb"],filteredItemkegiatanrelawan[index]
                                                                ["brtft"]);
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
                                                                dialogdeleteinfo(filteredItemkegiatanrelawan[index]
                                                                [
                                                                "idb"],filteredItemkegiatanrelawan[index]
                                                                ["brtft"]);
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
                                                                dialogdeleteinfo(filteredItemkegiatanrelawan[index]["idb"],filteredItemkegiatanrelawan[index]
                                                                ["brtft"]);
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
                                                        filteredItemkegiatanrelawan[
                                                            index]["brtnm"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        //2 or more line you want
                                                        filteredItemkegiatanrelawan[
                                                            index]["brtjdl"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  // subtitle: Text(
                                                  //   //2 or more line you want
                                                  //   // maxLines: 2,
                                                  //
                                                  //   _postspesan[index]["brtbrt"],
                                                  //
                                                  //   overflow: TextOverflow.ellipsis,
                                                  //   style: const TextStyle(
                                                  //       fontFamily: 'poppins',
                                                  //       color: textPrimary,
                                                  //       fontWeight: FontWeight.bold,
                                                  //       fontSize: 11),
                                                  // ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  // Visibility(
                                  //     visible: visiblehapuskegiatanrelawan,
                                  //     child:
                                  //     Align(
                                  //       alignment: Alignment.topRight,
                                  //       child: IconButton(
                                  //         onPressed: () {
                                  //           dialogdeleteinfo(
                                  //               filteredItemkegiatanrelawan[index]
                                  //               ["idb"]);
                                  //         },
                                  //         icon: Icon(
                                  //           Icons.delete_outline,
                                  //           color: gradient6,
                                  //           size: 25,
                                  //         ),
                                  //       ),
                                  //     ),
                                  // ),
                                ])

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
                              child:
                                  Text('You have fetched all of the content'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
        Visibility(
          visible: visibleeroractivity,
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
                      'Total : ' +
                          CurrencyFormat.convertToIdr(jumlahkegiatanrelawan, 0),
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
          visible: visibleactivitytambah,
          child: Align(
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
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("brtsts", "D");
                          prefs.remove('fotoimage');
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

  Widget datapesan() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                // Set the onRefresh callback to the fetchData method
                onRefresh: _refreshList,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) =>
                                filterItemkegiatancampanye(value),
                            decoration: InputDecoration(
                              labelText: 'Cari',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: visiblelistpesan,
                            child:
                        SizedBox(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredItemskegiatancampanye.length,
                              controller: _controllerpesan,
                              itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: ListTile(
                                    title: Stack(children: <Widget>[
                                  GestureDetector(
                                      onTap: () async {
                                        setState(() async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          prefs.setString(
                                              "idberita",
                                              filteredItemskegiatancampanye[
                                                  index]["idb"]);
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                child: ListTile(
                                                  tileColor: whitePrimary,
                                                  leading: Image.network(
                                                    // widget.question.fileInfo[0].remoteURL,

                                                    filteredItemskegiatancampanye[
                                                        index]["brtft"],
                                                    width: 100,
                                                    height: 100,
                                                    //
                                                    loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) =>
                                                        (loadingProgress ==
                                                                null)
                                                            ? child
                                                            : CircularProgressIndicator(),
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      Future.delayed(
                                                        Duration(
                                                            milliseconds: 0),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .timer_outlined,
                                                            size: 17,
                                                          ),
                                                          Text(
                                                            filteredItemskegiatancampanye[
                                                                        index]
                                                                    ["brtdp"] +
                                                                " " +
                                                                filteredItemskegiatancampanye[
                                                                        index]
                                                                    ["brttp"],
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontSize: 9,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          filteredItemskegiatancampanye[
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
                                                                    filteredItemskegiatancampanye[index]
                                                                    [
                                                                    "idb"],filteredItemskegiatancampanye[index]
                                                                ["brtft"]);
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
                                                                dialogdeleteinfo(filteredItemskegiatancampanye[index]
                                                                [
                                                                "idb"],filteredItemskegiatancampanye[index]
                                                                ["brtft"]);
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
                                                                dialogdeleteinfo(filteredItemskegiatancampanye[index]["idb"],filteredItemskegiatancampanye[index]
                                                                ["brtft"]);
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
                                                        filteredItemskegiatancampanye[
                                                            index]["brtnm"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        //2 or more line you want
                                                        filteredItemskegiatancampanye[
                                                            index]["brtjdl"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  // subtitle: Text(
                                                  //   //2 or more line you want
                                                  //   // maxLines: 2,
                                                  //   _postspesan[index]["brtbrt"],
                                                  //
                                                  //   overflow: TextOverflow.ellipsis,
                                                  //   style: const TextStyle(
                                                  //       fontFamily: 'poppins',
                                                  //       color: textPrimary,
                                                  //       fontWeight: FontWeight.bold,
                                                  //       fontSize: 11),
                                                  // ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  // Visibility(
                                  //     visible: visiblehapuskegiatancampanye,
                                  //     child:
                                  // Align(
                                  //   alignment: Alignment.topRight,
                                  //   child: IconButton(
                                  //     onPressed: () {
                                  //       dialogdeleteinfo(
                                  //           filteredItemskegiatancampanye[index]
                                  //               ["idb"]);
                                  //     },
                                  //     icon: Icon(
                                  //       Icons.delete_outline,
                                  //       color: gradient6,
                                  //       size: 25,
                                  //     ),
                                  //   ),
                                  // ),
                                  // ),
                                ])

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
                              child:
                                  Text('You have fetched all of the content'),
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
                      'Total : ' +
                          CurrencyFormat.convertToIdr(
                              jumlahkegiatankampanye, 0),
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
          visible: visiblepesantambah,
          child: Align(
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
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("brtsts", "P");
                          prefs.remove('fotoimage');
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

  Widget datapesancaleg() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                // Set the onRefresh callback to the fetchData method
                onRefresh: _refreshList,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) => filterItempesancaleg(value),
                            decoration: InputDecoration(
                              labelText: 'Cari',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: visiblelistpesancaleg,
                            child:
                        SizedBox(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredItemspesancaleg.length,
                              controller: _controllerpesancaleg,
                              itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: ListTile(
                                    title: Stack(children: <Widget>[
                                  GestureDetector(
                                      onTap: () async {
                                        setState(() async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          prefs.setString(
                                              "idberita",
                                              filteredItemspesancaleg[index]
                                                  ["idb"]);
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                child: ListTile(
                                                  tileColor: whitePrimary,
                                                  leading: Image.network(
                                                    // widget.question.fileInfo[0].remoteURL,

                                                    filteredItemspesancaleg[
                                                        index]["brtft"],
                                                    width: 100,
                                                    height: 100,
                                                    //
                                                    loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) =>
                                                        (loadingProgress ==
                                                                null)
                                                            ? child
                                                            : CircularProgressIndicator(),
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      Future.delayed(
                                                        Duration(
                                                            milliseconds: 0),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .timer_outlined,
                                                            size: 17,
                                                          ),
                                                          Text(
                                                            filteredItemspesancaleg[
                                                                        index]
                                                                    ["brtdp"] +
                                                                " " +
                                                                filteredItemspesancaleg[
                                                                        index]
                                                                    ["brttp"],
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontSize: 9,
                                                                color: Colors
                                                                    .black),
                                                          ),

                                                          filteredItemspesancaleg[
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
                                                                    filteredItemspesancaleg[index]
                                                                    [
                                                                    "idb"],filteredItemspesancaleg[index]
                                                                ["brtft"]);
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
                                                                dialogdeleteinfo(filteredItemspesancaleg[index]
                                                                [
                                                                "idb"],filteredItemspesancaleg[index]
                                                                ["brtft"]);
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
                                                                dialogdeleteinfo(filteredItemspesancaleg[index]["idb"],filteredItemspesancaleg[index]
                                                                ["brtft"]);
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
                                                        filteredItemspesancaleg[
                                                            index]["brtnm"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        //2 or more line you want
                                                        filteredItemspesancaleg[
                                                            index]["brtjdl"],

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            color: textPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  // subtitle: Text(
                                                  //   //2 or more line you want
                                                  //   // maxLines: 2,
                                                  //   _postspesan[index]["brtbrt"],
                                                  //
                                                  //   overflow: TextOverflow.ellipsis,
                                                  //   style: const TextStyle(
                                                  //       fontFamily: 'poppins',
                                                  //       color: textPrimary,
                                                  //       fontWeight: FontWeight.bold,
                                                  //       fontSize: 11),
                                                  // ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  // Visibility(
                                  //     visible: visiblehapuspesancaleg,
                                  //     child:
                                  //     Align(
                                  //   alignment: Alignment.topRight,
                                  //   child: IconButton(
                                  //     onPressed: () {
                                  //       dialogdeleteinfo(
                                  //           filteredItemspesancaleg[index]
                                  //               ["idb"]);
                                  //     },
                                  //     icon: Icon(
                                  //       Icons.delete_outline,
                                  //       color: gradient6,
                                  //       size: 25,
                                  //     ),
                                  //   ),
                                  // ),
                                  // ),
                                ])

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
                              child:
                                  Text('You have fetched all of the content'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
        Visibility(
          visible: visibleerorpesancaleg,
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
                      'Total : ' +
                          CurrencyFormat.convertToIdr(jumlahpesancaleg, 0),
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
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("brtsts", "C");
                          prefs.remove('fotoimage');

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
          jumlahberita = jsonResponse['jumlahberita'];
          jumlahagenda = jsonResponse['jumlahagenda'];
          jumlahkegiatanrelawan = jsonResponse['jumlahactivityrelawan'];
          jumlahkegiatankampanye = jsonResponse['jumlahkampanye'];
          jumlahpesancaleg = jsonResponse['jumlahpesancaleg'];

        if(jsonResponse['jumlahberita']==0){

          setState(() {
            visibleerorberita = true;
            visiblelistberita = false;
          });



        }else{
          setState(() {
            visibleerorberita = false;
            visiblelistberita = true;
          });


        }

          if(jsonResponse['jumlahagenda']==0){
            setState(() {
              visibleeroragenda = true;
              visiblelistagenda = false;
            });


          }else{
            setState(() {
              visibleeroragenda = false;
              visiblelistagenda = true;
            });

          }

          if(jsonResponse['jumlahactivityrelawan']==0){
            setState(() {
              visibleeroractivity = true;
              visiblelistactivity = false;
            });


          }else{
            setState(() {
              visibleeroractivity = false;
              visiblelistactivity = true;
            });

          }

          if(jsonResponse['jumlahkampanye']==0){
            setState(() {
              visiblelistpesan = false;
              visibleerorpesan = true;
            });


          }else{
            setState(() {
              visiblelistpesan = true;
              visibleerorpesan = false;
            });


          }

          if(jsonResponse['jumlahpesancaleg']==0){
            setState(() {
              visiblelistpesancaleg = false;
              visibleerorpesancaleg = true;
            });


          }else{
            setState(() {

              visiblelistpesancaleg = true;
              visibleerorpesancaleg = false;
            });

          }


        });
      }
    }
  }

  void filterItemberita(String query) {
    setState(() {
      filteredItemberita = _postsberita
          .where((item) =>
              item['brtjdl'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterItemagenda(String query) {
    setState(() {
      filteredItemsagenda = _postsagenda
          .where((item) =>
              item['brtjdl'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterItemkegiatanrelawan(String query) {
    setState(() {
      filteredItemkegiatanrelawan = _postsactivity
          .where((item) =>
              item['brtjdl'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterItemkegiatancampanye(String query) {
    setState(() {
      filteredItemskegiatancampanye = _postspesan
          .where((item) =>
              item['brtjdl'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterItempesancaleg(String query) {
    setState(() {
      filteredItemspesancaleg = _postspesancaleg
          .where((item) =>
              item['brtjdl'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _loadMorberita() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controllerberita!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrlberita&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postsberita.addAll(fetchedPosts);
            filteredItemberita = _postsberita;
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

  void _firstLoberita() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrlberita&_page=$_page&_limit=$_limit"));
      setState(() {
        _postsberita = json.decode(res.body);
        filteredItemberita = _postsberita;
        // visibleerorberita = false;
        // visiblelistberita = true;
      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          //  visiblelistberita = false;
          //
          // visibleerorberita = true;
        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMoreagenda() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controllagenda!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrlagenda&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postsagenda.addAll(fetchedPosts);
            filteredItemsagenda = _postsagenda;
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

  void _firstLoadagenda() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrlagenda&_page=$_page&_limit=$_limit"));
      setState(() {
        _postsagenda = json.decode(res.body);
        filteredItemsagenda = _postsagenda;

        // visibleeroragenda = false;
        // visiblelistagenda = true;
      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          // visiblelistagenda = false;
          //
          // visibleeroragenda = true;
        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMoreactivity() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controlleractivity!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrlactivity&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postsactivity.addAll(fetchedPosts);
            filteredItemkegiatanrelawan = _postsactivity;
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

  void _firstLoadactivity() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrlactivity&_page=$_page&_limit=$_limit"));
      setState(() {
        _postsactivity = json.decode(res.body);
        // visibleerorpendukung = false;
        filteredItemkegiatanrelawan = _postsactivity;
        // visibleeroractivity = false;
        // visiblelistactivity = true;

      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          // visiblelistactivity = false;
          //
          // visibleeroractivity = true;
        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
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
            filteredItemskegiatancampanye = _postspesan;
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
        filteredItemskegiatancampanye = _postspesan;
        // visiblelistpesan = true;
        // visibleerorpesan = false;

      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          // visiblelistpesan = false;
          //
          // visibleerorpesan = true;
        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMorepesancaleg() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controllerpesancaleg!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrlpesancaleg&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postspesancaleg.addAll(fetchedPosts);
            filteredItemspesancaleg = _postspesancaleg;
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

  void _firstLoadpesancaleg() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrlpesancaleg&_page=$_page&_limit=$_limit"));
      setState(() {
        _postspesancaleg = json.decode(res.body);
        filteredItemspesancaleg = _postspesancaleg;
        // visiblelistpesancaleg = true;
        // visibleerorpesancaleg = false;

      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          // visiblelistpesancaleg = false;
          // visibleerorpesancaleg = true;
        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
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
      cektotinfo();
      _firstLoberita();
      _firstLoadagenda();
      _firstLoadactivity();
      _firstLoadpesan();
      _firstLoadpesancaleg();

      _controllerberita = ScrollController()..addListener(_loadMorberita);
      _controllagenda = ScrollController()..addListener(_loadMoreagenda);
      _controlleractivity = ScrollController()..addListener(_loadMoreactivity);
      _controllerpesan = ScrollController()..addListener(_loadMorepesan);
      _controllerpesancaleg = ScrollController()
        ..addListener(_loadMorepesancaleg);
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

  Future dialogdeleteinfo(String idb,String urlfoto) {
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
                          deletefoto(urlfoto);
                          Navigator.pop(context, false);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ));
  }

  deletefoto(String foto) async {

    Map data = {
      'dltft': foto,
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/postdlt.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {

      } else {

      }
    } else {}
  }
}
