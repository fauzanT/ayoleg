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

class Dapilpage extends StatefulWidget {
  const Dapilpage({Key? key}) : super(key: key);

  @override
  State<Dapilpage> createState() => _DapilpageState();
}

class _DapilpageState extends State<Dapilpage> {
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

  String nohpAkun = "";
  String nohprelawan = "";
  String namaAkun = "";
  String emailAkun = "";
  String genderAkun = "";
  String nikAkun = "";
  int jumlahpendukung = 0;
  String kodecaleg = "";
  String usrdpl = "";
  int totl = 0;
  int totp = 0;
  int totd = 0;

  // Future<List<Datapendukung>>? futurpendukung;

  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);

      usrdpl = prefs.getString('usrdpl')!;
      kodecaleg = prefs.getString('kodecaleg')!;

      _baseUrlpendukung =
          'http://aplikasiayocaleg.com/ayocalegapi/getdapil.php?usrkc=' +
              kodecaleg +
              '&usrdpl=' +
              usrdpl;
      cektotpendukung();
      _firstLoadpendukung();
      _controllerpendukung = ScrollController()
        ..addListener(_loadMorependukung);
      totl = prefs.getInt('totl')!;
      totp = prefs.getInt('totp')!;
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
        title: Text(
          'Dukungan ' + usrdpl,
          style:
          const TextStyle(
              fontFamily:
              'poppins',
              fontSize: 12,
              fontWeight:
              FontWeight
                  .bold,
              color: Colors
                  .white),
        ),
      ),
      body:Stack(
          children: <Widget>[

      _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :      SingleChildScrollView(

        child:
        Container(
          margin: const EdgeInsets.only(
              bottom: 70),
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

                child:
                SingleChildScrollView(
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
                                await SharedPreferences.getInstance();
                                prefs.setString('nohprelawan',
                                    filteredItemspendukung[index]["usrhp"]);

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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Container(
                                      child: ListTile(
                                          tileColor: whitePrimary,
                                          leading: Container(
                                            padding: EdgeInsets.only(
                                                bottom: 5, top: 5),
                                            child:  ClipOval(
                                              // borderRadius:
                                              // BorderRadius.circular(150),
                                              child: Image.network(

                                                filteredItemspendukung[index]
                                                    ['usrft'],
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                                //
                                                loadingBuilder: (context,
                                                    child,
                                                    loadingProgress) =>
                                                (loadingProgress == null)
                                                    ? child
                                                    : CircularProgressIndicator(),
                                                errorBuilder: (context, error,
                                                    stackTrace) {
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
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        // height: 100,
                                                        alignment:
                                                        Alignment.topLeft,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 0,
                                                            vertical: 7),
                                                        child: Text(
                                                          filteredItemspendukung[
                                                          index]['usrnm'],
                                                          style:
                                                          const TextStyle(
                                                              fontFamily:
                                                              'poppins',
                                                              fontSize: 14,
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
                                                        Alignment.topLeft,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                        child: Text(
                                                          filteredItemspendukung[
                                                          index]
                                                          ['umr'] +
                                                              " thn",
                                                          style: const TextStyle(
                                                              fontFamily:
                                                              'poppins',
                                                              fontSize: 9,
                                                              color:
                                                              greenPrimary),
                                                        ),
                                                      )
                                                    ]),
                                                // Container(
                                                //   // height: 100,
                                                //   alignment: Alignment.topLeft,
                                                //   margin: const EdgeInsets.symmetric(
                                                //       horizontal: 0, vertical: 2),
                                                //   child: Text(
                                                //     ' ${data[index].usrema!}',
                                                //     style: const TextStyle(
                                                //         fontFamily: 'poppins',
                                                //         fontSize: 10,
                                                //         color: Colors.grey),
                                                //   ),
                                                // ),

                                                Container(
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
                                                        fontSize: 10,
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
                                                        fontSize: 10,
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
                                                        10,
                                                        fontFamily:
                                                        'poppins',
                                                        color:
                                                        Colors.orange,
                                                      ),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    )
                                                        : Text(
                                                      "Calon Legislatif",
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        10,
                                                        fontFamily:
                                                        'poppins',
                                                        color:
                                                        Colors.orange,
                                                      ),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ))
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
                    child: Text('You have fetched all of the content'),
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

      ])

    );
  }

//   @override
//   Widget build(BuildContext context) {
//
//     return DefaultTabController(
//       length: 3,
//       child:
//       Stack(
//           children: <Widget>[
//       Scaffold(
//         appBar: AppBar(
//             backgroundColor: greenPrimary,
//             automaticallyImplyLeading: false,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   'Pendukung',
//                   style: TextStyle(fontFamily: 'poppins', color: whitePrimary),
//                 ),
//                 Container(
//                   width: 17,
//                 )
//               ],
//             )
//         ),
//         body: Column(
//           children: [datapendukung()],
//         ),
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.only(bottom: 30.0),
//           child:
//
//           Container(
//             padding: new EdgeInsets.fromLTRB(20, 0, 10, 30),
//             child: FadeInUp(
//               duration: Duration(milliseconds: 1300),
//               child:
//               Container(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: greenPrimary,
//                     onPrimary: whitePrimary,
//                     shadowColor: shadowColor,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     minimumSize: const Size(100, 40), //////// HERE
//                   ),
//                   onPressed: () {
//                     setState(() {});
//                   },
//                   child: Text(
//                     'Total : ' + CurrencyFormat.convertToIdr(jumlahpendukung, 0),
//                     style: TextStyle(
//                         fontFamily: 'poppins',
//                         color: whitePrimary,
//                         fontSize: 11,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           )
//
//
//         ),
//         // floatingActionButton: FloatingActionButton.extended(
//         //   extendedPadding: EdgeInsets.only(bottom: 50.0),
//         //   onPressed: () {},
//         //   icon: const Icon(Icons.add_business_outlined),
//         //   label: const Text(
//         //     'Tambah Berita',
//         //     style: const TextStyle(
//         //         fontFamily: 'poppins', fontSize: 9, color: Colors.black),
//         //   ),
//         //   backgroundColor: greenPrimary,
//         // ),
//       ),
//
//     // Align(
//     //     alignment: Alignment.bottomLeft,
//     //     child:
//     //     Container(
//     //       padding: new EdgeInsets.fromLTRB(20, 0, 10, 70),
//     //       child: FadeInUp(
//     //         duration: Duration(milliseconds: 1300),
//     //         child:
//     //         Container(
//     //           child: ElevatedButton(
//     //             style: ElevatedButton.styleFrom(
//     //               primary: greenPrimary,
//     //               onPrimary: whitePrimary,
//     //               shadowColor: shadowColor,
//     //               elevation: 3,
//     //               shape: RoundedRectangleBorder(
//     //                 borderRadius: BorderRadius.circular(20),
//     //               ),
//     //               minimumSize: const Size(100, 40), //////// HERE
//     //             ),
//     //             onPressed: () {
//     //               setState(() {});
//     //             },
//     //             child: Text(
//     //               'Total : ' + CurrencyFormat.convertToIdr(jumlahpendukung, 0),
//     //               style: TextStyle(
//     //                   fontFamily: 'poppins',
//     //                   color: whitePrimary,
//     //                   fontSize: 11,
//     //                   fontWeight: FontWeight.bold),
//     //             ),
//     //           ),
//     //         ),
//     //       ),
//     //     )
//     // ),
//
// ])
//     );
//   }
//
//
//   Widget datapendukung() {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     final size = MediaQuery.of(context).size;
//     return Stack(
//       children: <Widget>[
//         _isFirstLoadRunning
//             ? const Center(
//           child: CircularProgressIndicator(),
//         )
//             : Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _postspendukung.length,
//                 controller: _controllerpendukung,
//                 itemBuilder: (_, index) => Card(
//                   margin: const EdgeInsets.symmetric(
//                       vertical: 8, horizontal: 10),
//                   child: ListTile(
//                     title: GestureDetector(
//                         onTap: () async {
//                           setState(() async {
//                             SharedPreferences prefs =
//                             await SharedPreferences.getInstance();
//                             prefs.setString(
//                                 'nohprelawan', _postspendukung[index]["usrhp"]);
//
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                     const RelawanPendukungPage()));
//                             // Navigator.pop(context);
//                           });
//                         },
//                         child: Container(
//                           // margin:
//                           // EdgeInsets.only(left: 20, right: 20, top: 7),
//                           // // alignment: Alignment.centerLeft,
//                           // padding: const EdgeInsets.only(bottom: 0),
//                           // decoration: BoxDecoration(
//                           //   border: Border.all(color: shadowColor4),
//                           //   color: whitePrimary,
//                           //   borderRadius: BorderRadius.circular(15),
//                           //   boxShadow: const [
//                           //     // BoxShadow(
//                           //     //     blurRadius: 2,
//                           //     //     color: shadowColor,
//                           //     //     spreadRadius: 3)
//                           //   ],
//                           // ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Container(
//                               //   padding: EdgeInsets.only(left: 20, right: 20),
//                               //   child: Divider(
//                               //     thickness: 1,
//                               //   ),
//                               // ),
//                               InkWell(
//                                 child: Container(
//                                   child: ListTile(
//                                       tileColor: whitePrimary,
//                                       leading: Container(
//                                         padding: EdgeInsets.only(
//                                             bottom: 5, top: 5),
//                                         child: ClipRRect(
//                                           borderRadius:
//                                           BorderRadius.circular(10),
//                                           child: Image.network(
//                                             // widget.question.fileInfo[0].remoteURL,
//                                             _postspendukung[index]['usrft'],
//                                             width: 50,
//                                             height: 50,
//                                             //
//                                             loadingBuilder: (context,
//                                                 child,
//                                                 loadingProgress) =>
//                                             (loadingProgress == null)
//                                                 ? child
//                                                 : CircularProgressIndicator(),
//                                             errorBuilder: (context, error,
//                                                 stackTrace) {
//                                               Future.delayed(
//                                                 Duration(milliseconds: 0),
//                                                     () {
//                                                   if (mounted) {
//                                                     setState(() {
//                                                       CircularProgressIndicator();
//                                                     });
//                                                   }
//                                                 },
//                                               );
//                                               return SizedBox.shrink();
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                       title: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               // crossAxisAlignment: CrossAxisAlignment.center,
//                                               // mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Container(
//                                                     // height: 100,
//                                                     alignment:
//                                                     Alignment.topLeft,
//                                                     margin:
//                                                     const EdgeInsets
//                                                         .symmetric(
//                                                         horizontal: 0,
//                                                         vertical: 7),
//                                                     child: Text(
//                                                       _postspendukung[index]
//                                                       ['usrnm'],
//                                                       style: const TextStyle(
//                                                           fontFamily:
//                                                           'poppins',
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                           FontWeight
//                                                               .bold,
//                                                           color: Colors
//                                                               .black),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     // height: 100,
//                                                     alignment:
//                                                     Alignment.topLeft,
//                                                     margin:
//                                                     const EdgeInsets
//                                                         .symmetric(
//                                                         horizontal: 0,
//                                                         vertical: 0),
//                                                     child: Text(
//                                                       _postspendukung[index]
//                                                       ['umr'] +
//                                                           " thn",
//                                                       style: const TextStyle(
//                                                           fontFamily:
//                                                           'poppins',
//                                                           fontSize: 9,
//                                                           color:
//                                                           greenPrimary),
//                                                     ),
//                                                   )
//                                                 ]),
//                                             // Container(
//                                             //   // height: 100,
//                                             //   alignment: Alignment.topLeft,
//                                             //   margin: const EdgeInsets.symmetric(
//                                             //       horizontal: 0, vertical: 2),
//                                             //   child: Text(
//                                             //     ' ${data[index].usrema!}',
//                                             //     style: const TextStyle(
//                                             //         fontFamily: 'poppins',
//                                             //         fontSize: 10,
//                                             //         color: Colors.grey),
//                                             //   ),
//                                             // ),
//
//                                             Container(
//                                               // height: 100,
//                                               alignment:
//                                               Alignment.topLeft,
//                                               margin: const EdgeInsets
//                                                   .symmetric(
//                                                   horizontal: 0,
//                                                   vertical: 0),
//                                               child: Text(
//                                                 _postspendukung[index]
//                                                 ['usrdpl'],
//                                                 style: const TextStyle(
//                                                     fontFamily: 'poppins',
//                                                     fontSize: 12,
//                                                     color: Colors.blue),
//                                               ),
//                                             )
//                                           ])),
//                                 ),
//                               )
//                             ],
//                           ),
//                         )),
//
//                     // subtitle: Text(_posts[index]['body']),
//                   ),
//                 ),
//               ),
//             ),
//             if (_isLoadMoreRunning == true)
//               const Padding(
//                 padding: EdgeInsets.only(top: 10, bottom: 40),
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             if (_hasNextPage == false)
//               Container(
//                 padding: const EdgeInsets.only(top: 30, bottom: 40),
//                 color: Colors.amber,
//                 child: const Center(
//                   child: Text('You have fetched all of the content'),
//                 ),
//               ),
//           ],
//         ),
//         Visibility(
//           visible: visibleerorpendukung,
//           child: Center(
//             child: Container(
//               margin: EdgeInsets.only(top: size.height * 0.3),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/riwayatnon.png',
//                     scale: 3.5,
//                   ),
//                   SizedBox(height: 15),
//                   const Text(
//                     'Data Tidak Ada',
//                     style: TextStyle(
//                         fontFamily: 'poppins',
//                         color: greenPrimary,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//
//         // Align(
//         //     alignment: Alignment.bottomCenter,
//         //     child: Container(
//         //       padding: new EdgeInsets.fromLTRB(00, 0, 10, 70),
//         //       child: FadeInUp(
//         //         duration: Duration(milliseconds: 1300),
//         //         child: Container(
//         //           child: ElevatedButton(
//         //             style: ElevatedButton.styleFrom(
//         //               primary: greenPrimary,
//         //               onPrimary: whitePrimary,
//         //               shadowColor: shadowColor,
//         //               elevation: 3,
//         //               shape: RoundedRectangleBorder(
//         //                 borderRadius: BorderRadius.circular(20),
//         //               ),
//         //               minimumSize: const Size(100, 40), //////// HERE
//         //             ),
//         //             onPressed: () {
//         //               setState(() {});
//         //             },
//         //             child: Text(
//         //               'Total : ' + CurrencyFormat.convertToIdr(jumlahpendukung, 0),
//         //               style: TextStyle(
//         //                   fontFamily: 'poppins',
//         //                   color: whitePrimary,
//         //                   fontSize: 11,
//         //                   fontWeight: FontWeight.bold),
//         //             ),
//         //           ),
//         //         ),
//         //       ),
//         //     )),
//
//       ],
//     );
//
//   }

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
