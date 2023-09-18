import 'dart:async';
import 'dart:convert';

// import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/account.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:ayoleg/team/relawan.dart';
import 'package:ayoleg/team/saksi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class Teampage extends StatefulWidget {
  const Teampage({Key? key}) : super(key: key);

  @override
  State<Teampage> createState() => _TeampageState();
}

class _TeampageState extends State<Teampage> {
  var _baseUrladmin = '';
  var _baseUrlpendukung = '';
  var _baseUrlrelawan = '';
  var _baseUrlsaksi = '';
  int _page = 0;
  final int _limit = 5;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  List _postsadmin = [];
  List _postsrelawan = [];
  List _postspendukung = [];
  List _postssaksi = [];
  ScrollController? _controlleradmin;
  ScrollController? _controllrelawan;
  ScrollController? _controllerpendukung;
  ScrollController? _controllresaksi;

  List filteredItemsadmin = [];
  List filteredItemsrelawan = [];
  List filteredItemspendukung = [];
  List filteredItemssaksi = [];

  //versi new

  late Timer _timerForInter;

  String nohpAkun = "";
  String kodecaleg = "";
  String namaAkun = "";
  String emailAkun = "";
  String genderAkun = "";

  int jumlahadmin = 0;
  int jumlahrelawan = 0;
  int jumlahpendukung = 0;
  int jumlahsaksi = 0;
  bool visibleerorrelawan = false;
  bool visibleerroradmin = false;
  bool visibleerorpendukung = false;
  bool visibleerorsaksi = false;

  bool visiblelistadmin = false;
  bool visiblelistrelawan = false;
  bool visiblelistpendukung = false;
  bool visiblelistsaksi = false;


  String nikAkun = "";

  // late Future<List<Datainbox>> futureDataInbox;
  // late Future<List<Datariwayat>> futureRiwayat;

  // late Future<List<DataTransaksi>> futureDataTransaksi;

  late TabController _tabController;

  // Future<List<Datarelawan>>? futurrelawan;
  // Future<List<Datarelawan>>? futurependukung;
  // Future<List<Datarelawan>>? futuresaksi;
  // Future<List<Datarelawan>>? futureadmin;

  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    cektotteam();

    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      kodecaleg = prefs.getString('kodecaleg')!;

      // futureadmin = fetchGetDataRelawan(kodecaleg, "A");
      // futurrelawan = fetchGetDataRelawan(kodecaleg, "R");
      // futurependukung = fetchGetDataRelawan(kodecaleg, "P");
      // futuresaksi = fetchGetDataRelawan(kodecaleg, "S");
      _baseUrladmin =
          'http://aplikasiayocaleg.com/ayocalegapi/getrelawan1.php?usrkc=' +
              kodecaleg +
              "&usrsts=" +
              "A";
      _baseUrlpendukung =
          'http://aplikasiayocaleg.com/ayocalegapi/getrelawan1.php?usrkc=' +
              kodecaleg +
              "&usrsts=" +
              "P";
      _baseUrlrelawan =
          'http://aplikasiayocaleg.com/ayocalegapi/getrelawan1.php?usrkc=' +
              kodecaleg +
              "&usrsts=" +
              "R";
      _baseUrlsaksi =
          'http://aplikasiayocaleg.com/ayocalegapi/getrelawan1.php?usrkc=' +
              kodecaleg +
              "&usrsts=" +
              "S";

      _firstLoadadmin();
      _firstLoadrelawan();
      _firstLoadpendukung();
      _firstLoadsaksi();

