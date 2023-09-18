// import 'dart:async';
// import 'dart:convert';

import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/team/bidangutama.dart';
import 'package:ayoleg/team/dukungankeluar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:ayoleg/team/dapil.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatistikPage extends StatefulWidget {
  const StatistikPage({Key? key}) : super(key: key);

  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  Future<List<Datadaerahpemilihan>>? futuredaerahpemilihan;

  // List<ChartData>? chartData;
  late SharedPreferences sharedPrefs;
  bool isAppbarCollapsing = false;

  var ctime;

  String nohpAkun = "";
  String fotoAkun = "";
  String namaAkun = "";
  String calonlegislatif = "";
  String daerahpemilihan = "";
  String akunverifikasi = "";
  String kodecaleg = "";
  String usrsts = "";
  String Statusreferal = "";

  String statusFoto = "";
  String calonlegis = "";
  int saldoUserr = 0;
  String trans = "";
  String fotocaleg = "";
  String namacaleg = "";
  String usrtkccaleg = "";
  String kodeadmin = "";
  String koderelawan = "";
  String kodesaksi = "";
  String targetsuara = "";
  String targetrelawan = "";
  String targetpendukung = "";
  String jumlahkursi = "";

  String totdpldpt = "";
  String totdpltps = "";
  String totl = "";
  String totp = "";
  String totd = "";
  String Dukungan = "";
  String Relawan = "";
  String Pendukung = "";

  String visicaleg = "";
  String misicaleg = "";

  double totrelawancewek = 0;
  double totrelawanpria = 0;

  double totpendukungcewek = 0;
  double totpendukungpria = 0;

  int totalgenderpendukung = 0;
  int totaltargetpendukung = 0;

  int pindahcaleglaki = 0;
  int tidakpindahcaleglaki = 0;
  int pindahcalegcewek = 0;
  int tidakpindahcalegcewek = 0;

  int pindahpartailaki = 0;
  int tidakpindahpartailaki = 0;
  int pindahpartaicewek = 0;
  int tidakpindahpartaicewek = 0;

  int totalgenderrelawan = 0;
  int totaltargetrelawan = 0;
  int totpendukung = 0;
  int relawancewek = 0;
  int relawanpria = 0;
  int pendukungcewek = 0;
  int pendukungpria = 0;

  int dukungancewek = 0;
  int dukunganpria = 0;
  double tdc = 0;
  double percendukungancewek = 0;
  double tdp = 0;
  double percendukunganpria = 0;

  int totalgenderdukungan = 0;
  int totaltargetdukungan = 0;

  int totalgenderpindahcaleg = 0;
  int totalgendertidakpindahcaleg = 0;
  int totalgenderlaki = 0;
  int totalgendercewek = 0;
  int totalgenderpindahpartai = 0;
  int totalgendertidakpindahpartai = 0;
  int totaltotal = 0;

  int jumlahkesehatanlaki = 0;
  int jumlahkesehatancewek = 0;
  int jumlahpendidikanlaki = 0;
  int jumlahpendidikancewek = 0;
  int jumlahmodalumkmlaki = 0;
  int jumlahmodalumkmcewek = 0;
  int jumlahekonomilaki = 0;
  int jumlahekonomicewek = 0;
  int jumlahfasilitaslaki = 0;
  int jumlahfasilitascewek = 0;
  int jumlahsesuaiktplaki = 0;
  int jumlahsesuaiktpcewek = 0;
  int jumlahtidaksesuailaki = 0;
  int jumlahtidaksesuaicewek = 0;

  int totkesehatan = 0;
  int totpendidikan = 0;
  int totmodalumkm = 0;
  int totekonomilaki = 0;
  int totfasilitaslaki = 0;

  int totsesuaiktplaki = 0;
  int tottidaksesuailaki = 0;

  int jumlahOrganisasilaki = 0;
  int jumlahOrganisasicewek = 0;

  int jumlahKomunikasilaki = 0;
  int jumlahKomunikasicewek = 0;

  int jumlahHukumlaki = 0;
  int jumlahHukumcewek = 0;

  int jumlahSosiallaki = 0;
  int jumlahSosialcewek = 0;

  int jumlahLogistiklaki = 0;
  int jumlahLogistikcewek = 0;

  int jumlahkeuanganlaki = 0;
  int jumlahkeuangancewek = 0;

  int totOrganisasi = 0;
  int totKomunikasi = 0;
  int totHukum = 0;
  int totSosial = 0;
  int totLogistik = 0;
  int totkeuangan = 0;
  int jumlahtidakaktiflaki = 0;
  int jumlahtidakaktifcewek = 0;
  int jumlahaktiflaki = 0;
  int jumlahaktifcewek = 0;
  int tottidakaktif = 0;
  int totaktif = 0;
  int dukungankeluar = 0;



  String? srasrc;

  @override
  void initState() {
    setState(() {

      cektotdatasuaraY();
      cektotaktifasi();
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);

        targetsuara = prefs.getString('targetsuara')!;
        targetrelawan = prefs.getString('targetrelawan')!;
        targetpendukung = prefs.getString('targetpendukung')!;
        prefs.remove('pindah')!;

        kodecaleg = prefs.getString('kodecaleg')!;
        cektotdukugan(kodecaleg);
        cektotdaerahpemilihan();
        cektotswingvoter();
        cektotbidangutama();
        cektotbidangutamarelawan();

        futuredaerahpemilihan = fetchGetDatadaerahpemilihan(kodecaleg);

        // jumlahkursi = prefs.getString('jumlahkursi')!;
        // chartData = [
        //   ChartData('T.Suara', double.parse(targetsuara),
        //       Color.fromRGBO(9, 0, 136, 1)),
        //   ChartData('T.Relawan', double.parse(targetrelawan),
        //       Color.fromRGBO(147, 0, 119, 1)),
        //   ChartData('T.Pendukung', double.parse(targetpendukung),
        //       Color.fromRGBO(228, 0, 124, 1)),
        //   // ChartData('JUmlah Kursi', jumlahkursi as double, Color.fromARGB(255, 59, 19, 41)),
        //   // ChartData('MI', 52, Color.fromARGB(255, 223, 215, 67)),
        //   // ChartData('Redmi', 12, Color.fromARGB(255, 7, 170, 118)),
        //   // ChartData('Others', 32, Color.fromARGB(255, 96, 3, 54)),
        // ];

        // fotoAkun = prefs.getString('fotoregister')!;
        // namaAkun = prefs.getString('namaregister')!;
        // nohpAkun = prefs.getString('nohpregister')!;
        // calonlegis = prefs.getString('calonlegis')!;
        // usrsts = prefs.getString('status')!;
        // fotocaleg = prefs.getString('fotocaleg')!;
        // namacaleg = prefs.getString('namacaleg')!;
        // usrtkccaleg = prefs.getString('usrtkccaleg')!;
        // daerahpemilihan = prefs.getString('daerahpemilihan')!;
        // kodeadmin = prefs.getString('kodeadmin')!;
        // koderelawan = prefs.getString('koderelawan')!;
        // kodesaksi = prefs.getString('kodesaksi')!;
        // visicaleg = prefs.getString('visicaleg')!;
        // misicaleg = prefs.getString('misicaleg')!;

        // cekdatarelawancewek(kodecaleg);
        // cekdatarelawanpria(kodecaleg);
        // cekdatapendukungcewek(kodecaleg);
        // cekdatapendukungpria(kodecaleg);

        // cekdatapendukungcewek(kodecaleg);
        // cekdatapendukungpria(kodecaleg);
        // cekdatapendukungtotal(kodecaleg);
        // totrelawancewek = "";
        // relawancewek = 0;
        // cekkodecaleg(kodecaleg);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                      'Data',
                      style:
                          TextStyle(fontFamily: 'poppins', color: whitePrimary),
                    ),
                    Container(
                      width: 17,
                    )
                  ],
                )),
            body: Center(
              child: Container(
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //         begin: Alignment.topRight,
                  //         end: Alignment.bottomLeft,
                  //         stops: [
                  //       0.2,
                  //       0.5,
                  //       0.8,
                  //     ],
                  //         colors: [
                  //       gradient1,
                  //       gradient2,
                  //       gradient3,
                  //     ])),
                  child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    datatargerrelawan(),

                    SizedBox(
                      height: 20,
                    ),
                    datatablerelawan(),

                    SizedBox(
                      height: 10,
                    ),
                    datatablependukung(),

                    SizedBox(
                      height: 10,
                    ),
                    datatabledukungan(),
                    SizedBox(
                      height: 10,
                    ),

                    datadaerahpemilihan(),
                    SizedBox(
                      height: 10,
                    ),
                    Barcartdaerahpemilihan(),
                    // circularChart(),
                    SizedBox(
                      height: 20,
                    ),
                    Piecartdaerahpemilihan(),
                    SizedBox(
                      height: 10,
                    ),
                    dataswingfoter(),
                    SizedBox(
                      height: 10,
                    ),
                    dataprogramutama(),
                    SizedBox(
                      height: 10,
                    ),
                    datadomisilidukungan(),
                    SizedBox(
                      height: 10,
                    ),

                    databidangutama(),


                    FadeInUp(
                      duration: const Duration(milliseconds: 1300),
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
                            minimumSize: const Size(150, 50), //////// HERE
                          ),
                          onPressed: () {
                            if(dukungankeluar != 0){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const DukunganKeluarpage()));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Tidak Ada !")));
                            }
                          },
                          child: Text(
                            'Dukungan Yang Keluar',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: whitePrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              )),
            )));
  }

  Widget datadaerahpemilihan() {
    final size = MediaQuery.of(context).size;
    return Column(children: [
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Data Daerah Pemilihan",
              style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
        Container(
            // color:shadowColor4,
            alignment: Alignment.topLeft,
            // height: 250,
            width: 350,
            // margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: gradient5),
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60.0,
                      width: 146,
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
                                      'Nama Daerah',
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
                    Column(
                      children: [
                        Container(
                          height: 30.0,
                          width: 120,
                          child: Table(
                            border: TableBorder(
                                horizontalInside:
                                    BorderSide(color: Colors.white),
                                right: BorderSide(color: Colors.white)),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                      color: gradient5,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0.0))),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                            child: Text(
                                          'Dukungan',
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
                        Row(
                          children: [
                            Container(
                              height: 30.0,
                              width: 40,
                              child: Table(
                                border: TableBorder(
                                    horizontalInside:
                                        BorderSide(color: Colors.white),
                                    right: BorderSide(color: Colors.white)),
                                children: [
                                  TableRow(
                                      decoration: BoxDecoration(
                                          color: gradient5,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0.0))),
                                      children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'L',
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
                              width: 40,
                              child: Table(
                                border: TableBorder(
                                    horizontalInside:
                                        BorderSide(color: Colors.white),
                                    right: BorderSide(color: Colors.white)),
                                children: [
                                  TableRow(
                                      decoration: BoxDecoration(
                                          color: gradient5,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0.0))),
                                      children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'P',
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
                              width: 40,
                              child: Table(
                                border: TableBorder(
                                    horizontalInside:
                                        BorderSide(color: Colors.white),
                                    right: BorderSide(color: Colors.white)),
                                children: [
                                  TableRow(
                                      decoration: BoxDecoration(
                                          color: gradient5,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0.0))),
                                      children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'T',
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
                          ],
                        )
                      ],
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
                                    height: 60.0,
                                    child: Center(
                                        child: Text(
                                      'DPT',
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
                      height: 60.0,
                      width: 42,
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
                                    height: 60.0,
                                    child: Center(
                                        child: Text(
                                      'TPS',
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 12,
                                          color: Colors.black),
                                      // style: myLabelTextStyle,
                                    )))
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.topLeft,
                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: FutureBuilder<List<Datadaerahpemilihan>>(
                        future: futuredaerahpemilihan,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Datadaerahpemilihan>? data = snapshot.data;
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      setState(() async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            "usrdpl", '${data[index].dpldpl!}');
                                        prefs.setInt("totl",
                                            int.parse('${data[index].totl!}'));
                                        prefs.setInt("totp",
                                            int.parse('${data[index].totp!}'));

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Dapilpage()));
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 0, right: 0, top: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: shadowColor4,
                                        border: Border.all(
                                          color: Colors.white,
                                          // width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30.0,
                                            width: 146,
                                            child: Center(
                                              child: Table(
                                                border: TableBorder(
                                                    horizontalInside:
                                                        BorderSide(
                                                            color: Colors
                                                                .blue.shade400),
                                                    right: BorderSide(
                                                        color: Colors
                                                            .blue.shade400)),
                                                children: [
                                                  TableRow(
                                                      decoration: BoxDecoration(
                                                          color: shadowColor4,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0.0))),
                                                      children: [
                                                        Text(
                                                          '${data![index].dpldpl!}',
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'poppins',
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                        )
                                                      ]),
                                                ],
                                              ),
                                            ),
                                          ),
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
                                                        decoration: BoxDecoration(
                                                            color: shadowColor4,
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0.0))),
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                            CurrencyFormat
                                                                .convertToIdr(
                                                                    int.parse(
                                                                        '${data![index].totl!}'),
                                                                    0),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontSize: 10,
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
                                                        decoration: BoxDecoration(
                                                            color: shadowColor4,
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0.0))),
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                            CurrencyFormat
                                                                .convertToIdr(
                                                                    int.parse(
                                                                        '${data![index].totp!}'),
                                                                    0),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontSize: 10,
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
                                                        decoration: BoxDecoration(
                                                            color: shadowColor4,
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0.0))),
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                            CurrencyFormat
                                                                .convertToIdr(
                                                                    int.parse(
                                                                        '${data![index].totd!}'),
                                                                    0),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontSize: 11,
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
                                                        decoration: BoxDecoration(
                                                            color: shadowColor4,
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0.0))),
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                            CurrencyFormat
                                                                .convertToIdr(
                                                                    int.parse(
                                                                        '${data![index].dpldpt!}'),
                                                                    0),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontSize: 10,
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
                                                  border: TableBorder.symmetric(
                                                      inside: BorderSide(
                                                          color: Colors
                                                              .blue.shade400)),
                                                  children: [
                                                    TableRow(
                                                        decoration: BoxDecoration(
                                                            color: shadowColor4,
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0.0))),
                                                        children: [
                                                          Container(
                                                              height: 30.0,
                                                              child: Center(
                                                                  child: Text(
                                                                CurrencyFormat
                                                                    .convertToIdr(
                                                                        int.parse(
                                                                            '${data![index].dpltps!}'),
                                                                        0),
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'poppins',
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black),
                                                              )))
                                                        ]),
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Container(
                                // margin: EdgeInsets.only(top: size.height * 0.3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/riwayatnon.png',
                                      // scale: 3.5,
                                    ),
                                    SizedBox(height: 15),
                                    const Text(
                                      'Belum Ada Data',
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
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    )),
              ],
            )),
      ]),
      Container(
        // color:shadowColor4,
        alignment: Alignment.topLeft,
        height: 30,
        width: 350,
        decoration: BoxDecoration(
          color: shadowColor4,
          border: Border.all(color: shadowColor2),
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30.0,
              width: 146,
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
              width: 120,
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
                                horizontalInside: BorderSide(
                                  color: shadowColor2,
                                ),
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
                                            child: totl.isNotEmpty
                                                ? Text(
                                                    CurrencyFormat.convertToIdr(
                                                        int.parse(totl), 0),
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
                                                  ))),
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
                                            child: totp.isNotEmpty
                                                ? Text(
                                                    CurrencyFormat.convertToIdr(
                                                        int.parse(totp), 0),
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
                                                  ))),
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
                                            child: totd.isNotEmpty
                                                ? Text(
                                                    CurrencyFormat.convertToIdr(
                                                        int.parse(totd), 0),
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
                                                  ))),
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
                              child: totdpldpt.isNotEmpty
                                  ? Text(
                                      CurrencyFormat.convertToIdr(
                                          int.parse(totdpldpt), 0),
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
            Container(
              height: 30.0,
              width: 42,
              child: Table(
                border:
                    TableBorder.symmetric(inside: BorderSide(color: gradient5)),
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          color: shadowColor2,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0.0))),
                      children: [
                        Container(
                            height: 30.0,
                            child: Center(
                                child: totdpltps.isNotEmpty
                                    ? Text(
                                        CurrencyFormat.convertToIdr(
                                            int.parse(totdpltps), 0),
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
                                      )))
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget dataswingfoter() {
    final size = MediaQuery.of(context).size;
    return Column(children: [
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              "Swing Voter Pendukung",
              style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
        Container(
            padding: EdgeInsets.all(20),
            child: Table(
              border: TableBorder.all(width: 1, color: Colors.black45),
              //table border
              children: [
                TableRow(children: [
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Pilihan',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'L',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'P',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Total',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: InkWell(
                      child: Container(
                          color: gradient1,
                          height: 30,
                          child: Center(
                              child: Column(
                            children: [
                              Text(
                                'Tidak Mungkin',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                // style: myLabelTextStyle,
                              ),
                              Text(
                                'Pindah Caleg',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                // style: myLabelTextStyle,
                              )
                            ],
                          ))),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("usrbu", "T");
                        prefs.setString("pindah", "caleg");
                        prefs.setString("title", "Tidak Mungkin Pindah Caleg");
                        prefs.setInt("totlusrbu", tidakpindahcaleglaki);
                        prefs.setInt("totpusrbu", tidakpindahcalegcewek);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserBidangUtamapage()));
                      },
                    ),
                  ),
                  TableCell(
                    child: Container(
                        height: 30,
                        color: Colors.white,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(tidakpindahcaleglaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(tidakpindahcalegcewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(
                              totalgendertidakpindahcaleg, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                      child: InkWell(
                    child: Container(
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Column(
                          children: [
                            Text(
                              'Mungkin',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),

                              // style: myLabelTextStyle,
                            ),
                            Text(
                              'Pindah Caleg',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              // style: myLabelTextStyle,
                            )
                          ],
                        ))),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("usrbu", "Y");
                      prefs.setString("pindah", "caleg");
                      prefs.setString("title", "Mungkin Pindah Caleg");
                      prefs.setInt("totlusrbu", pindahcaleglaki);
                      prefs.setInt("totpusrbu", pindahcalegcewek);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserBidangUtamapage()));
                    },
                  )),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(pindahcaleglaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(pindahcalegcewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(
                              totalgenderpindahcaleg, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                      child: InkWell(
                    child: Container(
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Column(
                          children: [
                            Text(
                              'Tidak Mungkin',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              // style: myLabelTextStyle,
                            ),
                            Text(
                              'Pindah Partai',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              // style: myLabelTextStyle,
                            )
                          ],
                        ))),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();


                      prefs.setString("usrbu", "T");
                      prefs.setString("pindah", "partai");
                      prefs.setString("title", "Tidak Mungkin Pindah Partai");
                      prefs.setInt("totlusrbu", tidakpindahpartailaki);
                      prefs.setInt("totpusrbu", tidakpindahpartaicewek);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserBidangUtamapage()));
                    },
                  )),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(tidakpindahpartailaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(
                              tidakpindahpartaicewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(
                              totalgendertidakpindahpartai, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                      child: InkWell(
                    child: Container(
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Column(
                          children: [
                            Text(
                              'Mungkin',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              // style: myLabelTextStyle,
                            ),
                            Text(
                              'Pindah Partai',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              // style: myLabelTextStyle,
                            )
                          ],
                        ))),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("usrbu", "Y");
                      prefs.setString("pindah", "partai");
                      prefs.setString("title", "Mungkin Pindah Partai");
                      prefs.setInt("totlusrbu", pindahpartailaki);
                      prefs.setInt("totpusrbu", pindahpartaicewek);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserBidangUtamapage()));
                    },
                  )),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(pindahpartailaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(pindahpartaicewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(
                              totalgenderpindahpartai, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                // TableRow(children: [
                //   TableCell(
                //     child: Container(
                //         color: Colors.grey,
                //         height: 30,
                //         child: Center(
                //             child: Text(
                //           'Total',
                //           style: const TextStyle(
                //               fontFamily: 'poppins',
                //               fontSize: 11,
                //               color: Colors.black),
                //           // style: myLabelTextStyle,
                //         ))),
                //   ),
                //   TableCell(
                //     child: Container(
                //         height: 30,
                //         child: Center(
                //             child: Text(
                //           CurrencyFormat.convertToIdr(totalgenderlaki, 0),
                //           style: const TextStyle(
                //               fontFamily: 'poppins',
                //               fontSize: 10,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black),
                //         ))),
                //   ),
                //   TableCell(
                //     child: Container(
                //         height: 30,
                //         child: Center(
                //             child: Text(
                //           CurrencyFormat.convertToIdr(totalgendercewek, 0),
                //           style: const TextStyle(
                //               fontFamily: 'poppins',
                //               fontSize: 10,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black),
                //         ))),
                //   ),
                //   TableCell(
                //     child: Container(
                //         height: 30,
                //         child: Center(
                //             child: Text(
                //           CurrencyFormat.convertToIdr(totaltotal, 0),
                //           style: const TextStyle(
                //               fontFamily: 'poppins',
                //               fontSize: 10,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black),
                //         ))),
                //   )
                // ]),
              ],
            ))
      ]),
    ]);
  }

  Widget dataprogramutama() {
    final size = MediaQuery.of(context).size;
    return Column(children: [
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Program Yang Di Utamakan Pendukung",
              style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
        Container(
            padding: EdgeInsets.all(20),
            child: Table(
              border: TableBorder.all(width: 1, color: Colors.black45),
              //table border
              children: [
                TableRow(children: [
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Program',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'L',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'P',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Total',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: Container(
                        alignment: Alignment.topCenter,
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Kesehatan',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 11,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahkesehatanlaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahkesehatancewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totkesehatan, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: Container(
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Pendidikan',

                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 11,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahpendidikanlaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahpendidikancewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totpendidikan, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: Container(
                        alignment: Alignment.topCenter,
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Modal UMKM',

                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 11,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahmodalumkmlaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahmodalumkmcewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totmodalumkm, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: Container(
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Ekonomi',

                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 11,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahekonomilaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahekonomicewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totekonomilaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: Container(
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Fasilitas',

                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 11,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahfasilitaslaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahfasilitascewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totfasilitaslaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
              ],
            ))
      ]),
    ]);
  }

  Widget datadomisilidukungan() {
    final size = MediaQuery.of(context).size;
    return Column(children: [
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Domisili Dukungan",
              style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
        Container(
            padding: EdgeInsets.all(20),
            child: Table(
              border: TableBorder.all(width: 1, color: Colors.black45),
              //table border
              children: [
                TableRow(children: [
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Domisili',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'L',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'P',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Total',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: Container(
                        alignment: Alignment.topCenter,
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Sesuai KTP',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 11,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahsesuaiktplaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahsesuaiktpcewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totsesuaiktplaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: Container(
                        color: gradient1,
                        height: 30,
                        child: Center(
                            child: Column(
                          children: [
                            Text(
                              'TIdak Sesuai',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 11,
                                  color: Colors.black),
                              // style: myLabelTextStyle,
                            ),
                            Text(
                              'KTP',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 11,
                                  color: Colors.black),
                              // style: myLabelTextStyle,
                            )
                          ],
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahtidaksesuailaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(
                              jumlahtidaksesuaicewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(tottidaksesuailaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
              ],
            ))
      ]),
    ]);
  }

  Widget databidangutama() {
    final size = MediaQuery.of(context).size;
    return Column(children: [
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Bidang Utama Relawan",
              style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
        Container(
            padding: EdgeInsets.all(20),
            child: Table(
              border: TableBorder.all(width: 1, color: Colors.black45),
              //table border
              children: [
                TableRow(children: [
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Bidang',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'L',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'P',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: gradient5,
                        height: 30,
                        child: Center(
                            child: Text(
                          'Total',
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          // style: myLabelTextStyle,
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.topCenter,
                          color: gradient1,
                          height: 30,
                          child: Center(
                              child: Text(
                            'Organisasi',
                            style: const TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            // style: myLabelTextStyle,
                          ))),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("usrbu", "Organisasi");
                        prefs.setString("pindah", "butama");
                        prefs.setString("title", "Organisasi");
                        prefs.setInt("totlusrbu", jumlahOrganisasilaki);
                        prefs.setInt("totpusrbu", jumlahOrganisasicewek);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserBidangUtamapage()));
                      },
                    ),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahOrganisasilaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahOrganisasicewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totOrganisasi, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: InkWell(
                      child: Container(
                          color: gradient1,
                          height: 30,
                          child: Center(
                              child: Column(
                            children: [
                              Text(
                                'Komunikasi/',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                // style: myLabelTextStyle,
                              ),
                              Text(
                                'Promosi',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                // style: myLabelTextStyle,
                              )
                            ],
                          ))),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("usrbu", "Komunikasi/Promosi");
                        prefs.setString("title", "Komunikasi/Promosi");
                        prefs.setString("pindah", "butama");
                        prefs.setInt("totlusrbu", jumlahKomunikasilaki);
                        prefs.setInt("totpusrbu", jumlahKomunikasicewek);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserBidangUtamapage()));
                      },
                    ),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahKomunikasilaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahKomunikasicewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totKomunikasi, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.topCenter,
                          color: gradient1,
                          height: 30,
                          child: Center(
                              child: Text(
                            'Hukum',

                            style: const TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            // style: myLabelTextStyle,
                          ))),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("usrbu", "Hukum");
                        prefs.setString("pindah", "butama");
                        prefs.setString("title", "Hukum");
                        prefs.setInt("totlusrbu", jumlahHukumlaki);
                        prefs.setInt("totpusrbu", jumlahHukumcewek);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserBidangUtamapage()));
                      },
                    ),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahHukumlaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahHukumcewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totHukum, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.topCenter,
                          color: gradient1,
                          height: 30,
                          child: Center(
                              child: Text(
                            'Logistik',

                            style: const TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            // style: myLabelTextStyle,
                          ))),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("usrbu", "Logistik");
                        prefs.setString("pindah", "butama");
                        prefs.setString("title", "Logistik");
                        prefs.setInt("totlusrbu", jumlahLogistiklaki);
                        prefs.setInt("totpusrbu", jumlahLogistikcewek);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserBidangUtamapage()));
                      },
                    ),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahLogistiklaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahLogistikcewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totLogistik, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.topCenter,
                          color: gradient1,
                          height: 30,
                          child: Center(
                              child: Text(
                            'Keuangan',

                            style: const TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            // style: myLabelTextStyle,
                          ))),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("usrbu", "Keuangan");
                        prefs.setString("pindah", "butama");
                        prefs.setString("title", "Keuangan");
                        prefs.setInt("totlusrbu", jumlahkeuanganlaki);
                        prefs.setInt("totpusrbu", jumlahkeuangancewek);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserBidangUtamapage()));
                      },
                    ),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahkeuanganlaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahkeuangancewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totkeuangan, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.topCenter,
                          color: gradient1,
                          height: 30,
                          child: Center(
                              child: Text(
                            'Sosial Media',

                            style: const TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            // style: myLabelTextStyle,
                          ))),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("usrbu", "Sosial Media");
                        prefs.setString("pindah", "butama");
                        prefs.setString("title", "Sosial Media");
                        prefs.setInt("totlusrbu", jumlahSosiallaki);
                        prefs.setInt("totpusrbu", jumlahSosialcewek);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserBidangUtamapage()));
                      },
                    ),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahSosiallaki, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(jumlahSosialcewek, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              color: Colors.black),
                        ))),
                  ),
                  TableCell(
                    child: Container(
                        color: Colors.white,
                        height: 30,
                        child: Center(
                            child: Text(
                          CurrencyFormat.convertToIdr(totSosial, 0),
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  )
                ]),
              ],
            ))
      ]),
    ]);
  }

  Widget datatablerelawan() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Container(
          //     alignment: Alignment.topLeft,
          //     margin: const EdgeInsets.symmetric(horizontal: 20),
          //     child: Text(
          //       "Data Relawan",
          //       style: const TextStyle(
          //         fontFamily: 'poppins',
          //         fontSize: 14,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,
          //       ),
          //     )),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.topLeft,
              height: 250,
              width: 300,
              // margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: gradient5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Table(
                      border: TableBorder(
                          horizontalInside: BorderSide(color: gradient5),
                          right: BorderSide(color: gradient5)),
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                                color: gradient5,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0))),
                            children: [
                              Container(
                                  height: 30.0,
                                  child: Center(
                                      child: Text(
                                    'Relawan',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // style: myLabelTextStyle,
                                  ))),
                            ]),
                        TableRow(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 50.0,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.woman_2_outlined,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Column(children: [
                                              !totrelawancewek.isNaN
                                                  ? Text(
                                                      CurrencyFormat.convertToIdr(
                                                              totrelawancewek,
                                                              0) +
                                                          " %",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              relawancewek != 0
                                                  ? Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                              relawancewek, 0),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                            ]))
                                      ],
                                    ),
                                  )),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: gradient5),
                                ),
                              ),
                              Container(
                                  height: 50.0,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.man_3,
                                          size: 40,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Column(children: [
                                              !totrelawanpria.isNaN
                                                  ? Text(
                                                      CurrencyFormat
                                                              .convertToIdr(
                                                                  totrelawanpria,
                                                                  0) +
                                                          " %",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              relawanpria != 0
                                                  ? Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                              relawanpria, 0),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                            ]))
                                      ],
                                    ),
                                  )),
                            ],
                          )
                        ]),
                        TableRow(children: [
                          Container(
                              height: 50.0,
                              child: Center(
                                child: totalgenderrelawan != 0
                                    ? Text(
                                        "Total : " +
                                            CurrencyFormat.convertToIdr(
                                                totalgenderrelawan, 0),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(
                                        "0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                // Text(
                                //                               "576868",
                                //                               style: TextStyle(
                                //                                   fontFamily: 'poppins',
                                //                                   color: Colors.black,
                                //                                   fontSize: 14,
                                //                                   fontWeight: FontWeight.bold),
                                //                             ),
                              )),
                        ]),
                        TableRow(children: [
                          Container(
                              height: 50.0,
                              child: Center(
                                  child: targetrelawan.isNotEmpty
                                      ? Text(
                                          "Target : " +
                                              CurrencyFormat.convertToIdr(
                                                  int.parse(targetrelawan), 0),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'poppins',
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : Text(
                                          "0",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'poppins',
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                        ]),
                        TableRow(children: [
                          Container(
                              height: 50.0,
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.light,
                                        color: greenPrimary,
                                      ),
                                      Text(
                                        Relawan,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      totaltargetrelawan != 0
                                          ? Text(
                                              CurrencyFormat.convertToIdr(
                                                  totaltargetrelawan, 0),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'poppins',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                    ]),
                              )),
                        ]),
                      ],
                    ),
                  ),
                ],
              )),
        ]);
  }

  Widget datatablependukung() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Container(
          //     alignment: Alignment.topLeft,
          //     margin: const EdgeInsets.symmetric(horizontal: 20),
          //     child: Text(
          //       "Data Pendukung",
          //       style: const TextStyle(
          //         fontFamily: 'poppins',
          //         fontSize: 14,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,
          //       ),
          //     )),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.topLeft,
              height: 250,
              width: 300,
              // margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: gradient5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Table(
                      border: TableBorder(
                          horizontalInside: BorderSide(color: gradient5),
                          right: BorderSide(color: gradient5)),
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                                color: gradient5,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0))),
                            children: [
                              Container(
                                  height: 30.0,
                                  child: Center(
                                      child: Text(
                                    'Pendukung',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // style: myLabelTextStyle,
                                  ))),
                            ]),
                        TableRow(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 50.0,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.woman_2_outlined,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Column(children: [
                                              !totpendukungcewek.isNaN
                                                  ? Text(
                                                      CurrencyFormat.convertToIdr(
                                                              totpendukungcewek,
                                                              0) +
                                                          " %",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              pendukungcewek != 0
                                                  ? Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                              pendukungcewek,
                                                              0),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                            ]))
                                      ],
                                    ),
                                  )),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: gradient5),
                                ),
                              ),
                              Container(
                                  height: 50.0,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.man_3,
                                          size: 40,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Column(children: [
                                              !totpendukungpria.isNaN
                                                  ? Text(
                                                      CurrencyFormat.convertToIdr(
                                                              totpendukungpria,
                                                              0) +
                                                          " %",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              pendukungpria != 0
                                                  ? Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                              pendukungpria, 0),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                            ]))
                                      ],
                                    ),
                                  )),
                            ],
                          )
                        ]),
                        TableRow(children: [
                          Container(
                              height: 50.0,
                              child: Center(
                                child: totalgenderpendukung != 0
                                    ? Text(
                                        "Total : " +
                                            CurrencyFormat.convertToIdr(
                                                totalgenderpendukung, 0),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(
                                        "0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              )),
                        ]),
                        TableRow(children: [
                          Container(
                              height: 50.0,
                              child: Center(
                                  child: targetpendukung.isNotEmpty
                                      ? Text(
                                          "Target : " +
                                              CurrencyFormat.convertToIdr(
                                                  int.parse(targetpendukung),
                                                  0),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'poppins',
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : Text(
                                          "0",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'poppins',
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                        ]),
                        TableRow(children: [
                          Container(
                              height: 50.0,
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.light,
                                        color: greenPrimary,
                                      ),
                                      Text(
                                        Pendukung,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      totaltargetpendukung != 0
                                          ? Text(
                                              CurrencyFormat.convertToIdr(
                                                  totaltargetpendukung, 0),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'poppins',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                    ]),
                              )),
                        ]),
                      ],
                    ),
                  ),
                ],
              )),
        ]);
  }

  Widget datatabledukungan() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Container(
          //     alignment: Alignment.topLeft,
          //     margin: const EdgeInsets.symmetric(horizontal: 20),
          //     child: Text(
          //       "Data Dukungan",
          //       style: const TextStyle(
          //         fontFamily: 'poppins',
          //         fontSize: 14,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,
          //       ),
          //     )),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.topLeft,
              height: 130,
              width: 300,
              // margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: gradient5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Table(
                      border: TableBorder(
                          horizontalInside: BorderSide(color: gradient5),
                          right: BorderSide(color: gradient5)),
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                                color: gradient5,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0))),
                            children: [
                              Container(
                                  height: 30.0,
                                  child: Center(
                                      child: Text(
                                    'Dukungan',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // style: myLabelTextStyle,
                                  ))),
                            ]),
                        TableRow(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 50.0,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.woman_2_outlined,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Column(children: [
                                              !percendukungancewek.isNaN
                                                  ? Text(
                                                      CurrencyFormat.convertToIdr(
                                                              percendukungancewek,
                                                              0) +
                                                          " %",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              dukungancewek != 0
                                                  ? Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                              dukungancewek, 0),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                            ]))
                                      ],
                                    ),
                                  )),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: gradient5),
                                ),
                              ),
                              Container(
                                  height: 50.0,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.man_3,
                                          size: 40,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Column(children: [
                                              !percendukunganpria.isNaN
                                                  ? Text(
                                                      CurrencyFormat.convertToIdr(
                                                              percendukunganpria,
                                                              0) +
                                                          " %",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              dukunganpria != 0
                                                  ? Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                              dukunganpria, 0),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      "0",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'poppins',
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                            ]))
                                      ],
                                    ),
                                  )),
                            ],
                          )
                        ]),
                        TableRow(children: [
                          Container(
                              height: 50.0,
                              child: Center(
                                child: totalgenderdukungan != 0
                                    ? Text(
                                        "Total : " +
                                            CurrencyFormat.convertToIdr(
                                                totalgenderdukungan, 0),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(
                                        "0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              )),
                        ]),
                        // TableRow(children: [
                        //   Container(
                        //       height: 50.0,
                        //       child: Center(
                        //           child: targetsuara.isNotEmpty
                        //               ? Text(
                        //             "Target : " +
                        //                 CurrencyFormat.convertToIdr(
                        //                     int.parse(targetsuara), 0),
                        //             style: TextStyle(
                        //               fontSize: 15,
                        //               fontFamily: 'poppins',
                        //               color: Colors.black,
                        //             ),
                        //             overflow: TextOverflow.ellipsis,
                        //           )
                        //               : Text(
                        //             "0",
                        //             style: TextStyle(
                        //               fontSize: 15,
                        //               fontFamily: 'poppins',
                        //               color: Colors.black,
                        //             ),
                        //             overflow: TextOverflow.ellipsis,
                        //           ))),
                        // ]),
                      ],
                    ),
                  ),
                ],
              )),
        ]);
  }

  Widget datatargerrelawan() {
    // Uint8List bytes = base64.decode(fotoAkun);
    final size = MediaQuery.of(context).size;
    return Container(
        height: 250,
        child: Column(children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.09,
                  width: size.width * 0.37,
                  child: Container(
                      // margin: const EdgeInsets.only(left: 5, top: 5),
                      // height: 80,
                      // width: 100,
                      padding: EdgeInsets.only(right: 5, bottom: 5, top: 5),
                      decoration: BoxDecoration(
                          color: greenPrimary,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Total Perhitungan",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'poppins',
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Suara",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'poppins',
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 0, top: 5),
                                          child: srasrc != null
                                              ? Text(
                                                  CurrencyFormat.convertToIdr(
                                                      int.parse(srasrc!), 0),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'poppins',
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : Text(
                                                  "0",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'poppins',
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                      // Container(
                                      //   margin: const EdgeInsets.only(
                                      //       left: 0, top: 5),
                                      //   child: Text(
                                      //     "Target S",
                                      //     style: TextStyle(
                                      //       fontSize: 8,
                                      //       fontFamily: 'poppins',
                                      //       color: Colors.orange,
                                      //     ),
                                      //     overflow: TextOverflow.ellipsis,
                                      //   ),
                                      // ),
                                    ]),
                              ])
                        ],
                      )),
                ),
                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 0.29,
                  child: Container(
                      // margin: const EdgeInsets.only(left: 5, top: 5),
                      // height: 80,
                      // width: 100,
                      padding: EdgeInsets.only(right: 5, bottom: 5, top: 5),
                      decoration: BoxDecoration(
                          color: greenPrimary,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Target Suara",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'poppins',
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 0, top: 5),
                                          child: targetsuara.isNotEmpty
                                              ? Text(
                                                  CurrencyFormat.convertToIdr(
                                                      int.parse(targetsuara),
                                                      0),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'poppins',
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : Text(
                                                  "0",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'poppins',
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                      // Container(
                                      //   margin: const EdgeInsets.only(
                                      //       left: 0, top: 5),
                                      //   child: Text(
                                      //     "Target S",
                                      //     style: TextStyle(
                                      //       fontSize: 8,
                                      //       fontFamily: 'poppins',
                                      //       color: Colors.orange,
                                      //     ),
                                      //     overflow: TextOverflow.ellipsis,
                                      //   ),
                                      // ),
                                    ]),
                              ])
                        ],
                      )),
                ),
              ]),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.35,
                child: Container(
                    // margin: const EdgeInsets.only(left: 5, top: 5),
                    // height: 80,
                    // width: 120,
                    padding: EdgeInsets.only(right: 5, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                        color: greenPrimary,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Target Relawan",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'poppins',
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 10),
                          Container(
                              margin: const EdgeInsets.only(left: 0, top: 5),
                              child: targetsuara.isNotEmpty
                                  ? Text(
                                      CurrencyFormat.convertToIdr(
                                          int.parse(targetrelawan), 0),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'poppins',
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'poppins',
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                        ])),
              ),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.4,
                child: Container(
                    // margin: const EdgeInsets.only(left: 5, top: 5),
                    // height: 80,
                    // width: 120,
                    padding: EdgeInsets.only(right: 5, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                        color: greenPrimary,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Target Pendukung",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'poppins',
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 0, top: 5),
                                        child: targetsuara.isNotEmpty
                                            ? Text(
                                                CurrencyFormat.convertToIdr(
                                                    int.parse(targetpendukung),
                                                    0),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'poppins',
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Text(
                                                "0",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'poppins',
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                    // Container(
                                    //   margin: const EdgeInsets.only(
                                    //       left: 0, top: 5),
                                    //   child: Text(
                                    //     "Pendukung",
                                    //     style: TextStyle(
                                    //       fontSize: 8,
                                    //       fontFamily: 'poppins',
                                    //       color: Colors.orange,
                                    //     ),
                                    //     overflow: TextOverflow.ellipsis,
                                    //   ),
                                    // ),
                                  ]),
                            ])
                      ],
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              // Container(
              //     margin: const EdgeInsets.only(left: 10, top: 5),
              //     height: 80,
              //     width: 100,
              //     padding: EdgeInsets.all(5),
              //     decoration: BoxDecoration(
              //         color: greenPrimary,
              //         borderRadius: BorderRadius.circular(15),
              //         border: Border.all(color: Colors.grey)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Column(
              //             crossAxisAlignment: CrossAxisAlignment.end,
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             children: [
              //               Text(
              //                 "Jumlah Kursi",
              //                 style: TextStyle(
              //                     fontSize: 12,
              //                     fontFamily: 'poppins',
              //                     color: Colors.orange,
              //                     fontWeight: FontWeight.bold),
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //               Column(
              //                   crossAxisAlignment: CrossAxisAlignment.end,
              //                   mainAxisAlignment: MainAxisAlignment.end,
              //                   children: [
              //                     Container(
              //                         margin: const EdgeInsets.only(
              //                             left: 0, top: 5),
              //                         child: targetsuara.isNotEmpty
              //                             ? Text(
              //                           CurrencyFormat.convertToIdr(
              //                               int.parse(jumlahkursi),
              //                               0),
              //                           style: TextStyle(
              //                             fontSize: 15,
              //                             fontFamily: 'poppins',
              //                             color: Colors.white,
              //                           ),
              //                           overflow:
              //                           TextOverflow.ellipsis,
              //                         )
              //                             : Text(
              //                           "0",
              //                           style: TextStyle(
              //                             fontSize: 15,
              //                             fontFamily: 'poppins',
              //                             color: Colors.white,
              //                           ),
              //                           overflow:
              //                           TextOverflow.ellipsis,
              //                         )),
              //                     Container(
              //                       margin: const EdgeInsets.only(
              //                           left: 0, top: 5),
              //                       child: Text(
              //                         "Jumlah Kursi",
              //                         style: TextStyle(
              //                           fontSize: 8,
              //                           fontFamily: 'poppins',
              //                           color: Colors.orange,
              //                         ),
              //                         overflow: TextOverflow.ellipsis,
              //                       ),
              //                     ),
              //                   ]),
              //             ])
              //       ],
              //     )),

              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.27,
                child: Container(
                    // margin: const EdgeInsets.only(left: 5, top: 5),
                    // height: 80,
                    // width: 100,
                    padding: EdgeInsets.only(right: 5, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                        color: greenPrimary,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Total DPT",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'poppins',
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 0, top: 5),
                                        child: totdpldpt.isNotEmpty
                                            ? Text(
                                                CurrencyFormat.convertToIdr(
                                                    int.parse(totdpldpt), 0),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'poppins',
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Text(
                                                "0",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'poppins',
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                    // Container(
                                    //   margin: const EdgeInsets.only(
                                    //       left: 0, top: 5),
                                    //   child: Text(
                                    //     "DPT",
                                    //     style: TextStyle(
                                    //       fontSize: 8,
                                    //       fontFamily: 'poppins',
                                    //       color: Colors.orange,
                                    //     ),
                                    //     overflow: TextOverflow.ellipsis,
                                    //   ),
                                    // ),
                                  ]),
                            ])
                      ],
                    )),
              ),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.27,
                child: Container(
                    // margin: const EdgeInsets.only(left: 5, top: 5),

                    padding: EdgeInsets.only(right: 5, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                        color: greenPrimary,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Total TPS",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'poppins',
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 0, top: 5),
                                        child: totdpltps.isNotEmpty
                                            ? Text(
                                                CurrencyFormat.convertToIdr(
                                                    int.parse(totdpltps), 0),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'poppins',
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Text(
                                                "0",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'poppins',
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                    // Container(
                                    //   margin: const EdgeInsets.only(
                                    //       left: 0, top: 5),
                                    //   child: Text(
                                    //     "TPS",
                                    //     style: TextStyle(
                                    //       fontSize: 8,
                                    //       fontFamily: 'poppins',
                                    //       color: Colors.orange,
                                    //     ),
                                    //     overflow: TextOverflow.ellipsis,
                                    //   ),
                                    // ),
                                  ]),
                            ])
                      ],
                    )),
              ),
            ],
          ),
        ]));
  }

  Widget Piecartdaerahpemilihan() {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<List<dynamic>>(
      future: fetchDatadapil(kodecaleg),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<dynamic> pieData = snapshot.data!;
          final List<Datadaerahpemilihan> pies = pieData
              .map((data) => Datadaerahpemilihan.fromJson(data))
              .toList();

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 2,
                  child: PieChart(
                    PieChartData(
                      sections: _generatePieChartSections(pies),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add spacing between chart and subtitles
                // Column(
                //   children: pies.map((pie) {
                //     double percentage = (double.parse(pie.totd!)) ;
                //     Color titleColor = gradient5;
                //     return Text(
                //       '${pie.dpldpl}: ${percentage.toStringAsFixed(0)}',
                //       style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.bold,
                //         color: greenPrimary,
                //       ),
                //     );
                //   }).toList(),
                // ),
                Center(
                  child: totalgenderdukungan != 0
                      ? Text(
                          "Total Dukungan : " +
                              CurrencyFormat.convertToIdr(
                                  totalgenderdukungan, 0),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: greenPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(
                          "0",
                          style: TextStyle(
                            fontSize: 12,
                            color: greenPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget Barcartdaerahpemilihan() {
    return Container(
        height: 300,
        margin: const EdgeInsets.only(left: 0, top: 30),
        child: FutureBuilder<List<Datadaerahpemilihan>>(
          future: futuredaerahpemilihan,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                series: <BarSeries<Datadaerahpemilihan, String>>[
                  BarSeries<Datadaerahpemilihan, String>(
                    dataSource: snapshot.data!,
                    xValueMapper: (Datadaerahpemilihan data, _) => data.dpldpl,
                    yValueMapper: (Datadaerahpemilihan data, _) =>
                        double.parse(data.totl!),
                    name: 'L',
                  ),
                  BarSeries<Datadaerahpemilihan, String>(
                    dataSource: snapshot.data!,
                    xValueMapper: (Datadaerahpemilihan data, _) => data.dpldpl,
                    yValueMapper: (Datadaerahpemilihan data, _) =>
                        double.parse(data.totp!),
                    name: 'P',
                  ),
                ],
                legend: Legend(isVisible: true),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ));
  }



  cektotaktifasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'usrkc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmlusract.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          dukungankeluar = jsonResponse['jumlahtidakaktif'];

        });
      }
    }
  }



  cektotdukugan(String usrkc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {'usrkc': usrkc};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmltotdukungan.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          dukungancewek = jsonResponse['jumlahdukunganperempuan'];
          dukunganpria = jsonResponse['jumlahdukunganlaki'];
          totalgenderdukungan = jsonResponse['jumlahdukungantotal'];

          relawancewek = jsonResponse['jumlahrelawancewek'];
          relawanpria = jsonResponse['jumlahrelawanlaki'];
          totalgenderrelawan = relawancewek + relawanpria;

          pendukungcewek = jsonResponse['jumlahpendukungcewek'];
          pendukungpria = jsonResponse['jumlahpendukunglaki'];
          totalgenderpendukung = pendukungcewek + pendukungpria;

          double totcewekpendukung =
              pendukungcewek / totalgenderpendukung * 100;
          double totpriapendukung = pendukungpria / totalgenderpendukung * 100;
          totpendukungpria = double.parse(totpriapendukung.toStringAsFixed(4));
          totpendukungcewek =
              double.parse(totcewekpendukung.toStringAsFixed(4));

          double totcewekrelawan = relawancewek / totalgenderrelawan * 100;
          double totpriarelawan = relawanpria / totalgenderrelawan * 100;
          totrelawancewek = double.parse(totcewekrelawan.toStringAsFixed(0));
          totrelawanpria = double.parse(totpriarelawan.toStringAsFixed(4));

          double totcewekdukungan = dukungancewek / totalgenderdukungan * 100;
          double totpriadukungan = dukunganpria / totalgenderdukungan * 100;
          percendukunganpria = double.parse(totpriadukungan.toStringAsFixed(4));
          percendukungancewek =
              double.parse(totcewekdukungan.toStringAsFixed(4));
          if (totalgenderpendukung <= int.parse(targetpendukung)) {
            Pendukung = "Pendukung Kurang ";
            totaltargetpendukung =
                int.parse(targetpendukung) - totalgenderpendukung;
          } else {
            Pendukung = "Pendukung Sudah Mencapai Target";
            totaltargetpendukung = 0;
          }
          if (totalgenderrelawan <= int.parse(targetrelawan)) {
            Relawan = "Relawan Kurang ";
            totaltargetrelawan = int.parse(targetrelawan) - totalgenderrelawan;
          } else {
            Relawan = "Relawan Sudah Mencapai Target";

            totaltargetrelawan = 0;
          }
          if (totalgenderdukungan <= int.parse(targetsuara)) {
            Dukungan = "Dukungan Kurang ";
            totaltargetdukungan = int.parse(targetsuara) - totalgenderdukungan;
          } else {
            Dukungan = "Dukungan Sudah Mencapai Target";

            totaltargetdukungan = 0;
          }
        });
      }
    }
  }

  cektotdaerahpemilihan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'dplkc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekdpll.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          totdpldpt = jsonResponse['dpldpt']['sum'];
          totdpltps = jsonResponse['dpltps']['sum'];
          totl = jsonResponse['totl']['sum'];
          totp = jsonResponse['totp']['sum'];
          totd = jsonResponse['totd']['sum'];
        });
      }
    }
  }

  cektotswingvoter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'usrkc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmlvoter.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          pindahcaleglaki = jsonResponse['jumlahpindahcaleglakiY'];
          pindahcalegcewek = jsonResponse['jumlahpindahcalegcewekY'];
          tidakpindahcaleglaki = jsonResponse['jumlahpindahcaleglakiT'];
          tidakpindahcalegcewek = jsonResponse['jumlahpindahcalegcewekT'];

          totalgenderpindahcaleg = pindahcaleglaki + pindahcalegcewek;
          totalgendertidakpindahcaleg =
              tidakpindahcaleglaki + tidakpindahcalegcewek;

          pindahpartailaki = jsonResponse['jumlahpindahpartailakiY'];
          pindahpartaicewek = jsonResponse['jumlahpindahpartaicewekY'];
          tidakpindahpartailaki = jsonResponse['jumlahpindahpartailakiT'];
          tidakpindahpartaicewek = jsonResponse['jumlahpindahpartaicewekT'];

          totalgenderpindahpartai = pindahpartailaki + pindahpartaicewek;
          totalgendertidakpindahpartai =
              tidakpindahpartailaki + tidakpindahpartaicewek;

          totalgenderlaki = pindahcaleglaki +
              tidakpindahcaleglaki +
              pindahpartailaki +
              tidakpindahpartailaki;
          totalgendercewek = pindahcalegcewek +
              tidakpindahcalegcewek +
              pindahpartaicewek +
              tidakpindahpartaicewek;

          totalgendercewek = pindahcalegcewek +
              tidakpindahcalegcewek +
              pindahpartaicewek +
              tidakpindahpartaicewek;

          totaltotal = totalgenderpindahcaleg +
              totalgendertidakpindahcaleg +
              totalgenderpindahpartai +
              totalgendertidakpindahpartai;
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
          srasrc = jsonResponse['srasrcy']['sum'];
        });
      }
    }
  }

  cektotbidangutama() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'usrkc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmbidangutama.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          jumlahkesehatanlaki = jsonResponse['jumlahkesehatanlaki'];
          jumlahkesehatancewek = jsonResponse['jumlahkesehatancewek'];

          jumlahpendidikanlaki = jsonResponse['jumlahpendidikanlaki'];
          jumlahpendidikancewek = jsonResponse['jumlahpendidikancewek'];

          jumlahmodalumkmlaki = jsonResponse['jumlahmodalumkmlaki'];
          jumlahmodalumkmcewek = jsonResponse['jumlahmodalumkmcewek'];

          jumlahekonomilaki = jsonResponse['jumlahekonomilaki'];
          jumlahekonomicewek = jsonResponse['jumlahekonomicewek'];

          jumlahfasilitaslaki = jsonResponse['jumlahfasilitaslaki'];
          jumlahfasilitascewek = jsonResponse['jumlahfasilitascewek'];

          totkesehatan = jumlahkesehatanlaki + jumlahkesehatancewek;
          totpendidikan = jumlahpendidikanlaki + jumlahpendidikancewek;
          totmodalumkm = jumlahmodalumkmlaki + jumlahmodalumkmcewek;
          totekonomilaki = jumlahekonomilaki + jumlahekonomicewek;
          totfasilitaslaki = jumlahfasilitaslaki + jumlahfasilitascewek;

          jumlahsesuaiktplaki = jsonResponse['jumlahsesuaiktplaki'];
          jumlahsesuaiktpcewek = jsonResponse['jumlahsesuaiktpcewek'];

          jumlahtidaksesuailaki = jsonResponse['jumlahtidaksesuailaki'];
          jumlahtidaksesuaicewek = jsonResponse['jumlahtidaksesuaicewek'];

          totsesuaiktplaki = jumlahsesuaiktplaki + jumlahsesuaiktpcewek;
          tottidaksesuailaki = jumlahtidaksesuailaki + jumlahtidaksesuaicewek;

          {}
        });
      }
    }
  }

  cektotbidangutamarelawan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kodecaleg = prefs.getString('kodecaleg')!;
    Map data = {'usrkc': kodecaleg};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/jmbidangutama2.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          jumlahOrganisasilaki = jsonResponse['jumlahOrganisasilaki'];
          jumlahOrganisasicewek = jsonResponse['jumlahOrganisasicewek'];

          jumlahKomunikasilaki = jsonResponse['jumlahKomunikasilaki'];
          jumlahKomunikasicewek = jsonResponse['jumlahKomunikasicewek'];

          jumlahHukumlaki = jsonResponse['jumlahHukumlaki'];
          jumlahHukumcewek = jsonResponse['jumlahHukumcewek'];

          jumlahSosiallaki = jsonResponse['jumlahSosiallaki'];
          jumlahSosialcewek = jsonResponse['jumlahSosialcewek'];

          jumlahLogistiklaki = jsonResponse['jumlahLogistiklaki'];
          jumlahLogistikcewek = jsonResponse['jumlahLogistikcewek'];

          jumlahkeuanganlaki = jsonResponse['jumlahkeuanganlaki'];
          jumlahkeuangancewek = jsonResponse['jumlahkeuangancewek'];

          totOrganisasi = jumlahOrganisasilaki + jumlahOrganisasicewek;
          totKomunikasi = jumlahKomunikasilaki + jumlahKomunikasicewek;
          totHukum = jumlahHukumlaki + jumlahHukumcewek;
          totSosial = jumlahSosiallaki + jumlahSosialcewek;
          totLogistik = jumlahLogistiklaki + jumlahLogistikcewek;
          totkeuangan = jumlahkeuanganlaki + jumlahkeuangancewek;
        });
      }
    }
  }
}

List<PieChartSectionData> _generatePieChartSections(
    List<Datadaerahpemilihan> pies) {
  double total = pies.fold(0, (sum, pie) => sum + double.parse(pie.totl!));
  return pies.map((pie) {
    double percentage = (double.parse(pie.totd!));
    return PieChartSectionData(
      value: percentage,
      title: '${pie.dpldpl}\n\ '
              '${percentage.toStringAsFixed(0)}' +
          ' Suara',
      color: gradient6,
      titleStyle: TextStyle(
        fontSize: 13, // Adjust the font size as needed
        fontWeight: FontWeight.bold,
        color: greenPrimary,
      ),
    );
  }).toList();
}
