import 'dart:async';
import 'dart:io';

// import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/berita/agenda.dart';
import 'package:ayoleg/berita/pesandetail.dart';
import 'package:ayoleg/berita/tambahberita.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PesanPEndukungpage extends StatefulWidget {
  const PesanPEndukungpage({Key? key}) : super(key: key);

  @override
  State<PesanPEndukungpage> createState() => _PesanPEndukungpageState();
}

class _PesanPEndukungpageState extends State<PesanPEndukungpage> {
  Future<List<Databerita>>? futureberita;
  Future<List<Databeritaagenda>>? futureagenda;
  Future<List<Databerita>>? futureactivity;
  Future<List<Databerita>>? futurepesan;
  late Timer _timerForInter;
  File? imageFile;
  String kodecaleg = "";
  String usrsts = "";
  bool visiagendatambah = false;

  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      kodecaleg = prefs.getString('kodecaleg')!;

      futureberita = fetchGetDataberita(kodecaleg,"B");
      futureagenda = fetchGetDataberitaagenda(kodecaleg,"A");
      futureactivity = fetchGetDataberita(kodecaleg,"C");

      futurepesan = fetchGetDataberita(kodecaleg,"P");
      // nohpAkun = prefs.getString('nohpregister')!;
      // fetchDatainbox(nohpAkun);
      usrsts = prefs.getString('usrsts')!;

