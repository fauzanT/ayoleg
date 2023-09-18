import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/keuangan/keuangandetail.dart';
import 'package:ayoleg/keuangan/tambahkeuangan.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Keuanganpage extends StatefulWidget {
  const Keuanganpage({Key? key}) : super(key: key);

  @override
  State<Keuanganpage> createState() => _KeuanganpageState();
}

class _KeuanganpageState extends State<Keuanganpage> {


  var _baseUrldonasi = '';
  var _baseUrlpengeluaran = '';

  int _page = 0;
  final int _limit = 5;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  List _postsdonasi = [];
  List _postspengeluaran = [];

  List filteredItemdonasi = [];
  List filteredItemspengeluaran = [];

  ScrollController? _controllerdonasi;
  ScrollController? _controllpengeluaran;


  late Timer _timerForInter;
  File? imageFile;
  String kodecaleg = "";
  bool visibleerordonasi = false;
  bool visibleerorpengeluaran = false;
  bool visibleerorpesan = false;
  bool visibleeroractivity = false;
  bool visibledonasitambah = false;
  bool visiblepengeluarantambah = false;
  bool visibleactivitytambah = false;
  bool visiblepesantambah = false;
  bool visiblelistpengeluaran = false;
  bool visiblelistdonasi = false;

  String jumlahdonasi = "0";
  String jumlahpengeluaran = "0";
  String nohpAkun = "";

  int jumlahtotdonasi = 0;
  int jumlahtotpengeluaran = 0;

  late SharedPreferences sharedPrefs;
  String usrsts = "";

