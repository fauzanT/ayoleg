import 'dart:async';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/component/colors/colors.dart';
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

class UserBidangUtamapage extends StatefulWidget {
  const UserBidangUtamapage({Key? key}) : super(key: key);

  @override
  State<UserBidangUtamapage> createState() => _UserBidangUtamapageState();
}

class _UserBidangUtamapageState extends State<UserBidangUtamapage> {
  var _baseUrlpendukung = '';
  int _page = 0;
  final int _limit = 5;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  List _postspendukung = [];
  List filteredItemspendukung = [];

  ScrollController? _controllerpendukung;
  bool visibleerorpendukung = false;
  bool visibleerrordapil = false;

  String title = "";
  String pindah = "";
  String nohpAkun = "";
  String nohprelawan = "";
  String namaAkun = "";
  String emailAkun = "";
  String genderAkun = "";
  String nikAkun = "";
  int jumlahpendukung = 0;
  String kodecaleg = "";
  String usrbu = "";
  int totl = 0;
  int totp = 0;
  int totd = 0;

  // Future<List<Datapendukung>>? futurpendukung;

  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);

      usrbu = prefs.getString('usrbu')!;
      kodecaleg = prefs.getString('kodecaleg')!;
      pindah = prefs.getString('pindah')!;
      title = prefs.getString('title')!;

      if (pindah == "butama") {
        _baseUrlpendukung =
            'http://aplikasiayocaleg.com/ayocalegapi/getuserbidang.php?usrkc=' +
                kodecaleg +
                '&usrbu=' +
                usrbu;
      } else if (pindah == "caleg") {
        _baseUrlpendukung =
            'http://aplikasiayocaleg.com/ayocalegapi/getuserswing.php?usrkc=' +
                kodecaleg +
                '&usrvt=' +
                usrbu;
      } else if (pindah == "partai") {
        _baseUrlpendukung =
            'http://aplikasiayocaleg.com/ayocalegapi/getuserswing2.php?usrkc=' +
                kodecaleg +
                '&usrvt2=' +
                usrbu;
      }

      // cektotpendukung();
      _firstLoadpendukung();
      _controllerpendukung = ScrollController()
        ..addListener(_loadMorependukung);

      totl = prefs.getInt('totlusrbu')!;
      totp = prefs.getInt('totpusrbu')!;
      totd = totl + totp;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                  title,
                  style: TextStyle(fontFamily: 'poppins', color: whitePrimary),
                ),
                Container(
                  width: 17,
                )
              ],
            )),
        body: Stack(children: <Widget>[
          _isFirstLoadRunning
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) => filterItemspendukung(value),
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
                                              filteredItemspendukung[index]
                                                  ["usrhp"]);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RelawanPendukungPage()));
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
                                                    leading: Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5, top: 5),
                                                      child: ClipOval(
                                                        // borderRadius:
                                                        // BorderRadius.circular(150),
                                                        child: Image.network(
                                                          filteredItemspendukung[
                                                              index]['usrft'],
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.cover,
                                                          //
                                                          loadingBuilder: (context,
                                                                  child,
                                                                  loadingProgress) =>
                                                              (loadingProgress ==
                                                                      null)
                                                                  ? child
                                                                  : CircularProgressIndicator(),
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      0),
                                                              () {
                                                                if (mounted) {
                                                                  setState(() {
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
                                                      // ClipRRect(
                                                      //   borderRadius:
                                                      //   BorderRadius.circular(10),
                                                      //   child: Image.network(
                                                      //     // widget.question.fileInfo[0].remoteURL,
                                                      //     filteredItemspendukung[index]
                                                      //     ['usrft'],
                                                      //     width: 50,
                                                      //     height: 50,
                                                      //     //
                                                      //     loadingBuilder: (context, child,
                                                      //         loadingProgress) =>
                                                      //     (loadingProgress == null)
                                                      //         ? child
                                                      //         : CircularProgressIndicator(),
                                                      //     errorBuilder: (context, error,
                                                      //         stackTrace) {
                                                      //       Future.delayed(
                                                      //         Duration(milliseconds: 0),
                                                      //             () {
                                                      //           if (mounted) {
                                                      //             setState(() {
                                                      //               CircularProgressIndicator();
                                                      //             });
                                                      //           }
                                                      //         },
                                                      //       );
                                                      //       return SizedBox.shrink();
                                                      //     },
                                                      //   ),
                                                      // ),
                                                    ),
                                                    title: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              // mainAxisAlignment: MainAxisAlignment.center,
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
                                                                    filteredItemspendukung[index]
                                                                            [
                                                                            'umr'] +
                                                                        " thn",
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'poppins',
                                                                        fontSize:
                                                                            9,
                                                                        color:
                                                                            greenPrimary),
                                                                  ),
                                                                )
                                                              ]),
                                                          Container(
                                                            // height: 100,
                                                            alignment: Alignment
                                                                .topLeft,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        0,
                                                                    vertical:
                                                                        2),
                                                            child: Text(
                                                              filteredItemspendukung[
                                                                      index]
                                                                  ['usrdpl'],
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'poppins',
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),

                                                          // Container(
                                                          //   // height: 100,
                                                          //     alignment:
                                                          //     Alignment.topLeft,
                                                          //     margin: const EdgeInsets
                                                          //         .symmetric(
                                                          //         horizontal: 0,
                                                          //         vertical: 0),
                                                          //     child: filteredItemspendukung[
                                                          //     index]
                                                          //     ['usrsts'] ==
                                                          //         "A"
                                                          //         ? Text(
                                                          //       "Admin",
                                                          //       style: TextStyle(
                                                          //         fontSize: 10,
                                                          //         fontFamily:
                                                          //         'poppins',
                                                          //         color:
                                                          //         Colors.orange,
                                                          //       ),
                                                          //       overflow:
                                                          //       TextOverflow
                                                          //           .ellipsis,
                                                          //     )
                                                          //         : filteredItemspendukung[
                                                          //     index][
                                                          //     'usrsts'] ==
                                                          //         "R"
                                                          //         ? Text(
                                                          //       "Relawan",
                                                          //       style:
                                                          //       TextStyle(
                                                          //         fontSize: 10,
                                                          //         fontFamily:
                                                          //         'poppins',
                                                          //         color: Colors
                                                          //             .orange,
                                                          //       ),
                                                          //       overflow:
                                                          //       TextOverflow
                                                          //           .ellipsis,
                                                          //     )
                                                          //         : filteredItemspendukung[
                                                          //     index]
                                                          //     [
                                                          //     'usrsts'] ==
                                                          //         "P"
                                                          //         ? Text(
                                                          //       "Pendukung",
                                                          //       style:
                                                          //       TextStyle(
                                                          //         fontSize:
                                                          //         10,
                                                          //         fontFamily:
                                                          //         'poppins',
                                                          //         color: Colors
                                                          //             .orange,
                                                          //       ),
                                                          //       overflow:
                                                          //       TextOverflow
                                                          //           .ellipsis,
                                                          //     )
                                                          //         : filteredItemspendukung[index]
                                                          //     [
                                                          //     'usrsts'] ==
                                                          //         "S"
                                                          //         ? Text(
                                                          //       "Saksi",
                                                          //       style:
                                                          //       TextStyle(
                                                          //         fontSize:
                                                          //         10,
                                                          //         fontFamily:
                                                          //         'poppins',
                                                          //         color:
                                                          //         Colors.orange,
                                                          //       ),
                                                          //       overflow:
                                                          //       TextOverflow.ellipsis,
                                                          //     )
                                                          //         : Text(
                                                          //       "Calon Legislatif",
                                                          //       style:
                                                          //       TextStyle(
                                                          //         fontSize:
                                                          //         10,
                                                          //         fontFamily:
                                                          //         'poppins',
                                                          //         color:
                                                          //         Colors.orange,
                                                          //       ),
                                                          //       overflow:
                                                          //       TextOverflow.ellipsis,
                                                          //     ))
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
          Visibility(
            visible: visibleerrordapil,
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
                        'Total : ' + CurrencyFormat.convertToIdr(totd, 0),
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
        ]));
  }

  cektotpendukung() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    String nohprelawann = prefs.getString('nohprelawancaleg')!;
    Map data = {
      'usrkc': kodecaleg,
      'usrhpr': nohprelawann,
      'usrhp': nohprelawann,
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmlpendukung.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          jumlahpendukung = jsonResponse['jumlahpendukung'];
        });
      }
    }
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
        visibleerrordapil = false;
      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          visibleerrordapil = true;
        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }
}