      if(usrsts=="R") {
        visiagendatambah = true;
      }else{
        visiagendatambah = false;
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
        length: 4,
        child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: greenPrimary,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  labelStyle: TextStyle(fontFamily: 'poppins'),
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text(
                        "Berita / Pesan",
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Agenda",
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),

                    Tab(
                      child: Text(
                        "Kegiatan Relawan",
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),

                    Tab(
                      child: Text(
                        "Kegiatan Kampanye",
                        style: const TextStyle(
                          fontSize: 10,
                        ),
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
              datapesan()
            ]),
          ),
        ));
  }

  Widget databerita() {

    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          // height: 200,
          // width: 200,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child:
              FutureBuilder<List<Databerita>>(
                future: futureberita,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Databerita>? data = snapshot.data;
                    return
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () async {
                                setState(() async {
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                                  prefs.setString("idberita", data![index].idb);
                                  // prefs.setString('nohprelawan', data[index].usrhp!);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const PesanDetailpage()));
                                  // Navigator.pop(context);
                                });
                              },
                              child:
                              Container(
                                margin:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                                // alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(bottom: 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: whitePrimary,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //     blurRadius: 2,
                                    //     color: shadowColor,
                                    //     spreadRadius: 3)
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   padding: EdgeInsets.only(left: 20, right: 20),
                                    //   child: Divider(
                                    //     thickness: 1,
                                    //   ),
                                    // ),
                                    InkWell(
                                      child: Container(
                                        child: ListTile(
                                          tileColor: whitePrimary,
                                          leading: Image.network(
                                            // widget.question.fileInfo[0].remoteURL,
                                            data![index].brtft,
                                            width: 100,
                                            height: 100,
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
                                          // Image.network(
                                          //   data![index].brtft,
                                          //   frameBuilder:
                                          //   ((context, child, frame, wasSynchronouslyLoaded) {
                                          //     if (wasSynchronouslyLoaded) return child;
                                          //     return AnimatedSwitcher(
                                          //       duration: const Duration(milliseconds: 0),
                                          //       child: frame != null
                                          //           ? child
                                          //           : SizedBox(
                                          //         height: 20,
                                          //         width: 20,
                                          //         child: CircularProgressIndicator(
                                          //             strokeWidth: 2),
                                          //       ),
                                          //     );
                                          //   }),
                                          // ),
                                          // (data?[index].brtft != null)
                                          //     ? CachedNetworkImage(
                                          //   imageUrl:   data![index].brtft,
                                          //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          //       CircularProgressIndicator(value: downloadProgress.progress),
                                          //   errorWidget: (context, url, error) => Icon(Icons.error),
                                          // )
                                          // // Image.network(
                                          // //         data![index].brtft,
                                          // //         height: 80,
                                          // //         width: 80,
                                          // //         fit: BoxFit.cover,
                                          // //       )
                                          //     : Container(
                                          //         width: 20,
                                          //         height: 20,
                                          //         child: CircularProgressIndicator()),
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
                                                    data![index].brtdp +
                                                        " " +
                                                        data[index].brttp,
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                //2 or more line you want

                                                data[index].brtjdl,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          // subtitle: Column(
                                          //   crossAxisAlignment:
                                          //   CrossAxisAlignment.start,
                                          //   children: [
                                          //     Padding(
                                          //         padding: EdgeInsets.fromLTRB(
                                          //             3, 3, 3, 0)),
                                          //     Container(
                                          //       // margin:
                                          //       //     EdgeInsets.only(left: 22, top: 7),
                                          //       // width: 12,
                                          //       // height: 12,
                                          //       child: Text(
                                          //         maxLines: 2,
                                          //         data[index].brtbrt,
                                          //         overflow: TextOverflow.ellipsis,
                                          //         style: const TextStyle(
                                          //             fontFamily: 'poppins',
                                          //             color: textPrimary,
                                          //             // fontWeight: FontWeight.bold,
                                          //             fontSize: 12),
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        });
                  } else if (snapshot.hasError) {
                    return Center(
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
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
        ),
        // Align(
        //     alignment: Alignment.bottomRight,
        //     child: Container(
        //       padding: new EdgeInsets.fromLTRB(00, 0, 10, 70),
        //       child: FadeInUp(
        //         duration: Duration(milliseconds: 1300),
        //         child: Container(
        //           child: ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               primary: greenPrimary,
        //               onPrimary: whitePrimary,
        //               shadowColor: shadowColor,
        //               elevation: 3,
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(20),
        //               ),
        //               minimumSize: const Size(100, 40), //////// HERE
        //             ),
        //             onPressed: () {
        //               setState(() async {
        //                 SharedPreferences prefs = await SharedPreferences.getInstance();
        //                 prefs.setString("brtsts", "B");
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) =>
        //                         const Tambahnewspage()));
        //               });
        //             },
        //             child: Icon(
        //               Icons.add_card,
        //               color: Colors.white,
        //             ),
        //           ),
        //         ),
        //       ),
        //     )),
      ],
    );
  }
  Widget dataagenda() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          // height: 200,
          // width: 200,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: FutureBuilder<List<Databeritaagenda>>(
                future: futureagenda,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Databeritaagenda>? data = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () async {
                                setState(() async {
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                                  prefs.setString("idberita", data![index].idb);
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
                                margin:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                                // alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(bottom: 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: whitePrimary,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //     blurRadius: 2,
                                    //     color: shadowColor,
                                    //     spreadRadius: 3)
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   padding: EdgeInsets.only(left: 20, right: 20),
                                    //   child: Divider(
                                    //     thickness: 1,
                                    //   ),
                                    // ),
                                    InkWell(
                                      child: Container(
                                        child: ListTile(
                                          tileColor: whitePrimary,
                                          leading: Image.network(
                                            // widget.question.fileInfo[0].remoteURL,
                                            data![index].brtft,
                                            width: 100,
                                            height: 100,
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
                                                    data![index].brtdp +
                                                        " " +
                                                        data[index].brttp,
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                //2 or more line you want

                                                data[index].brtnm,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                //2 or more line you want

                                                data[index].brtjdl,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      3, 3, 3, 0)),
                                              Container(
                                                // margin:
                                                //     EdgeInsets.only(left: 22, top: 7),
                                                // width: 12,
                                                // height: 12,
                                                child: Text(
                                                  maxLines: 2,
                                                  data[index].brtbrt,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'poppins',
                                                      color: textPrimary,
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer_outlined,
                                                    size: 17,
                                                  ),
                                                  Text(
                                                    "WAKTU Agenda "+data![index].tmagd +
                                                        " " +
                                                        data[index].dtagd,
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                  ),
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
                              ));
                        });
                  } else if (snapshot.hasError) {
                    return Center(
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
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )),

    // Visibility(
    // visible: visiagendatambah,
    // child:
    //     Align(
    //         alignment: Alignment.bottomRight,
    //         child: Container(
    //           padding: new EdgeInsets.fromLTRB(00, 0, 10, 70),
    //           child: FadeInUp(
    //             duration: Duration(milliseconds: 1300),
    //             child: Container(
    //               child: ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                   primary: greenPrimary,
    //                   onPrimary: whitePrimary,
    //                   shadowColor: shadowColor,
    //                   elevation: 3,
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                   minimumSize: const Size(100, 40), //////// HERE
    //                 ),
    //                 onPressed: () {
    //                   setState(() async {
    //                     SharedPreferences prefs = await SharedPreferences.getInstance();
    //                     prefs.setString("brtsts", "D");
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) =>
    //                             const Tambahagendapage()));
    //                   });
    //                 },
    //                 child: Icon(
    //                   Icons.add_card,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         )),
    // ),
      ],
    );
  }

  Widget dataactivitas() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          // height: 200,
          // width: 200,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: FutureBuilder<List<Databerita>>(
                future: futureactivity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Databerita>? data = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () async {
                                setState(() async {
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                                  prefs.setString("idberita", data![index].idb);
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
                                margin:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                                // alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(bottom: 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: whitePrimary,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //     blurRadius: 2,
                                    //     color: shadowColor,
                                    //     spreadRadius: 3)
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   padding: EdgeInsets.only(left: 20, right: 20),
                                    //   child: Divider(
                                    //     thickness: 1,
                                    //   ),
                                    // ),
                                    InkWell(
                                      child: Container(
                                        child: ListTile(
                                          tileColor: whitePrimary,
                                          leading: Image.network(
                                            // widget.question.fileInfo[0].remoteURL,
                                            data![index].brtft,
                                            width: 100,
                                            height: 100,
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
                                          // Image.network(
                                          //   data![index].brtft,
                                          //   frameBuilder:
                                          //   ((context, child, frame, wasSynchronouslyLoaded) {
                                          //     if (wasSynchronouslyLoaded) return child;
                                          //     return AnimatedSwitcher(
                                          //       duration: const Duration(milliseconds: 0),
                                          //       child: frame != null
                                          //           ? child
                                          //           : SizedBox(
                                          //         height: 20,
                                          //         width: 20,
                                          //         child: CircularProgressIndicator(
                                          //             strokeWidth: 2),
                                          //       ),
                                          //     );
                                          //   }),
                                          // ),
                                          // (data?[index].brtft != null)
                                          //     ? CachedNetworkImage(
                                          //   imageUrl:   data![index].brtft,
                                          //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          //       CircularProgressIndicator(value: downloadProgress.progress),
                                          //   errorWidget: (context, url, error) => Icon(Icons.error),
                                          // )
                                          // // Image.network(
                                          // //         data![index].brtft,
                                          // //         height: 80,
                                          // //         width: 80,
                                          // //         fit: BoxFit.cover,
                                          // //       )
                                          //     : Container(
                                          //         width: 20,
                                          //         height: 20,
                                          //         child: CircularProgressIndicator()),
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
                                                    data![index].brtdp +
                                                        " " +
                                                        data[index].brttp,
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                //2 or more line you want

                                                data[index].brtnm,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                //2 or more line you want

                                                data[index].brtjdl,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      3, 3, 3, 0)),
                                              Container(
                                                // margin:
                                                //     EdgeInsets.only(left: 22, top: 7),
                                                // width: 12,
                                                // height: 12,
                                                child: Text(
                                                  maxLines: 2,
                                                  data[index].brtbrt,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'poppins',
                                                      color: textPrimary,
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        });
                  } else if (snapshot.hasError) {
                    return Center(
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
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )),
    Visibility(
    visible: visiagendatambah,
    child:
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
                      setState(() async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setString("brtsts", "D");
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
        Container(
          // height: 200,
          // width: 200,
            child:

            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: FutureBuilder<List<Databerita>>(
                future: futurepesan,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Databerita>? data = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () async {
                                setState(() async {
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                                  prefs.setString("idberita", data![index].idb);
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
                                margin:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                                // alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(bottom: 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: whitePrimary,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //     blurRadius: 2,
                                    //     color: shadowColor,
                                    //     spreadRadius: 3)
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   padding: EdgeInsets.only(left: 20, right: 20),
                                    //   child: Divider(
                                    //     thickness: 1,
                                    //   ),
                                    // ),
                                    InkWell(
                                      child: Container(
                                        child: ListTile(
                                          tileColor: whitePrimary,
                                          leading: Image.network(
                                            // widget.question.fileInfo[0].remoteURL,
                                            data![index].brtft,
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
                                          // Image.network(
                                          //   data![index].brtft,
                                          //   frameBuilder:
                                          //   ((context, child, frame, wasSynchronouslyLoaded) {
                                          //     if (wasSynchronouslyLoaded) return child;
                                          //     return AnimatedSwitcher(
                                          //       duration: const Duration(milliseconds: 0),
                                          //       child: frame != null
                                          //           ? child
                                          //           : SizedBox(
                                          //         height: 20,
                                          //         width: 20,
                                          //         child: CircularProgressIndicator(
                                          //             strokeWidth: 2),
                                          //       ),
                                          //     );
                                          //   }),
                                          // ),
                                          // (data?[index].brtft != null)
                                          //     ? CachedNetworkImage(
                                          //   imageUrl:   data![index].brtft,
                                          //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          //       CircularProgressIndicator(value: downloadProgress.progress),
                                          //   errorWidget: (context, url, error) => Icon(Icons.error),
                                          // )
                                          // // Image.network(
                                          // //         data![index].brtft,
                                          // //         height: 80,
                                          // //         width: 80,
                                          // //         fit: BoxFit.cover,
                                          // //       )
                                          //     : Container(
                                          //         width: 20,
                                          //         height: 20,
                                          //         child: CircularProgressIndicator()),
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
                                                    data![index].brtdp +
                                                        " " +
                                                        data[index].brttp,
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                //2 or more line you want

                                                data[index].brtjdl,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      3, 3, 3, 0)),
                                              Container(
                                                // margin:
                                                //     EdgeInsets.only(left: 22, top: 7),
                                                // width: 12,
                                                // height: 12,
                                                child: Text(
                                                  maxLines: 2,
                                                  data[index].brtbrt,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'poppins',
                                                      color: textPrimary,
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        });
                  } else if (snapshot.hasError) {
                    return Center(
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
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )

        ),
        // Align(
        //     alignment: Alignment.bottomRight,
        //     child: Container(
        //       padding: new EdgeInsets.fromLTRB(00, 0, 10, 70),
        //       child: FadeInUp(
        //         duration: Duration(milliseconds: 1300),
        //         child: Container(
        //           child: ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               primary: greenPrimary,
        //               onPrimary: whitePrimary,
        //               shadowColor: shadowColor,
        //               elevation: 3,
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(20),
        //               ),
        //               minimumSize: const Size(100, 40), //////// HERE
        //             ),
        //             onPressed: () {
        //               setState(() async {
        //                 SharedPreferences prefs = await SharedPreferences.getInstance();
        //                 prefs.setString("brtsts", "P");
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) =>
        //                         const Tambahnewspage()));
        //               });
        //             },
        //             child: Icon(
        //               Icons.add_card,
        //               color: Colors.white,
        //             ),
        //           ),
        //         ),
        //       ),
        //     )),
      ],
    );
  }

// getgalery() async {
//   // ignore: deprecated_member_use
//   PickedFile? pickedFile = await ImagePicker().getImage(
//     source: ImageSource.gallery,
//     maxWidth: 1800,
//     maxHeight: 1800,
//   );
//   if (pickedFile != null) {
//     setState(() {
//       imageFile = File(pickedFile.path);
//     });
//   }
// }
}