  @override
  void initState() {

    cektotkeuangan();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      nohpAkun = prefs.getString('nohpregister')!;
      prefs.remove(
          "idkeuangan");
      kodecaleg = prefs.getString('kodecaleg')!;
      usrsts = prefs.getString('usrsts')!;
      _baseUrldonasi =
          'http://aplikasiayocaleg.com/ayocalegapi/getkeuangan.php?keukc=' +
              kodecaleg +
              "&keusts=D";
      _baseUrlpengeluaran =
          'http://aplikasiayocaleg.com/ayocalegapi/getkeuangan.php?keukc=' +
              kodecaleg +
              "&keusts=P";


      _firstLodonasi();
      _firstLopengeluaran();


      _controllerdonasi = ScrollController()..addListener(_loadMoredonasi);
      _controllpengeluaran = ScrollController()..addListener(_loadMorepengeluaran);


      if(usrsts=="A") {
        visibledonasitambah = true;
        visiblepengeluarantambah = true;

      }else if(usrsts=="C") {
        visibledonasitambah = true;
        visiblepengeluarantambah = true;


      }else{
        visibledonasitambah = true;
        visiblepengeluarantambah = false;

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
        length: 2,
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
                        "Donasi",
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Pengeluaran",
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),

                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'Keuangan',
                      style:
                      TextStyle(fontFamily: 'poppins', color: whitePrimary),
                    ),
                    Container(
                      width: 17,
                    )
                  ],
                )),
            body: TabBarView(children: [
              datadonasi(),
              datapengeluaran(),

            ]),
          ),
        ));
  }

  Widget datadonasi() {
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
            margin: const EdgeInsets.only(
                bottom: 70),
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => filterItemdonasii(value),
                    decoration: InputDecoration(
                      labelText: 'Cari Nama',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Visibility(
                    visible: visiblelistdonasi,
                    child:
                SizedBox(

                  child:
                  SingleChildScrollView(

                    child:
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItemdonasi.length,
                      controller: _controllerdonasi,
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
                                      "idkeuangan", filteredItemdonasi[index]["idk"]);
                                  // prefs.setString('nohprelawan', data[index].usrhp!);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const KeuanganDetailpage()));
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

                                            filteredItemdonasi[index]["keuft"],
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
                                                    filteredItemdonasi[index]
                                                    ["keudp"] +
                                                        " " +
                                                        filteredItemdonasi[index]
                                                        ["keutp"],
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                  ),

                                                  filteredItemdonasi[
                                                  index]
                                                  [
                                                  "keuhp"] ==
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
                                                            filteredItemdonasi[index]
                                                            [
                                                            "idk"],filteredItemdonasi[index]["keuft"]);
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
                                                        dialogdeleteinfo(filteredItemdonasi[index]
                                                        [
                                                        "idk"],filteredItemdonasi[index]["keuft"]);
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
                                                        dialogdeleteinfo(filteredItemdonasi[index]["idk"],filteredItemdonasi[index]["keuft"]);
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
                                               filteredItemdonasi[index]["keunma"],
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                              "Rp " +CurrencyFormat.convertToIdr(int.parse(filteredItemdonasi[index]["keuamt"]), 0),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: gradient6,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Donasi Oleh : "+filteredItemdonasi[index]["keunm"],
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    color: greyPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(

                                                filteredItemdonasi[index]["keudsc"],
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
        Visibility(
          visible: visibleerordonasi,
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
                      setState(() {});
                    },
                    child: Text(
                      'Total Donasi : ' + CurrencyFormat.convertToIdr(int.parse(jumlahdonasi), 0),
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
          visible: visibledonasitambah,
          child:
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: new EdgeInsets.fromLTRB(00, 0, 10, 170),
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
                        setState(() async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.setString("keust", "D");
                          prefs.remove('fotoimage');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TambahKeuanganpage()));
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
                      'Total : ' + CurrencyFormat.convertToIdr(jumlahtotdonasi, 0),
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

  Widget datapengeluaran() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    return
      Stack(
        children: <Widget>[
          _isFirstLoadRunning
              ? const Center(
            child: CircularProgressIndicator(),
          )
              :   RefreshIndicator(
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
                      onChanged: (value) => filterItempengeluarann(value),
                      decoration: InputDecoration(
                        labelText: 'Cari Nama',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: visiblelistpengeluaran,
                      child:
                      SizedBox(

                    child:
                    SingleChildScrollView(

                      child:
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredItemspengeluaran.length,
                        controller: _controllpengeluaran,
                        itemBuilder: (_, index) => Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          child:
                          ListTile(
                            title:
                            GestureDetector(
                                onTap: () async {
                                  setState(() async {
                                    SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                    prefs.setString(
                                        "idkeuangan", filteredItemspengeluaran[index]["idk"]);
                                    // prefs.setString('nohprelawan', data[index].usrhp!);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const KeuanganDetailpage()));
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

                                              filteredItemspengeluaran[index]["keuft"],
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
                                                      filteredItemspengeluaran[index]
                                                      ["keudp"] +
                                                          " " +
                                                          filteredItemspengeluaran[index]
                                                          ["keutp"],
                                                      style: const TextStyle(
                                                          fontFamily: 'poppins',
                                                          fontSize: 9,
                                                          color: Colors.black),
                                                    ),
                                                    IconButton(
                                                      onPressed:
                                                          () {
                                                        dialogdeleteinfo(filteredItemspengeluaran[index]
                                                        [
                                                        "idk"],filteredItemspengeluaran[index]["keuft"]);
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
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(

                                                  filteredItemspengeluaran[index]["keunma"],

                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'poppins',
                                                      color: textPrimary,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  CurrencyFormat.convertToIdr(int.parse(filteredItemspengeluaran[index]["keuamt"]), 0),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'poppins',
                                                      color: gradient6,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  filteredItemspengeluaran[index]["keudsc"],
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
            visible: visibleerorpengeluaran,
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
                        setState(() {});
                      },
                      child: Text(
                        'Total Pengeluaran : ' + CurrencyFormat.convertToIdr(int.parse(jumlahpengeluaran), 0),
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
            visible: visiblepengeluarantambah,
            child:
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: new EdgeInsets.fromLTRB(00, 0, 10, 170),
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
                            prefs.setString("keust", "P");
                            prefs.remove('fotoimage');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const TambahKeuanganpage()));
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
                        'Total : ' + CurrencyFormat.convertToIdr(jumlahtotpengeluaran, 0),
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


  cektotkeuangan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;

    Map data = {'keukc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmltotdonasi.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {



          if(jsonResponse['donasi']['sum'] == null){
            jumlahdonasi = "0";
            visibleerordonasi = true;
            visiblelistdonasi = false;
          }else{
            jumlahdonasi = jsonResponse['donasi']['sum'];

            visibleerordonasi = false;
            visiblelistdonasi = true;
          }
          if( jsonResponse['keuangan']['sum'] == null){
            jumlahpengeluaran = "0";
            visiblelistpengeluaran = false;
            visibleerorpengeluaran = true;
          }else{
            jumlahpengeluaran = jsonResponse['keuangan']['sum'];
            visiblelistpengeluaran = true;
            visibleerorpengeluaran = false;

          }
          jumlahtotdonasi = jsonResponse['jumlahdonasi'];
          jumlahtotpengeluaran = jsonResponse['jumlahpengeluaran'];

        });
      }
    }
  }

  void filterItemdonasii(String query) {
    setState(() {
      filteredItemdonasi = _postsdonasi
          .where((item) => item['keunma'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterItempengeluarann(String query) {
    setState(() {
      filteredItemspengeluaran = _postspengeluaran
          .where((item) => item['keunma'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _loadMoredonasi() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controllerdonasi!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrldonasi&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postsdonasi.addAll(fetchedPosts);
            filteredItemdonasi = _postsdonasi;
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

  void _firstLodonasi() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrldonasi&_page=$_page&_limit=$_limit"));
      setState(() {
        _postsdonasi = json.decode(res.body);
        filteredItemdonasi = _postsdonasi;
        // visibleerordonasi = false;
        // visiblelistdonasi = true;

      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {
          jumlahtotdonasi = 0;
          jumlahdonasi = "0";

          // visiblelistdonasi = false;
          // visibleerordonasi = true;

        });
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMorepengeluaran() async {
    final size = MediaQuery.of(context).size;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controllpengeluaran!.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http
            .get(Uri.parse("$_baseUrlpengeluaran&_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _postspengeluaran.addAll(fetchedPosts);
            filteredItemspengeluaran = _postspengeluaran;
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

  void _firstLopengeluaran() async {
    final size = MediaQuery.of(context).size;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http
          .get(Uri.parse("$_baseUrlpengeluaran&_page=$_page&_limit=$_limit"));
      setState(() {
        _postspengeluaran = json.decode(res.body);
        filteredItemspengeluaran = _postspengeluaran;
        // visibleerorpengeluaran = false;
        // visiblelistpengeluaran = true;

      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {

          jumlahtotpengeluaran = 0;
          jumlahpengeluaran = "0";
          // visiblelistpengeluaran = false;
          // visibleerorpengeluaran = true;


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
      cektotkeuangan();
      _firstLodonasi();
      _firstLopengeluaran();
      _controllerdonasi = ScrollController()..addListener(_loadMoredonasi);
      _controllpengeluaran = ScrollController()..addListener(_loadMorepengeluaran);

    });
    // print("Refresh Pressed");
    // return null;


  }

  deleteinfo(String idk) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {
      'idk': idk,
      'stsact': "N",
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/updatestskeu.php"),
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

  Future dialogdeleteinfo(String idk,String urlfoto) {
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
                      deleteinfo(idk);
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