      _controlleradmin = ScrollController()..addListener(_loadMoreadmin);
      _controllrelawan = ScrollController()..addListener(_loadMorerelawan);
      _controlleradmin = ScrollController()..addListener(_loadMorependukung);
      _controllrelawan = ScrollController()..addListener(_loadMoresaksi);
    });

    super.initState();
  }

  Future<void> pullDown() async {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      nohpAkun = prefs.getString('nohpregister')!;
      // fetchDatainbox(nohpAkun);
      // fetchDataRiwayat(nohpAkun);
    });
  }

  @override
  void didChangeDependencies() {
    // fetchDatainbox(nohpAkun);
    // fetchDataRiwayat(nohpAkun);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timerForInter.cancel();
    _tabController.dispose();
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
                bottom: TabBar(
                  labelStyle: TextStyle(fontFamily: 'poppins'),
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text(
                        "Admin",
                        style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Relawan",
                        style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Pendukung",
                        style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Saksi",
                        style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white
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
                      'Team',
                      style:
                          TextStyle(fontFamily: 'poppins', color: whitePrimary),
                    ),
                    Container(
                      width: 17,
                    )
                  ],
                )),
            body: TabBarView(children: [
              dataadmin(),
              datarelawan(),
              datapendukung(),
              datasaksi()
            ]),
          ),
        ));
  }

  Widget dataadmin() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return
      Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) => filterItemsadmin(value),
                      decoration: InputDecoration(
                        labelText: 'Cari',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: visiblelistadmin,
                      child:
               SingleChildScrollView(
                    child:  ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItemsadmin.length,
                      controller: _controlleradmin,
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
                                      filteredItemsadmin[index]['usrhp']);
                                  prefs.setString('nohprelawancaleg', "");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RelawanPage()));
                                  // Navigator.pop(context);
                                });
                              },
                              child: Container(
                                // margin:
                                // EdgeInsets.only(left: 20, right: 20, top: 7),
                                // // alignment: Alignment.centerLeft,
                                // padding: const EdgeInsets.only(bottom: 0),
                                // decoration: BoxDecoration(
                                //   border: Border.all(color: shadowColor4),
                                //   color: whitePrimary,
                                //   borderRadius: BorderRadius.circular(15),
                                //   boxShadow: const [
                                //     // BoxShadow(
                                //     //     blurRadius: 2,
                                //     //     color: shadowColor,
                                //     //     spreadRadius: 3)
                                //   ],
                                // ),
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
                                      child:
                                      Container(
                                        child: ListTile(
                                            tileColor: whitePrimary,
                                            leading:
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 5, top: 5),
                                              child:
                                              ClipOval(

                                                // borderRadius:
                                                //     BorderRadius.circular(150),
                                                child: Image.network(
                                                  // widget.question.fileInfo[0].remoteURL,
                                                  filteredItemsadmin[index]['usrft'],
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
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 0,
                                                                  vertical: 7),
                                                          child: Text(
                                                            filteredItemsadmin[index]
                                                                ['usrnm'],
                                                            style: const TextStyle(
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
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 0,
                                                                  vertical: 0),
                                                          child: Text(
                                                            filteredItemsadmin[index]
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
                                                    child: Text(
                                                      filteredItemsadmin[index]
                                                          ['usrdpl'],
                                                      style: const TextStyle(
                                                          fontFamily: 'poppins',
                                                          fontSize: 12,
                                                          color: Colors.blue),
                                                    ),
                                                  )
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
        Visibility(
          visible: visibleerroradmin,
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
                  child:
                  ElevatedButton(
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
                      'Total : ' + CurrencyFormat.convertToIdr(jumlahadmin, 0),
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
      ],
    );
  }

  Widget datarelawan() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) => filterItemsrelawan(value),
                      decoration: InputDecoration(
                        labelText: 'Cari',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: visiblelistrelawan,
                      child:
                  SingleChildScrollView(
                    child:  ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItemsrelawan.length,
                      controller: _controllrelawan,
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
                                      filteredItemsrelawan[index]['usrhp']!);
                                  prefs.setString('nohprelawancaleg',
                                      filteredItemsrelawan[index]['usrhp']!);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RelawanPage()));
                                  // Navigator.pop(context);
                                });
                              },
                              child: Container(
                                // margin:
                                // EdgeInsets.only(left: 20, right: 20, top: 7),
                                // // alignment: Alignment.centerLeft,
                                // padding: const EdgeInsets.only(bottom: 0),
                                // decoration: BoxDecoration(
                                //   border: Border.all(color: shadowColor4),
                                //   color: whitePrimary,
                                //   borderRadius: BorderRadius.circular(15),
                                //   boxShadow: const [
                                //     // BoxShadow(
                                //     //     blurRadius: 2,
                                //     //     color: shadowColor,
                                //     //     spreadRadius: 3)
                                //   ],
                                // ),
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
                                            leading: Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 5, top: 5),
                                              child: ClipOval(
                                                // borderRadius:
                                                //     BorderRadius.circular(150),
                                                child: Image.network(
                                                  // widget.question.fileInfo[0].remoteURL,
                                                  filteredItemsrelawan[index]['usrft'],
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
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 0,
                                                                  vertical: 7),
                                                          child: Text(
                                                            filteredItemsrelawan[index]
                                                                ['usrnm'],
                                                            style: const TextStyle(
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
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 0,
                                                                  vertical: 0),
                                                          child: Text(
                                                            filteredItemsrelawan[index]
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
                                                    child: Text(
                                                      filteredItemsrelawan[index]
                                                          ['usrdpl'],
                                                      style: const TextStyle(
                                                          fontFamily: 'poppins',
                                                          fontSize: 12,
                                                          color: Colors.blue),
                                                    ),
                                                  )
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
        Visibility(
          visible: visibleerorrelawan,
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
                          CurrencyFormat.convertToIdr(jumlahrelawan, 0),
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
      ],
    );
  }

  Widget datapendukung() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return
      Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                  Visibility(
                      visible: visiblelistpendukung,
                      child:
                  SingleChildScrollView(
                    child:  ListView.builder(
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
                                  prefs.setString(
                                      'nohprelawan', filteredItemspendukung[index]["usrhp"]);
                                  prefs.setString('nohprelawancalegpendukung',
                                      filteredItemspendukung[index]["usrhpr"]);
                                  prefs.setString('nohprelawancaleg', "");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const RelawanPage()));
                                  // Navigator.pop(context);
                                });
                              },
                              child: Container(
                                // margin:
                                // EdgeInsets.only(left: 20, right: 20, top: 7),
                                // // alignment: Alignment.centerLeft,
                                // padding: const EdgeInsets.only(bottom: 0),
                                // decoration: BoxDecoration(
                                //   border: Border.all(color: shadowColor4),
                                //   color: whitePrimary,
                                //   borderRadius: BorderRadius.circular(15),
                                //   boxShadow: const [
                                //     // BoxShadow(
                                //     //     blurRadius: 2,
                                //     //     color: shadowColor,
                                //     //     spreadRadius: 3)
                                //   ],
                                // ),
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
                                            leading: Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 5, top: 5),
                                              child:  ClipOval(
                                                // borderRadius:
                                                //     BorderRadius.circular(150),
                                                child: Image.network(
                                                  // widget.question.fileInfo[0].remoteURL,
                                                  filteredItemspendukung[index]['usrft'],
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
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 0,
                                                                  vertical: 7),
                                                          child: Text(
                                                            filteredItemspendukung[index]
                                                                ['usrnm'],
                                                            style: const TextStyle(
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
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 0,
                                                                  vertical: 0),
                                                          child: Text(
                                                            filteredItemspendukung[index]
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
                                                    child: Text(
                                                      filteredItemspendukung[index]
                                                          ['usrdpl'],
                                                      style: const TextStyle(
                                                          fontFamily: 'poppins',
                                                          fontSize: 12,
                                                          color: Colors.blue),
                                                    ),
                                                  )
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
        Visibility(
          visible: visibleerorpendukung,
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
                          CurrencyFormat.convertToIdr(jumlahpendukung, 0),
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
      ],
    );
  }

  Widget datasaksi() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _isFirstLoadRunning
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => filterItemssaksi(value),
                decoration: InputDecoration(
                  labelText: 'Cari',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Visibility(
                visible: visiblelistsaksi,
                child:
            SingleChildScrollView(
              child:  ListView.builder(
                shrinkWrap: true,
                itemCount: filteredItemssaksi.length,
                controller: _controllresaksi,
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
                                'nohprelawan', filteredItemssaksi[index]["usrhp"]);
                            prefs.setString(
                                'nohprelawansaksi',  filteredItemssaksi[index]["usrhp"]);
                            prefs.setString('nohprelawancaleg', "");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const RelawanPage()));
                            // Navigator.pop(context);
                          });
                        },
                        child: Container(
                          // margin:
                          // EdgeInsets.only(left: 20, right: 20, top: 7),
                          // // alignment: Alignment.centerLeft,
                          // padding: const EdgeInsets.only(bottom: 0),
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: shadowColor4),
                          //   color: whitePrimary,
                          //   borderRadius: BorderRadius.circular(15),
                          //   boxShadow: const [
                          //     // BoxShadow(
                          //     //     blurRadius: 2,
                          //     //     color: shadowColor,
                          //     //     spreadRadius: 3)
                          //   ],
                          // ),
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
                                      leading: Container(
                                        padding: EdgeInsets.only(
                                            bottom: 5, top: 5),
                                        child: ClipOval(
                                          // borderRadius:
                                          // BorderRadius.circular(150),
                                          child: Image.network(
                                            // widget.question.fileInfo[0].remoteURL,
                                            filteredItemssaksi[index]['usrft'],
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
                                                    margin:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 0,
                                                        vertical: 7),
                                                    child: Text(
                                                      filteredItemssaksi[index]
                                                      ['usrnm'],
                                                      style: const TextStyle(
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
                                                    margin:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 0,
                                                        vertical: 0),
                                                    child: Text(
                                                      filteredItemssaksi[index]
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
                                              child: Text(
                                                filteredItemssaksi[index]
                                                ['usrdpl'],
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    color: Colors.blue),
                                              ),
                                            )
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
        Visibility(
          visible: visibleerorsaksi,
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
                      'Total : ' + CurrencyFormat.convertToIdr(jumlahsaksi, 0),
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
      ],
    );
  }

  cektotteam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;

    Map data = {'usrkc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmlteam.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          jumlahadmin = jsonResponse['jumlahadmin'];
          jumlahrelawan = jsonResponse['jumlahrelawan'];
          jumlahpendukung = jsonResponse['jumlahpendukung'];
          jumlahsaksi = jsonResponse['jumlahsaksi'];

          if(jsonResponse['jumlahadmin']!=0){
            setState(() {
              visiblelistadmin = true;
              visibleerroradmin = false;
            });

          }else{
            setState(() {
              visiblelistadmin = false;
              visibleerroradmin = true;
            });

          }
          if(jsonResponse['jumlahrelawan']!=0){
            setState(() {
              visiblelistrelawan = true;
              visibleerorrelawan = false;
            });

          }else{
            setState(() {
              visiblelistrelawan = false;
              visibleerorrelawan = true;
            });

          }
          if(jsonResponse['jumlahpendukung']!=0){
            setState(() {
              visiblelistpendukung = true;
              visibleerorpendukung = false;
            });

          }else{
            setState(() {
              visiblelistpendukung = false;
              visibleerorpendukung = true;
            });

          }
          if(jsonResponse['jumlahsaksi']!=0){
            setState(() {
              visiblelistsaksi = true;
              visibleerorsaksi = false;
            });

          }else{
            setState(() {
              visiblelistsaksi = false;
              visibleerorsaksi = true;
            });

          }

        });
      }
    }
  }
  void filterItemsadmin(String query) {
    setState(() {
      filteredItemsadmin = _postsadmin
          .where((item) => item['usrnm'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void filterItemsrelawan(String query) {
    setState(() {
      filteredItemsrelawan = _postsrelawan
          .where((item) => item['usrnm'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void filterItemspendukung(String query) {
    setState(() {
      filteredItemspendukung = _postspendukung
          .where((item) => item['usrnm'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void filterItemssaksi(String query) {
    setState(() {
      filteredItemssaksi = _postssaksi
          .where((item) => item['usrnm'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  void _loadMoreadmin() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controlleradmin!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrladmin&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postsadmin.addAll(fetchedPosts);
            filteredItemsadmin = _postsadmin;
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

  void _firstLoadadmin() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrladmin&_page=$_page&_limit=$_limit"));
      setState(() {
        _postsadmin = json.decode(res.body);
        filteredItemsadmin = _postsadmin;
        // visibleerroradmin = false;
      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          // visibleerroradmin = true;
        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMorerelawan() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controllrelawan!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrlrelawan&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postsrelawan.addAll(fetchedPosts);
            filteredItemsrelawan = _postsrelawan;
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

  void _firstLoadrelawan() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrlrelawan&_page=$_page&_limit=$_limit"));
      setState(() {
        _postsrelawan = json.decode(res.body);
        filteredItemsrelawan = _postsrelawan;
        // visibleerorrelawan = false;
      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          // visibleerorrelawan = true;

        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  //
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
        // visibleerorpendukung = false;
      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          // visibleerorpendukung = true;

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
        _controllresaksi!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrlsaksi&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postssaksi.addAll(fetchedPosts);
            filteredItemssaksi = _postssaksi;
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
          .get(Uri.parse("$_baseUrlsaksi&_page=$_page&_limit=$_limit"));
      setState(() {
        _postssaksi = json.decode(res.body);
        filteredItemssaksi = _postssaksi;
        // visibleerorsaksi = false;
      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          // visibleerorsaksi = true;

        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }
}
