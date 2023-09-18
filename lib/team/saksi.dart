import 'dart:convert';
import 'dart:io';

// import 'package:image_picker_web/image_picker_web.dart';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/berita/pesan.dart';
import 'package:ayoleg/berita/pesandetail.dart';
import 'package:ayoleg/berita/tambahberita.dart';
import 'package:ayoleg/cameraktp/camerahome.dart';
import 'package:ayoleg/cameraktp/viewimage.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
// import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class Saksipage extends StatefulWidget {
  const Saksipage({Key? key}) : super(key: key);

  @override
  State<Saksipage> createState() => _SaksipageState();
}

class _SaksipageState extends State<Saksipage> {

  late final pickedImage;

  int desiredQuality = 80;
  Future<List<Dataprofinsi>>? futureprofinsi;
  Future<List<Datakelurahan>>? futurekelurahan;
  Future<List<Datakecamatan>>? futurekecamatan;

  Future<List<Datakota>>? futurekota;
  ImagePicker picker = ImagePicker();
  XFile? image;
  late final bytes;
  String base64Image = "";
  Uint8List ?imageFile;

  var profinsicontrolel = TextEditingController();
  var kotacontrolel= TextEditingController();
  var kecamatancontrolel= TextEditingController();
  var kelurahancontrolel= TextEditingController();
  var notpscontrolel= TextEditingController();
  var totaltpscontrolel= TextEditingController();
  var totalsuaracalegcontrolel= TextEditingController();
  var totalsuarasahcalegcontrolel= TextEditingController();
  var totalsuaracaleglaincontrolel= TextEditingController();
  var totalsemuasuaracalegcontrolel= TextEditingController();

  late SharedPreferences sharedPrefs;
  bool isAppbarCollapsing = false;
  bool isLoading = false;
  bool visiblejudulberitaValid = false;
  bool visibleisiberitaValid = false;
  bool visibleprovinsi= false;
  bool visiblekota= false;
  bool visibleKecamatan= false;
  bool visibleKelurahan= false;
  bool visiblenotps= false;
  bool visibletotaldpt= false;
  bool visibletotsuaracaleg= false;
      bool visibletotsuarasahcaleg= false;
  bool visibletotsuaratidaksahcaleg= false;
  bool visiblesemuasuaracaleg= false;
  bool visibleinputdata = false;
  bool visibledataready = false;
  var ctime;


  bool visiblepilihprofinsi = false;
  bool visiblepkota = false;
  bool visiblekecamatan = false;
 bool visiblekelurahan = false;

  String validprofinsi = "";
  String validkota = "";
  String validkelurahan = "";
  String validkecamatan = "";

  String usrdpl = "";
  String usrtps= "";
  String profinsitext = "";
  String kotatext = "";
  String kecamatantext = "";
  String kelurahantext = "";
  String kodecaleg="";

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
  String statusverivy = "";

  ScrollController? _controllerpesan;
  var _baseUrlpesan = '';
  bool visibleerorpesan = false;

  int _page = 0;
  int jumlahberitasaksi = 0;
  final int _limit = 5;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  bool visiblesedangvalid =false;
  bool visiblesudahvalid=false;

  List _postspesan = [];
  List filteredItemsaksi = [];
  String fotoimage = "";


