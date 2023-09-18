import 'dart:async';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:ayoleg/team/relawan.dart';
import 'package:ayoleg/team/relawanpendukung.dart';
import 'package:ayoleg/team/tambahpendukung.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Saranpage extends StatefulWidget {
  const Saranpage({Key? key}) : super(key: key);

  @override
  State<Saranpage> createState() => _SaranpageState();
}

class _SaranpageState extends State<Saranpage> {
  var _baseUrlpendukung = '';
  int _page = 0;
  final int _limit = 5;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  List _postspendukung = [];
  List filteredItemspendukung = [];
  bool visiblependukung = false;
  bool visiblesaran = false;
  bool visiblelistsaran = false;

  ScrollController? _controllerpendukung;

  String nohpAkun = "";
  String nohprelawan = "";
  String namaAkun = "";
  String emailAkun = "";
  String genderAkun = "";
  String nikAkun = "";
  int jumlahpendukung = 0;
  String kodecaleg = "";
  int totalsaran = 0;

  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    cektotdukugan();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      // nohprelawan = prefs.getString('nohprelawancaleg')!;
      kodecaleg = prefs.getString('kodecaleg')!;
      _baseUrlpendukung =
          'http://aplikasiayocaleg.com/ayocalegapi/getsaran.php?usrkc=' +
              "GEL00";