  @override
  void initState() {
    cekdatasaksi();
    cektotinfo();

    setState(() {
      // fetchGetpendukung();
      profinsitext = "Pilih Provinsi....";
      kotatext = "Pilih Kota....";
      kecamatantext = "Pilih Kecamatan....";
      kelurahantext = "Pilih Kelurahan....";

      validprofinsi = "";
      validkota = "";
      validkecamatan = "";
      validkelurahan = "";

      futureprofinsi = fetchGetDataprofinsi();
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        kodecaleg = prefs.getString('kodecaleg')!;
        usrdpl = prefs.getString('usrdpl')!;
        usrtps = prefs.getString('usrtps')!;

        notpscontrolel.text = usrtps;

        _baseUrlpesan = 'http://aplikasiayocaleg.com/ayocalegapi/getberita.php?brtkc=' +
            kodecaleg +
            "&brtsts=S";

        _firstLoadpesan();
        _controllerpesan = ScrollController()..addListener(_loadMorepesan);
        fotoimage = prefs.getString('fotoimage')!;
      });
    });

    super.initState();
  }


  Uint8List? _imageBytes;

  Future<void> _pickImage(ImageSource source) async {
    pickedImage = await ImagePicker().getImage(source: source);
    //
    if (pickedImage != null) {
      setState(() {
        _imageBytes = File(pickedImage.path).readAsBytesSync();
      });

    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 4,
        child: WillPopScope(
          onWillPop: () => Future.value(true),
          child:
          Scaffold(
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
                // automaticallyImplyLeading: false,
                // bottom: TabBar(
                //   labelStyle: TextStyle(fontFamily: 'poppins'),
                //   labelColor: Colors.white,
                //   tabs: [
                //     Tab(
                //       child: Text(
                //         "Perhitungan Suara",
                //         style: const TextStyle(
                //           fontSize: 11,
                //         ),
                //       ),
                //     ),
                //     // Tab(
                //     //   child: Text(
                //     //     "Info TPS",
                //     //     style: const TextStyle(
                //     //       fontSize: 11,
                //     //     ),
                //     //   ),
                //     // ),
                //
                //   ],
                // ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   // icon: Icon(
                    //   //   Icons.arrow_back_ios,
                    //   //   color: Colors.white,
                    //   // ),
                    // ),
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
            body:
              datasaksi(),
              // infosuara(),




          ),
        ));
  }
  Widget datasaksi() {
    Uint8List byteimage = base64.decode(fotoimage);
    final size = MediaQuery.of(context).size;
    return
      SingleChildScrollView(

        child:

      Column(children: [
        Visibility(
          visible: visibleinputdata,
          child:
          ////untuk android
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              SizedBox(
                height: 20,
              ),
              byteimage.isEmpty
                  ? Container(
                width: 250,
                height: 250,
                child: Image.asset("assets/images/gambarnoncamera.png"),
              )
                  : Image.memory(
                byteimage,
                height: 250,
                width: 250,
              ),
              // _imageBytes==null
              //     ? Container(
              //   width: 250,
              //   height: 250,
              //   child: Image.asset("assets/images/gambarnoncamera.png"),
              // )
              //     :
              //
              // Image.memory(
              //   _imageBytes!,
              //   height: 250,
              //   width: 250,
              // ),
              FadeInUp(
                duration: Duration(milliseconds: 600),
                child: Container(
                  alignment: Alignment.center,
                  width: size.width * 0.65,
                  child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("fototambah", "Saksi");
                        await availableCameras().then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CameraHomePage(cameras: value))));
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AlertDialog(
                        //         title: Text('Pilih Gambar'),
                        //         actions: [
                        //           TextButton(
                        //             onPressed: () {
                        //               setState(() async {
                        //                 _pickImage(ImageSource.gallery);
                        //                 Navigator.pop(context);
                        //                 // image = await picker.pickImage(
                        //                 //     source: ImageSource.gallery);
                        //               });
                        //             },
                        //             child: Text('Album'),
                        //           ),
                        //           TextButton(
                        //             onPressed: () {
                        //               setState(() async {
                        //                 _pickImage(ImageSource.camera);
                        //
                        //                 Navigator.pop(context);
                        //                 // image = await picker.pickImage(
                        //                 //     source: ImageSource.camera);
                        //               });
                        //             },
                        //             child: Text('Kamera'),
                        //           ),
                        //         ],
                        //       );
                        //     });
                      },
                      child: Text("Masukkan Form C1")),

                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 30, top: 5, right: 30),
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
                        "  "+usrdpl,
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

                    // Container(
                    //   height: 50,
                    //   alignment: Alignment.centerLeft,
                    //   margin: EdgeInsets.only(left: 30, top: 5, right: 30),
                    //   padding: EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: greenPrimary)),
                    //   child:Text(
                    //     "  "+usrtps,
                    //     style: TextStyle(
                    //         fontFamily: 'poppins',
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 13),
                    //   ),
                    // ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                            FilteringTextInputFormatter.deny(
                              RegExp(r'^0+'),
                            ),

                          ],
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          controller: notpscontrolel,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            // prefixIcon: Icon(
                            //   Icons.newspaper,
                            //   color: greenPrimary,
                            // ),
                            fillColor: whitePrimary,
                            hintText: "",
                            hintStyle: TextStyle(
                                fontFamily: 'poppins', color: greyPrimary),
                            filled: true,
                          ),
                          maxLength: 3,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visiblenotps,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          'Masukkan No. TPS !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),


                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        'Provinsi',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              width: 250,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 2, color: greenPrimary),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(children: [
                                Icon(
                                  Icons.location_city_outlined,
                                  color: greenPrimary,
                                ),
                                TextButton(
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    bottomdialogprofinsi();
                                  },
                                  child: Text(profinsitext,
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          color: greenPrimary,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ]))
                        ],
                      ),
                    ),
                    Visibility(
                      visible: visiblepilihprofinsi,
                      child:
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Pilih Provinsi !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        'Kota',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              width: 250,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 2, color: greenPrimary),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(children: [
                                Icon(
                                  Icons.location_city_outlined,
                                  color: greenPrimary,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (validprofinsi.isEmpty) {
                                      setState(() {
                                        visiblepilihprofinsi = true;
                                      });
                                    } else {
                                      setState(() {
                                        visiblepilihprofinsi = false;
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        bottomdialogkota();
                                      });
                                    }
                                  },
                                  child: Text(kotatext,
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          color: greenPrimary,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ]))
                        ],
                      ),
                    ),
                    Visibility(
                      visible: visiblepkota,
                      child:
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Pilih Kota !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        'Kecamatan',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              width: 250,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 2, color: greenPrimary),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(children: [
                                Icon(
                                  Icons.location_city_outlined,
                                  color: greenPrimary,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (validkota.isEmpty) {
                                      setState(() {
                                        visiblepkota = true;
                                      });
                                    } else {
                                      setState(() {
                                        visiblepkota = false;
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      bottomdialogkecamatan();
                                    }
                                  },
                                  child: Text(kecamatantext,
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          color: greenPrimary,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ]))
                        ],
                      ),
                    ),
                    Visibility(
                      visible: visiblekecamatan,
                      child:
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Pilih Kecamatan !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        'Kelurahan',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              width: 250,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 2, color: greenPrimary),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(children: [
                                Icon(
                                  Icons.location_city_outlined,
                                  color: greenPrimary,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (validkecamatan.isEmpty) {
                                      setState(() {
                                        visiblekecamatan = true;
                                      });
                                    } else {
                                      setState(() {
                                        visiblekecamatan = false;
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      bottomdialogkelurahan();
                                    }
                                  },
                                  child: Text(kelurahantext,
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          color: greenPrimary,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ]))
                        ],
                      ),
                    ),
                    Visibility(
                      visible: visiblekelurahan,
                      child:
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          'Pilih Kelurahan !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
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
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                            FilteringTextInputFormatter.deny(
                              RegExp(r'^0+'),
                            ),

                          ],
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          controller: totaltpscontrolel,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            // prefixIcon: Icon(
                            //   Icons.newspaper,
                            //   color: greenPrimary,
                            // ),
                            fillColor: whitePrimary,
                            hintText: "",
                            hintStyle: TextStyle(
                                fontFamily: 'poppins', color: greyPrimary),
                            filled: true,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visibletotaldpt,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          'Masukkan Total DPT !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),


                    Container(
                      alignment: Alignment.topLeft,
                      margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child:Text(
                        'Total Semua Suara Sah',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                            FilteringTextInputFormatter.deny(
                              RegExp(r'^0+'),
                            ),

                          ],
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          controller: totalsuaracalegcontrolel,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            // prefixIcon: Icon(
                            //   Icons.newspaper,
                            //   color: greenPrimary,
                            // ),
                            fillColor: whitePrimary,
                            hintText: "",
                            hintStyle: TextStyle(
                                fontFamily: 'poppins', color: greyPrimary),
                            filled: true,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          autofocus: false,

                        ),
                      ),
                    ),
                    Visibility(
                      visible: visibletotsuaracaleg,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          'Masukkan Total Semua Suara Sah !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),


                    Container(
                      alignment: Alignment.topLeft,
                      margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child:Text(
                        'Total Suara Caleg',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                            FilteringTextInputFormatter.deny(
                              RegExp(r'^0+'),
                            ),

                          ],
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          controller: totalsuarasahcalegcontrolel,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greenPrimary, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            // prefixIcon: Icon(
                            //   Icons.newspaper,
                            //   color: greenPrimary,
                            // ),
                            fillColor: whitePrimary,
                            hintText: "",
                            hintStyle: TextStyle(
                                fontFamily: 'poppins', color: greyPrimary),
                            filled: true,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visibletotsuarasahcaleg,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          'Masukkan Suara Caleg !',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),


                  ]),




              FadeInUp(
                duration: Duration(milliseconds: 1200),
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

                      setState(() async{
                        isLoading = true;
                        if(byteimage.isEmpty){
                          setState(() {
                            visibletotsuarasahcaleg = false;
                            visibletotsuaracaleg = false;
                            visibletotaldpt = false;
                            isLoading = false;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text("Masukkan Form C1 !")));
                          });
                        }else{
                          // base64Image = await compressImageToBase64(pickedImage!.path, desiredQuality);

                          checkEmpty();
                        }


                        // if(_imageBytes==null){
                        //   setState(() {
                        //     visibletotsuarasahcaleg = false;
                        //     visibletotsuaracaleg = false;
                        //     visibletotaldpt = false;
                        //     isLoading = false;
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(SnackBar(content: Text("Masukkan Form C1 !")));
                        //   });
                        //
                        // }else{
                        //   base64Image = await compressImageToBase64(pickedImage!.path, desiredQuality);
                        //   checkEmpty();
                        // }



                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Simpan',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: whitePrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),

        Visibility(
          visible: visibledataready,
          child:
          ////untuk android
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(top:20),

                  child: Image.network(
                    // widget.question.fileInfo[0].remoteURL,
                    ftc1,
                    // width: 220,
                    height: 250,
                    //
                    loadingBuilder: (context, child, loadingProgress) =>
                    (loadingProgress == null)
                        ? child
                        : Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorBuilder: (context, error, stackTrace) {
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
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("fotoview",ftc1);
                  prefs.setString("navfoto", "saksi");
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
              Visibility(
                visible: visiblesedangvalid,
                child:
                Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(
                          Icons.cancel_schedule_send,
                          size: 20,
                          color: gradient5,
                        ),

                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          statusverivy,
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: gradient5,
                          ),
                        )
                      ],
                    )),
              ),
              Visibility(
                visible: visiblesudahvalid,
                child:
                Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(
                          Icons.verified,
                          size: 20,
                          color: hijauprimary,
                        ),

                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          statusverivy,
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: hijauprimary,
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
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
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ],)
      )
    ;
  }

  // Widget infosuara() {
  //   final size = MediaQuery.of(context).size;
  //   return Stack(
  //     children: <Widget>[
  //       _isFirstLoadRunning
  //           ? const Center(
  //         child: CircularProgressIndicator(),
  //       )
  //           :
  //       SingleChildScrollView(
  //
  //         child:
  //         Container(
  //           margin: const EdgeInsets.only(
  //               bottom: 70),
  //           child: Column(
  //             children: [
  //
  //               Padding(
  //                 padding: EdgeInsets.all(8.0),
  //                 child: TextField(
  //                   onChanged: (value) => filterIteminfosaksi(value),
  //                   decoration: InputDecoration(
  //                     labelText: 'Cari',
  //                     prefixIcon: Icon(Icons.search),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //
  //                 child:
  //                 SingleChildScrollView(
  //
  //                   child:
  //                   ListView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: filteredItemsaksi.length,
  //                     controller: _controllerpesan,
  //                     itemBuilder: (_, index) => Card(
  //                       margin: const EdgeInsets.symmetric(
  //                           vertical: 8, horizontal: 10),
  //                       child: ListTile(
  //                         title: GestureDetector(
  //                             onTap: () async {
  //                               setState(() async {
  //                                 SharedPreferences prefs =
  //                                 await SharedPreferences.getInstance();
  //
  //                                 prefs.setString(
  //                                     "idberita", filteredItemsaksi[index]["idb"]);
  //                                 // prefs.setString('nohprelawan', data[index].usrhp!);
  //                                 Navigator.push(
  //                                     context,
  //                                     MaterialPageRoute(
  //                                         builder: (context) =>
  //                                         const PesanDetailpage()));
  //                                 // Navigator.pop(context);
  //                               });
  //                             },
  //                             child: Container(
  //                               // margin: EdgeInsets.only(
  //                               //     left: 20, right: 20, top: 10),
  //                               // // alignment: Alignment.centerLeft,
  //                               // padding: const EdgeInsets.only(bottom: 0),
  //                               // decoration: BoxDecoration(
  //                               //   border: Border.all(color: Colors.grey),
  //                               //   color: whitePrimary,
  //                               //   borderRadius: BorderRadius.circular(20),
  //                               //   boxShadow: const [
  //                               //     // BoxShadow(
  //                               //     //     blurRadius: 2,
  //                               //     //     color: shadowColor,
  //                               //     //     spreadRadius: 3)
  //                               //   ],
  //                               // ),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   // Container(
  //                                   //   padding: EdgeInsets.only(left: 20, right: 20),
  //                                   //   child: Divider(
  //                                   //     thickness: 1,
  //                                   //   ),
  //                                   // ),
  //                                   InkWell(
  //                                     child: Container(
  //                                       child: ListTile(
  //                                         tileColor: whitePrimary,
  //                                         leading: Image.network(
  //                                           // widget.question.fileInfo[0].remoteURL,
  //
  //                                           filteredItemsaksi[index]["brtft"],
  //                                           width: 80,
  //                                           height: 80,
  //                                           //
  //                                           loadingBuilder: (context, child,
  //                                               loadingProgress) =>
  //                                           (loadingProgress == null)
  //                                               ? child
  //                                               : CircularProgressIndicator(),
  //                                           errorBuilder:
  //                                               (context, error, stackTrace) {
  //                                             Future.delayed(
  //                                               Duration(milliseconds: 0),
  //                                                   () {
  //                                                 if (mounted) {
  //                                                   setState(() {
  //                                                     CircularProgressIndicator();
  //                                                   });
  //                                                 }
  //                                               },
  //                                             );
  //                                             return SizedBox.shrink();
  //                                           },
  //                                         ),
  //                                         title: Column(
  //                                           crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                           children: [
  //                                             Row(
  //                                               children: [
  //                                                 Icon(
  //                                                   Icons.timer_outlined,
  //                                                   size: 17,
  //                                                 ),
  //                                                 Text(
  //                                                   filteredItemsaksi[index]
  //                                                   ["brtdp"] +
  //                                                       " " +
  //                                                       filteredItemsaksi[index]
  //                                                       ["brttp"],
  //                                                   style: const TextStyle(
  //                                                       fontFamily: 'poppins',
  //                                                       fontSize: 9,
  //                                                       color: Colors.black),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             SizedBox(
  //                                               height: 5,
  //                                             ),
  //                                             Text(
  //                                               //2 or more line you want
  //                                               filteredItemsaksi[index]["brtnm"],
  //
  //                                               overflow: TextOverflow.ellipsis,
  //                                               style: const TextStyle(
  //                                                   fontFamily: 'poppins',
  //                                                   color: textPrimary,
  //                                                   fontWeight: FontWeight.bold,
  //                                                   fontSize: 12),
  //                                             ),
  //                                             Text(
  //                                               //2 or more line you want
  //                                               filteredItemsaksi[index]["brtjdl"],
  //
  //                                               overflow: TextOverflow.ellipsis,
  //                                               style: const TextStyle(
  //                                                   fontFamily: 'poppins',
  //                                                   color: textPrimary,
  //                                                   fontWeight: FontWeight.bold,
  //                                                   fontSize: 13),
  //                                             ),
  //                                           ],
  //                                         ),
  //
  //                                       ),
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),
  //                             )),
  //
  //                         // subtitle: Text(_posts[index]['body']),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //
  //               if (_isLoadMoreRunning == true)
  //                 const Padding(
  //                   padding: EdgeInsets.only(top: 10, bottom: 40),
  //                   child: Center(
  //                     child: CircularProgressIndicator(),
  //                   ),
  //                 ),
  //               if (_hasNextPage == false)
  //                 Container(
  //                   padding: const EdgeInsets.only(top: 30, bottom: 40),
  //                   color: Colors.amber,
  //                   child: const Center(
  //                     child: Text('You have fetched all of the content'),
  //                   ),
  //                 ),
  //
  //
  //             ],
  //           ),
  //         ),
  //       ),
  //       Visibility(
  //         visible: visibleerorpesan,
  //         child: Center(
  //           child: Container(
  //             margin: EdgeInsets.only(top: size.height * 0.3),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Image.asset(
  //                   'assets/images/riwayatnon.png',
  //                   scale: 3.5,
  //                 ),
  //                 SizedBox(height: 15),
  //                 const Text(
  //                   'Data Tidak Ada !',
  //                   style: TextStyle(
  //                       fontFamily: 'poppins',
  //                       color: greenPrimary,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 12),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //
  //
  //
  //       Align(
  //           alignment: Alignment.bottomRight,
  //           child: Container(
  //             padding: new EdgeInsets.fromLTRB(00, 0, 10, 70),
  //             child: FadeInUp(
  //               duration: Duration(milliseconds: 1300),
  //               child: Container(
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
  //                     'Total : ' + CurrencyFormat.convertToIdr(jumlahberitasaksi, 0),
  //                     style: TextStyle(
  //                         fontFamily: 'poppins',
  //                         color: whitePrimary,
  //                         fontSize: 11,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )),
  //       Align(
  //           alignment: Alignment.bottomRight,
  //           child: Container(
  //             padding: new EdgeInsets.fromLTRB(00, 0, 10, 120),
  //             child: FadeInUp(
  //               duration: Duration(milliseconds: 1300),
  //               child: Container(
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
  //                     setState(() async {
  //                       SharedPreferences prefs = await SharedPreferences.getInstance();
  //                       prefs.setString("brtsts", "S");
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) =>
  //                               const Tambahnewspage()));
  //                     });
  //                   },
  //                   child: Icon(
  //                     Icons.add_card,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )),
  //
  //     ],
  //   );
  // }


  bottomdialogprofinsi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<List<Dataprofinsi>>(
              future: futureprofinsi,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Dataprofinsi>? data = snapshot.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              futurekota = fetchGetDatakota(data[index].prds!);
                              setState(() {
                                prefs.setString(
                                    "profinsitext", '${data[index].prds!}');
                                prefs.setString("profinsiaktifitastext",
                                    '${data[index].prds!}');
                                profinsitext = '${data[index].prds!}';
                                validprofinsi = '${data[index].prds!}';

                                Navigator.pop(context);
                              });
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whitePrimary,
                              border: Border.all(
                                color: whitePrimary,
                                width: 2,
                              ),
                            ),
                            child: ListTile(
                              tileColor: whitePrimary,
                              leading: Text(
                                ' ${data![index].prds!}',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        );
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
          );
        });
  }

  bottomdialogkota() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<List<Datakota>>(
              future: futurekota,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Datakota>? data = snapshot.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              futurekecamatan =
                                  fetchGetDatakecamatan(data[index].ktds!);
                              setState(() {
                                prefs.setString("kotaaktifitastext",
                                    '${data[index].ktds!}');
                                prefs.setString(
                                    "kotatext", '${data[index].ktds!}');
                                kotatext = '${data[index].ktds!}';
                                validkota = '${data[index].ktds!}';
                                Navigator.pop(context);
                              });
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whitePrimary,
                              border: Border.all(
                                color: whitePrimary,
                                width: 2,
                              ),
                            ),
                            child: ListTile(
                              tileColor: whitePrimary,
                              leading: Text(
                                ' ${data![index].ktds!}',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        );
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
          );
        });
  }

  bottomdialogkecamatan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<List<Datakecamatan>>(
              future: futurekecamatan,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Datakecamatan>? data = snapshot.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              futurekelurahan =
                                  fetchGetDatakelurahan(data[index].kcds!);
                              setState(() {
                                prefs.setString(
                                    "kecamatantext", '${data[index].kcds!}');
                                prefs.setString("kecamatanaktifitastext",
                                    '${data[index].kcds!}');
                                kecamatantext = '${data[index].kcds!}';
                                validkecamatan = '${data[index].kcds!}';
                                Navigator.pop(context);
                              });
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whitePrimary,
                              border: Border.all(
                                color: whitePrimary,
                                width: 2,
                              ),
                            ),
                            child: ListTile(
                              tileColor: whitePrimary,
                              leading: Text(
                                ' ${data![index].kcds!}',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        );
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
          );
        });
  }

  bottomdialogkelurahan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<List<Datakelurahan>>(
              future: futurekelurahan,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Datakelurahan>? data = snapshot.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              prefs.setString(
                                  "kelurahantext", '${data[index].klds!}');
                              prefs.setString("kelurahanaktifitastext",
                                  '${data[index].klds!}');
                              kelurahantext = '${data[index].klds!}';
                              validkelurahan = '${data[index].klds!}';
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whitePrimary,
                              border: Border.all(
                                color: whitePrimary,
                                width: 2,
                              ),
                            ),
                            child: ListTile(
                              tileColor: whitePrimary,
                              leading: Text(
                                ' ${data![index].klds!}',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        );
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
          );
        });
  }

  checkEmpty() {

    if (notpscontrolel.text.isEmpty) {
      setState(() {
        visiblenotps = true;
        visibletotsuarasahcaleg = false;
        visibletotsuaracaleg = false;
        visiblekelurahan = false;
        visibletotaldpt = false;
        isLoading = false;

      });
    }
   else if (validkelurahan.isEmpty) {
      setState(() {
        visiblenotps = false;
        visibletotsuarasahcaleg = false;
        visibletotsuaracaleg = false;
        visiblekelurahan = true;
        visibletotaldpt = false;
        isLoading = false;

      });
    } else if (totaltpscontrolel.text.isEmpty) {
      setState(() {
        visiblenotps = false;
        visibletotsuarasahcaleg = false;
        visibletotsuaracaleg = false;
        visiblekelurahan = false;
        visibletotaldpt = true;
        isLoading = false;

      });
    }else if (totalsuaracalegcontrolel.text.isEmpty) {
     setState(() {
       visiblenotps = false;
       visibletotsuarasahcaleg = false;
       visibletotsuaracaleg = true;
       visiblekelurahan = false;
       visibletotaldpt = false;
       isLoading = false;

     });
   }else if (totalsuarasahcalegcontrolel.text.isEmpty) {
     setState(() {
       visiblenotps = false;
       visibletotsuarasahcaleg = true;
       visibletotsuaracaleg = false;
       visibletotaldpt = false;
       isLoading = false;

     });
   } else {
      setState(() {
        visiblenotps = false;
        visibletotsuarasahcaleg = false;
        visibletotsuaracaleg = false;
        visiblekelurahan = false;
        visibletotaldpt = false;
        isLoading = true;

        tambahsaksi(fotoimage);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              title:  Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child:CircularProgressIndicator()),
            ));



      });
    }
  }

  tambahsaksi(String foto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String kodecaleg = prefs.getString('kodecaleg')!;
    String nohpAkun = prefs.getString('nohpregister')!;
    String namaregister = prefs.getString('namaregister')!;

    // DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    // DateFormat timeformat = DateFormat("HH:mm:ss");
    // String createDate = dateFormat.format(DateTime.now());
    // String createtime = timeformat.format(DateTime.now());

    Map data = {
      'nmsra': namaregister,
      'srakc': kodecaleg,
      'srahp': nohpAkun,
      'ftc1': foto,
      'srapr': validprofinsi,
      'srakt': validkota,
      'srakct': validkecamatan,
      'srakl': validkelurahan,
      'sratps': notpscontrolel.text,
      'sradpt': totaltpscontrolel.text,
      'srasah': totalsuaracalegcontrolel.text,
      'srasrc': totalsuarasahcalegcontrolel.text,
      'sradpl': usrdpl,
      'sravld': "N",


    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/inputsaksi.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          notifyLogin();
          prefs.remove('fotoimage');
          isLoading = true;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Tambah Data Berhasil !")));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const CustomNavRelawanBar();
              }));
        });

        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("Tambah Berita Berhasil!")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Tambah Berita Gagal!")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Tambah Berita Gagal!")));
      Navigator.of(context).pop();
    }
  }
  Future<String> notifyLogin() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokencaleg = prefs.getString('tokencaleg')!;
    String namaAkun = prefs.getString('namaregister')!;
    final body = {
      "to" : tokencaleg,
      "notification" : {
        "body" : usrdpl +" TPS "+ notpscontrolel.text,
        "title": "Perhitungan Suara Saksi "+ namaAkun,
        // "image": image,
      }
    };

    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse("https://fcm.googleapis.com/fcm/send"));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'key = AAAAfPCPk3E:APA91bFJL-PIwHPisx821MZbmqEGq0EF_wWXDzf3ZpWGbV_7NZQBUy751J68ljDkGjXsd68upJE9E8GYGjOQN4eKpcnKAhlJpJc96Ee9tu4hUeZgIL8Glh90Sl6_N5MFDx_ihGBXC_vK');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    if (response.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("berhasil")));
    } else {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("failed!")));
    }
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  Future dialogregisterberhasil() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Image.asset(
            'assets/images/otpp.png',
            height: 100,
            width: 100,
          ),
          content: const Text(
              "Data Berhasil Terkirim"),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, false);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return const CustomNavRelawanBar();
                      }));

                });

              },
            ),
          ],
        ));
  }
  cekdatasaksi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    String nohsaksi = prefs.getString('nohpregister')!;
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
            visibleinputdata = false;
            visibledataready = true;
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

             if( jsonResponse['data']['stsvald']=='N'){
               statusverivy = "Data Sedang Di Validasi";
                visiblesedangvalid =true;
                visiblesudahvalid=false;
             }else{
               visiblesedangvalid =false;
               visiblesudahvalid=true;
               statusverivy = "Data Sudah Di Validasi";
             }


          });
        }else{
          setState(() {
             visibleinputdata = true;
             visibledataready = false;
          });
        }

      }else{

      }
    }else{

    }
  }

  Future<String> compressImageToBase64(String imagePath, int quality) async {
    File file = File(imagePath);
    List<int> imageBytes = await file.readAsBytes();

    List<int> compressedBytes = await FlutterImageCompress.compressWithList(
      _imageBytes!,
      minHeight: 500, // Set the minimum height (optional)
      minWidth: 500, // Set the minimum width (optional)
      quality: quality, // Set the desired quality (0-100)
      format: CompressFormat.jpeg, // Set the desired output format
    );

    String base64String = base64Encode(compressedBytes);
    return base64String;
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


        visibleerorpesan = false;

      });
    } catch (err) {
      if (kDebugMode) {
        setState(() {

          visibleerorpesan = true;

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

}