      _firstLoadpendukung();
      _controllerpendukung = ScrollController()
        ..addListener(_loadMorependukung);
    });

    super.initState();
  }

  Future<void> onBackPressed() async {
    setState(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const CustomNavBar();
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
            title: const Text(
              'Saran Untuk Caleg',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Stack(
            children: <Widget>[
              _isFirstLoadRunning
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Visibility(
                      visible: visiblelistsaran,
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 70),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  onChanged: (value) =>
                                      filterItemspendukung(value),
                                  decoration: InputDecoration(
                                    labelText: 'Cari',
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: filteredItemspendukung.length,
                                    controller: _controllerpendukung,
                                    itemBuilder: (_, index) => Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      child: ListTile(
                                        title: GestureDetector(
                                            onTap: () async {
                                              setState(() async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setString(
                                                    'nohprelawan',
                                                    filteredItemspendukung[
                                                        index]['usrhp']);
                                                prefs.setString(
                                                    'nohprelawancaleg', "");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const RelawanPage()));
                                                // Navigator.pop(context);
                                              });
                                              // setState(() async {
                                              //   // SharedPreferences prefs =
                                              //   // await SharedPreferences.getInstance();
                                              //   // prefs.setString(
                                              //   //     'nohprelawan', filteredItemspendukung[index]["usrhp"]);
                                              //   //
                                              //   // Navigator.push(
                                              //   //     context,
                                              //   //     MaterialPageRoute(
                                              //   //         builder: (context) =>
                                              //   //         const RelawanPendukungPage()));
                                              //   // Navigator.pop(context);
                                              //
                                              //   dialogsaran(filteredItemspendukung[index]['usrhrc'],filteredItemspendukung[index]['usrnm']);
                                              // });
                                            },
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      child: ListTile(
                                                          tileColor:
                                                              whitePrimary,
                                                          leading: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 5,
                                                                    top: 5),
                                                            child: ClipOval(
                                                              // borderRadius:
                                                              //     BorderRadius.circular(150),
                                                              child:
                                                                  Image.network(
                                                                // widget.question.fileInfo[0].remoteURL,
                                                                    filteredItemspendukung[
                                                                        index]
                                                                    ['usrft'],
                                                                width: 50,
                                                                height: 50,
                                                                fit: BoxFit
                                                                    .cover,
                                                                //
                                                                loadingBuilder: (context,
                                                                        child,
                                                                        loadingProgress) =>
                                                                    (loadingProgress ==
                                                                            null)
                                                                        ? child
                                                                        : CircularProgressIndicator(),
                                                                errorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  Future
                                                                      .delayed(
                                                                    Duration(
                                                                        milliseconds:
                                                                            0),
                                                                    () {
                                                                      if (mounted) {
                                                                        setState(
                                                                            () {
                                                                          CircularProgressIndicator();
                                                                        });
                                                                      }
                                                                    },
                                                                  );
                                                                  return SizedBox
                                                                      .shrink();
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          title: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  // height: 100,
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  margin: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          0,
                                                                      vertical:
                                                                          7),
                                                                  child: Text(
                                                                    filteredItemspendukung[
                                                                            index]
                                                                        [
                                                                        'usrnm'],
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'poppins',
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    padding:
                                                                    EdgeInsets.only(
                                                                        bottom: 5),
                                                                  // height: 100,
                                                                    alignment:
                                                                    Alignment.topLeft,
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 0,
                                                                        vertical: 0),
                                                                    child: filteredItemspendukung[
                                                                    index]
                                                                    ['usrsts'] ==
                                                                        "A"
                                                                        ? Text(
                                                                      "Admin",
                                                                      style: TextStyle(
                                                                        fontSize: 12,
                                                                        fontFamily:
                                                                        'poppins',
                                                                        color:
                                                                        Colors.orange,
                                                                      ),
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                    )
                                                                        : filteredItemspendukung[
                                                                    index][
                                                                    'usrsts'] ==
                                                                        "R"
                                                                        ? Text(
                                                                      "Relawan",
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize: 12,
                                                                        fontFamily:
                                                                        'poppins',
                                                                        color: Colors
                                                                            .orange,
                                                                      ),
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                    )
                                                                        : filteredItemspendukung[
                                                                    index]
                                                                    [
                                                                    'usrsts'] ==
                                                                        "P"
                                                                        ? Text(
                                                                      "Pendukung",
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        10,
                                                                        fontFamily:
                                                                        'poppins',
                                                                        color: Colors
                                                                            .orange,
                                                                      ),
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                    )
                                                                        : filteredItemspendukung[index]
                                                                    [
                                                                    'usrsts'] ==
                                                                        "S"
                                                                        ? Text(
                                                                      "Saksi",
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        12,
                                                                        fontFamily:
                                                                        'poppins',
                                                                        color:
                                                                        Colors.orange,
                                                                      ),
                                                                      overflow:
                                                                      TextOverflow.ellipsis,
                                                                    )
                                                                        : Text(
                                                                      " ",
                                                                    )),
                                                                Container(
                                                                  // height: 100,
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  margin: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          0,
                                                                      vertical:
                                                                          0),
                                                                  child: Text(
                                                                    filteredItemspendukung[
                                                                            index]
                                                                        [
                                                                        'usrdpl'],
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'poppins',
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .blue),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  // height: 100,
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  margin: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          0,
                                                                      vertical:
                                                                          7),
                                                                  child: Text(
                                                                    filteredItemspendukung[
                                                                            index]
                                                                        [
                                                                        'usrhrc'],
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'poppins',
                                                                        fontSize:
                                                                            11,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                              ])),
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
                              if (_isLoadMoreRunning == true)
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 40),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              if (_hasNextPage == false)
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 40),
                                  color: Colors.amber,
                                  child: const Center(
                                    child: Text(
                                        'You have fetched all of the content'),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
              Visibility(
                visible: visiblesaran,
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
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
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
                  'Total : ' + CurrencyFormat.convertToIdr(totalsaran, 0),
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: whitePrimary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ));
  }

  dialogsaran(String Sarann, String nama) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                children: [
                  Text(
                    nama + ": ",
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Text(
                    Sarann,
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context, false);
                    });
                  },
                ),
              ],
            ));
  }

  void filterItemspendukung(String query) {
    setState(() {
      filteredItemspendukung = _postspendukung
          .where((item) =>
              item['usrnm'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _loadMorependukung() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controllerpendukung!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrlpendukung&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postspendukung.addAll(fetchedPosts);
            filteredItemspendukung = _postspendukung;
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

  void _firstLoadpendukung() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrlpendukung&_page=$_page&_limit=$_limit"));
      setState(() {
        _postspendukung = json.decode(res.body);
        filteredItemspendukung = _postspendukung;
        visiblependukung = false;
      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          visiblependukung = true;
        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  cektotdukugan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'usrkc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmltotdukungan.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          if (jsonResponse['jumlahdukungantotal'] == 0) {
            totalsaran = jsonResponse['jumlahdukungantotal'];
            visiblesaran = true;
            visiblelistsaran = false;
          } else {
            int total = jsonResponse['jumlahdukungantotal'];
            totalsaran = total - 1;
            visiblesaran = false;
            visiblelistsaran = true;
          }
        });
      }
    }
  }
}
