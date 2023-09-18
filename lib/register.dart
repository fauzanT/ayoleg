// ignore_for_file: unused_local_variable, use_build_context_synchronously
// import 'package:ayoleg/camera.dart';
// import 'package:camera/camera.dart';
import 'dart:math';

import 'package:ayoleg/camera.dart';
import 'package:ayoleg/camera_preview.dart';
import 'package:ayoleg/cameraktp/cameraktp.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:ayoleg/reveral.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/login.dart';
import 'package:ayoleg/otp/otp_page.dart';
import 'package:ayoleg/welcome/privacy_policy_register.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = true;

// bool visiblenama = false;
  bool visiblenikValid = false;
  bool visiblenik16Valid = false;
  bool visiblenamavalid = false;
  bool visibleEmailValid = false;
  bool visiblepasswordValid = false;
  bool visibleagamaValid = false;
  bool visiblekawin = false;
  bool visiblepekerjaanValid = false;
  bool visiblekelurahan = false;
  bool visiblenotps = false;
  bool visiblealamatDomisili = false;
  bool visibleEmailcek = false;
  bool visiblenohp = false;
  bool visiblenohplengkap = false;
  bool visiblenohcek = false;
  bool visibleEmailCheck = false;
  bool visibleGenderValid = false;
  bool visibleAkunSudahTerdaftar = false;
  bool isLoading = false;
  bool visiblenohp9digit = false;

  bool visiblepilihprofinsi = false;
  bool visiblepkota = false;
  bool visiblekecamatan = false;
  bool visibledaerahpemilihan = false;
  bool visibletempatlahir = false;
  bool visibletanggallahir = false;
  bool visibleusia17 = false;
  bool visibleRTValid = false;
  bool visibleRWValid = false;
  bool visiblealamatKTPValid = false;
  bool visiblepilihprofinsiDomisili = false;
  bool visiblepkotaDomisili = false;
  bool visiblekecamatanDomisili = false;
  bool visiblekelurahanDomisili = false;
  bool visibleRTValidDomisili = false;
  bool visibleRWValidDomisili = false;
  bool visiblealamatKTPValidDomisili = false;
  bool visibleniksudahadaValid = false;
  bool visibletargetpendukung = false;
  bool visiblejmlpemilih = false;
  bool visibleharapancaleg = false;
  bool visbletargetpendukungkosong = false;
  bool visiblebidangutama = false;
  var bidangutamaconterolel = TextEditingController();

  Future<List<Datadaerahpemilihan>>? futuredaerahpemilihan;
  Future<List<Datakelurahan>>? futurekelurahan;
  Future<List<Datakecamatan>>? futurekecamatan;
  Future<List<Dataprofinsi>>? futureprofinsi;
  Future<List<Datakota>>? futurekota;
  late SharedPreferences sharedPrefs;
  String profinsitext = "";
  String kotatext = "";
  String kecamatantext = "";
  String kelurahantext = "";

  String profinsiDomisilitext = "";
  String kotaDomisilitext = "";
  String kecamatanDomisilitext = "";
  String kelurahanDomisilitext = "";

  String daerahpemilihantext = "";

  String validprofinsi = "";
  String validkota = "";
  String validkelurahan = "";
  String validkecamatan = "";

  String validprofinsiDomisili = "";
  String validkotaDomisili = "";
  String validkelurahanDomisili = "";
  String validkecamatanDomisili = "";

  String validdaerahpemilihan = "";
  String tanggallahirtext = "";
  String kodereveral = "";
  String statusreferal = "";

  // String resultkdcaleg = "";
  String kodecal = "";
  String fotoktp = "";
  String fotousr = "";
  String Fotobanner1 = "";
  String Fotobanner2 = "";
  String Fotobanner3 = "";
  String Fotobanner4 = "";
  String Fotobanner5 = "";

  @override
  void initState() {
    _valuaalamat2 = 1;
    profinsitext = "Pilih Provinsi....";
    kotatext = "Pilih Kota....";
    kecamatantext = "Pilih Kecamatan....";
    kelurahantext = "Pilih Kelurahan....";

    profinsiDomisilitext = "Pilih Provinsi Domisili....";
    kotaDomisilitext = "Pilih Kota Domisili....";
    kecamatanDomisilitext = "Pilih Kecamatan Domisili....";
    kelurahanDomisilitext = "Pilih Kelurahan Domisili....";

    daerahpemilihantext = "Pilih Daerah Pemilihan";

    kodecal = "";

    // tanggallahirtext = "Pilih Tanggal Lahir....";
    validprofinsi = "";
    validkota = "";
    validkecamatan = "";
    validkelurahan = "";

    validprofinsiDomisili = "";
    validkotaDomisili = "";
    validkecamatanDomisili = "";
    validkelurahanDomisili = "";

    validdaerahpemilihan = "";

    futureprofinsi = fetchGetDataprofinsi();
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);

        kodecal = prefs.getString('kodecaleg')!;
        statusreferal = prefs.getString('statusreferal')!;
        futuredaerahpemilihan = fetchGetDatadaerahpemilihan(kodecal);

        if (statusreferal == "R") {
          setState(() {
            visiblebidangutama = true;
            visibletargetpendukung = true;
          });
        } else {
          setState(() {
            visiblebidangutama = false;
            visibletargetpendukung = false;
          });
        }

        if (prefs.getString('fotoktpregister') != "") {
          fotoktp = prefs.getString('fotoktpregister')!;
        } else {
          fotoktp = "";
        }
        if (prefs.getString('fotoregister') != "") {
          fotousr = prefs.getString('fotoregister')!;
        } else {
          fotousr = "";
        }

        Fotobanner1 = prefs.getString('Fotobanner1')!;
        Fotobanner2 = prefs.getString('Fotobanner2')!;
        Fotobanner3 = prefs.getString('Fotobanner3')!;
        Fotobanner4 = prefs.getString('Fotobanner4')!;
        Fotobanner5 = prefs.getString('Fotobanner5')!;
      });
    });
    super.initState();
  }

  _startUp() async {
    _setLoading(true);

    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  final _form = GlobalKey<FormState>();

  void _saveForm() {
    setState(() {
      value = _form.currentState!.validate();
    });
  }

  int? _value;
  int? _valuagama;
  int? _valuaalamat2;

  int? _valuestatusperkawinan;

  var nikcontrolell = TextEditingController();
  var namacontrolel = TextEditingController();
  var emailcontrolel = TextEditingController();
  var passwordcontrolel = TextEditingController();

  var agamacontrolel = TextEditingController();
  var pekerjaancontrolel = TextEditingController();
  var tempatlahircontrolel = TextEditingController();
  var tanggallahircontrolel = TextEditingController();
  var rtcontrolel = TextEditingController();
  var rwcontrolel = TextEditingController();
  var alamatktpcontrolel = TextEditingController();

  var alamatktpDomisilicontrolel = TextEditingController();
  var rwDomisilicontrolel = TextEditingController();
  var rtDomisilicontrolel = TextEditingController();
  var targetpendukungcontrolel = TextEditingController();

  var notpscontrolel = TextEditingController();
  var jumlahpemilihcontrolel = TextEditingController();
  var harapancalegcontrolel = TextEditingController();

  String radioButtonAlamat2Item = "Y";
  String radioButtonItem = "";
  String radioButtonagamaItem = "";
  String radioButtonstatusperkawinanItem = "";
  String foto = "";
  String fotoktpregister = "";

  var nohpcontrolel = TextEditingController();
  String stringValue = "";
  bool value = false;

  Future<void> onBackPressed() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Reveralcodepage()));
    });
  }

  String dropdownbidangutamavalue = 'Organisasi';

  var itemsbidangutama = [
    'Organisasi',
    'Komunikasi/Promosi',
    'Hukum',
    'Sosial Media',
    'Logistik',
    'Keuangan',
    "Lainnya",
  ];

  // late final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Uint8List bytesktp = base64.decode(fotoktp);
    Uint8List bytewajah = base64.decode(fotousr);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return WillPopScope(
      onWillPop: () async {
        onBackPressed(); // Action to perform on back pressed
        return false;
      },
      child:
      Stack(
        children: [
          Container(
            color: whitePrimary,
            height: size.height,
            width: size.width,
            // child: Image.asset(
            //   "assets/images/g7.png",
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   alignment: Alignment.bottomCenter,
            // ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: whitePrimary,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: whitePrimary,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
                elevation: 0,
                leading: FadeInUp(
                  duration: Duration(milliseconds: 300),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Reveralcodepage()));
                      // Navigator.pushNamed(context, '/WelcomePage');
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: greyPrimary,
                    ),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    // FadeInUp(
                    //   duration: Duration(milliseconds: 400),
                    //   child: Container(
                    //     width: 100,
                    //     height: 60,
                    //     child: Image.asset("assets/images/logocaleg4.jpg"),
                    //   ),
                    // ),
                    Container(
                      width: 50,
                    )
                  ],
                )),
            body: Form(
              key: _form,
              child: ListView(
                children: [
                  isLoading
                      ? Column(
                          children: [
                            Container(
                                width: 40,
                                height: 40,
                                padding: EdgeInsets.all(8),
                                child: CircularProgressIndicator()),
                          ],
                        )
                      : Container(),

                  // Center(
                  //   child: FadeInUp(
                  //     duration: Duration(milliseconds: 800),
                  //     child: ImageSlideshow(
                  //       // width: size.width,
                  //       // height: size.width,
                  //       height: 250,
                  //       initialPage: 0,
                  //       children: [
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child: Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner1,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder:
                  //                     (context, child, loadingProgress) =>
                  //                         (loadingProgress == null)
                  //                             ? child
                  //                             : Center(
                  //                                 child:
                  //                                     CircularProgressIndicator(),
                  //                               ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     Duration(milliseconds: 0),
                  //                     () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return SizedBox.shrink();
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child: Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner2,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder:
                  //                     (context, child, loadingProgress) =>
                  //                         (loadingProgress == null)
                  //                             ? child
                  //                             : Center(
                  //                                 child:
                  //                                     CircularProgressIndicator(),
                  //                               ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     Duration(milliseconds: 0),
                  //                     () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return SizedBox.shrink();
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child: Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner3,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder:
                  //                     (context, child, loadingProgress) =>
                  //                         (loadingProgress == null)
                  //                             ? child
                  //                             : Center(
                  //                                 child:
                  //                                     CircularProgressIndicator(),
                  //                               ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     Duration(milliseconds: 0),
                  //                     () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return SizedBox.shrink();
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child: Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner4,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder:
                  //                     (context, child, loadingProgress) =>
                  //                         (loadingProgress == null)
                  //                             ? child
                  //                             : Center(
                  //                                 child:
                  //                                     CircularProgressIndicator(),
                  //                               ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     Duration(milliseconds: 0),
                  //                     () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return SizedBox.shrink();
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               // height: size.width * 0.5,
                  //               // width: size.width * 0.7,
                  //               child: Image.network(
                  //                 // widget.question.fileInfo[0].remoteURL,
                  //                 Fotobanner5,
                  //                 // width: 220,
                  //                 // height: 220,
                  //                 //
                  //                 loadingBuilder:
                  //                     (context, child, loadingProgress) =>
                  //                         (loadingProgress == null)
                  //                             ? child
                  //                             : Center(
                  //                                 child:
                  //                                     CircularProgressIndicator(),
                  //                               ),
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   Future.delayed(
                  //                     Duration(milliseconds: 0),
                  //                     () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           CircularProgressIndicator();
                  //                         });
                  //                       }
                  //                     },
                  //                   );
                  //                   return SizedBox.shrink();
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //       onPageChanged: (value) {
                  //         print('Page changed: $value');
                  //       },
                  //       autoPlayInterval: 5000,
                  //       isLoop: true,
                  //     ),
                  //   ),
                  // ),
                  Center(
                    child: Container(
                      width: 180,
                      height: 200,
                      child: Image.asset(
                        'assets/images/logocaleg4.jpg',
                        // height: 80,
                      ),
                    ),
                  ),

                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child:
                      TextFormField(
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                        controller: namacontrolel,
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
                          prefixIcon: Icon(
                            Icons.person,
                            color: greenPrimary,
                          ),
                          counterText: "HARUS DI ISI",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                          fillColor: whitePrimary,
                          labelText: "NAMA",
                          labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.grey,
                              fontSize: 11),
                          filled: true,
                        ),

                        textInputAction: TextInputAction.done,
                        maxLength: 100,
                        keyboardType: TextInputType.name,
                        autofocus: false,
                        textCapitalization: TextCapitalization.words,

                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblenamavalid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan NAMA Minimal 3 Karakter !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'No. HP',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1100),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^0+'),
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^1+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^2+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^3+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^4+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^5+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^6+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^7+'), //users can't type 0 at 1st position
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^9+'), //users can't type 0 at 1st position
                          ),
                        ],
                        controller: nohpcontrolel,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greenPrimary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greenPrimary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greenPrimary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greenPrimary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          prefixIcon: Container(
                            margin:
                                const EdgeInsets.only(top: 11.0, left: 10.0),
                            child: const Text(
                              '+62',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 15,
                                  color: greenPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          fillColor: whitePrimary,
                          counterText: "HARUS DI ISI",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                          hintText: "8xxxxxxxxxx",
                          hintStyle: const TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        validator: (valueNum) {
                          if (valueNum == null || valueNum.isEmpty) {}
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (val) {
                          _saveForm();
                        },
                        maxLength: 15,
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblenohp9digit,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: Text(
                        'No. HP Tidak Valid !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblenohp,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: Text(
                        'Masukkan No. HP !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblenohplengkap,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: Text(
                        'No. HP Tidak Valid !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblenohcek,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: Text(
                        'No. HP Sudah Terdaftar !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleAkunSudahTerdaftar,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: Text(
                        'Akun Sudah Terdaftar !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),

                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        controller: passwordcontrolel,
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
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          counterText: "HARUS DI ISI",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                          labelText: "KATA SANDI",
                          labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.grey,
                              fontSize: 11),
                          filled: true,
                        ),
                        maxLength: 20,
                        keyboardType: TextInputType.visiblePassword,
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,

                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblepasswordValid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan KATA SANDI Minimal 6 Karakter !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),

                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        controller: emailcontrolel,
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
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          counterText: "",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                          labelText: "EMAIL",
                          labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.grey,
                              fontSize: 11),
                          filled: true,
                        ),
                        maxLength: 100,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        // validator: (valueMail) {
                        //   // if (valueMail == null || valueMail.isEmpty) {
                        //   //   return 'Email Tidak Boleh Kosong';
                        //   // }
                        //   // if (!RegExp(r'\S+@\S+\.\S+').hasMatch(valueMail)) {
                        //   //   return "Masukkan Email yang Valid";
                        //   // }
                        //   // return null;
                        // },
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleEmailValid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan EMAIL !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleEmailcek,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'EMAIL Tidak Valid !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleEmailCheck,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'EMAIL Sudah Terdaftar !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),

                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
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
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                        controller: nikcontrolell,
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
                          prefixIcon: Icon(
                            Icons.comment_rounded,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          counterText: "",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                          labelText: "NIK",
                          labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.grey,
                              fontSize: 11),
                          filled: true,
                        ),
                        maxLength: 16,
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                      ),
                    ),
                  ),

                  Visibility(
                    visible: visiblenikValid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan NIK !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleniksudahadaValid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'NIK Sudah Terdaftar !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblenik16Valid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'NIK Harus 16 Digit !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),

                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Jenis Kelamin',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            '  HARUS DI ISI',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontSize: 8),
                          ),
                        ],
                      )),
                  FadeInUp(
                    duration: Duration(milliseconds: 900),
                    child:
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                    radioButtonItem = 'L';
                                    _value = 1;
                                  });
                                },
                              ),
                              const Icon(
                                Icons.male,
                                color: Colors.blueAccent,
                              ),
                              const Text(
                                'Laki-laki',
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
                                    radioButtonItem = 'P';
                                    _value = 2;
                                  });
                                },
                              ),
                              const Icon(
                                Icons.female,
                                color: Colors.pinkAccent,
                              ),
                              const Text(
                                'Perempuan',
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
                  ),
                  Visibility(
                    visible: visibleGenderValid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Pilih JENIS KELAMIN !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),

                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
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
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                        controller: tanggallahircontrolel,
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
                          prefixIcon: Icon(
                            Icons.person,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          counterText: "HARUS DI ISI",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                          labelText: "USIA",
                          labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.grey,
                              fontSize: 11),
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
                    visible: visibletanggallahir,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan USIA Saat Ini !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleusia17,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'USIA Belum Cukup !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Daerah Pemilihan',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            '  HARUS DI ISI',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontSize: 8),
                          ),
                        ],
                      )),
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
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    bottomdialogdaerahpemilihan();
                                  });
                                },
                                child: Text(daerahpemilihantext,
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: greenPrimary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visibledaerahpemilihan,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Pilih Daerah Pemilihan !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),

                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Provinsi Sesuai KTP',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            '  HARUS DI ISI',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontSize: 8),
                          ),
                        ],
                      )),
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
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visiblepilihprofinsi,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Pilih Provinsi Sesuai KTP !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Kota Sesuai KTP',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            '  HARUS DI ISI',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontSize: 8),
                          ),
                        ],
                      )),
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
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visiblepkota,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Pilih Kota Sesuai KTP !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Kecamatan Sesuai KTP',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            '  HARUS DI ISI',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontSize: 8),
                          ),
                        ],
                      )),
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
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visiblekecamatan,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Pilih Kecamatan Sesuai KTP !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Kelurahan Sesuai KTP',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            '  HARUS DI ISI',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontSize: 8),
                          ),
                        ],
                      )),
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
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visiblekelurahan,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Pilih Kelurahan Sesuai KTP !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),

                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          // FilteringTextInputFormatter.deny(
                          //   RegExp(r'^0+'),
                          // ),

                        ],
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        controller: rtcontrolel,
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
                          prefixIcon: Icon(
                            Icons.location_city_outlined,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          counterText: "HARUS DI ISI",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                          hintText: "RT Sesuai KTP ",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                        maxLength: 3,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleRTValid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan RT Sesuai KTP !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          // FilteringTextInputFormatter.deny(
                          //   RegExp(r'^0+'),
                          // ),

                        ],
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        controller: rwcontrolel,
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
                          prefixIcon: Icon(
                            Icons.location_city_outlined,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          counterText: "HARUS DI ISI",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                          hintText: "RW Sesuai KTP",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                        maxLength: 3,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleRWValid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan RW Sesuai KTP !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        controller: alamatktpcontrolel,
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
                          prefixIcon: Icon(
                            Icons.location_city_outlined,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          counterText: "HARUS DI ISI",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                          hintText: "Alamat Sesuai KTP",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: false,

                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),

                  Visibility(
                    visible: visiblealamatKTPValid,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan Alamat Sesuai KTP !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 5, left: 20),
                    child: Text(
                      'Apakah Alamat Domisili Sama Dengan Alamat KTP ?',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 900),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: greenPrimary,
                                value: 1,
                                groupValue: _valuaalamat2,
                                onChanged: (value) {
                                  setState(() {
                                    radioButtonAlamat2Item = 'Y';

                                    _valuaalamat2 = 1;

                                    visiblealamatDomisili = false;
                                  });
                                },
                              ),
                              // const Icon(
                              //   Icons.male,
                              //   color: Colors.blueAccent,
                              // ),
                              const Text(
                                'Ya Sama',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: greenPrimary,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: greenPrimary,
                                value: 2,
                                groupValue: _valuaalamat2,
                                onChanged: (value) {
                                  setState(() {
                                    radioButtonAlamat2Item = 'T';
                                    _valuaalamat2 = 2;

                                    visiblealamatDomisili = true;
                                  });
                                },
                              ),
                              // const Icon(
                              //   Icons.female,
                              //   color: Colors.pinkAccent,
                              // ),
                              const Text(
                                'Tidak Sama',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: greenPrimary,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblealamatDomisili,
                    child: alamatDomisili(),
                  ),

                  //alamat 2

                  Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 0.0, top: 10, bottom: 5),
                      child: Row(
                        children: [
                          Text(
                            'No. TPS',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            '  HARUS DI ISI',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontSize: 8),
                          ),
                        ],
                      )),
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            alignment: Alignment.center,
                            margin:
                                const EdgeInsets.only(left: 30.0, right: 0.0),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              controller: notpscontrolel,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greenPrimary, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greenPrimary, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greenPrimary, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greenPrimary, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                prefixIcon: Icon(
                                  Icons.post_add_outlined,
                                  color: greenPrimary,
                                ),
                                fillColor: whitePrimary,
                                hintText: "No. TPS",
                                hintStyle: TextStyle(color: greyPrimary),
                                filled: true,
                                counterText: " ",
                                counterStyle: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.red,
                                    fontSize: 8),
                              ),

                              maxLength: 3,
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          Container(
                            width: 100,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: greenPrimary,
                                onPrimary: whitePrimary,
                                shadowColor: shadowColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                minimumSize: const Size(60, 40), //////// HERE
                              ),
                              onPressed: () {
                                setState(() {
                                  setState(() async {
                                    String url =
                                        'https://cekdptonline.kpu.go.id/';
                                    await launchUrl(Uri.parse(url));
                                    // if (await canLaunchUrl(Uri.parse(url))) {
                                    // await launchUrl(Uri.parse(url));
                                    // } else {
                                    // throw 'Could not launch $url';
                                    // }
                                  });

                                  // _launchURL();
                                });
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cek DPT',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: whitePrimary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),

                  Visibility(
                    visible: visiblenotps,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan No. TPS !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: visiblebidangutama,
                      child: Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Bidang Utama?',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                  Text(
                                    '  ',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.red,
                                        fontSize: 8),
                                  ),
                                ],
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              margin:
                                  EdgeInsets.only(left: 20, top: 5, right: 10),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: greenPrimary)),
                              child: Row(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Show the dropdown options when the text field is tapped
                                          _showOptionsDialogbidangutama(
                                              context);
                                        },
                                        child: Icon(
                                          Icons.arrow_drop_down_outlined,
                                          size: 30,
                                          color: greenPrimary,
                                        ),
                                      )),
                                  Container(
                                    width: 250,
                                    color: whitePrimary,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 0.0),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          color: greenPrimary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                      controller: bidangutamaconterolel,
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        fillColor: whitePrimary,
                                        hintText: "Pilih...",
                                        hintStyle:
                                            TextStyle(color: greyPrimary),
                                        filled: true,
                                        counterText: "",
                                        counterStyle: TextStyle(
                                            fontFamily: 'poppins',
                                            color: Colors.red,
                                            fontSize: 8),
                                      ),
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      maxLength: 100,
                                      textInputAction: TextInputAction.done,
                                      textCapitalization: TextCapitalization.sentences,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )),

                  Visibility(
                      visible: visibletargetpendukung,
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 0.0, top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Target Pendukung',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                  Text(
                                    '  HARUS DI ISI',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        color: Colors.red,
                                        fontSize: 8),
                                  ),
                                ],
                              )),
                          FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                controller: targetpendukungcontrolel,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: greenPrimary, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: greenPrimary, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: greenPrimary, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: greenPrimary, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  prefixIcon: Icon(
                                    Icons.transfer_within_a_station_rounded,
                                    color: greenPrimary,
                                  ),
                                  fillColor: whitePrimary,
                                  hintText: "",
                                  hintStyle: TextStyle(color: greyPrimary),
                                  filled: true,
                                  counterText: "",
                                  counterStyle: TextStyle(
                                      fontFamily: 'poppins',
                                      color: Colors.red,
                                      fontSize: 8),
                                ),
                                keyboardType: TextInputType.phone,
                                autofocus: false,
                                maxLength: 15,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visbletargetpendukungkosong,
                            child: Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(
                                  left: 40.0, right: 0.0, top: 10),
                              child: Text(
                                'Masukkan Target Pendukung !',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      )),

                  Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 0.0, top: 10),
                      child: Row(
                        children: [
                          Text(
                            'Jumlah Pemilih Yang Terdaftar Dalam Kartu Keluarga',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            '  HARUS DI ISI',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontSize: 8),
                          ),
                        ],
                      )),
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        controller: jumlahpemilihcontrolel,
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
                          prefixIcon: Icon(
                            Icons.transfer_within_a_station_rounded,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          hintText: "",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                          counterText: "",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                        ),
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                        maxLength: 3,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),

                  Visibility(
                    visible: visiblejmlpemilih,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan Jumlah Pemilih Yang Terdaftar Dalam Kartu Keluarga !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),

                  Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 0.0, top: 10),
                      child: Row(
                        children: [
                          Text(
                            'Saran Untuk Caleg',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            ' ',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontSize: 8),
                          ),
                        ],
                      )),
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        controller: harapancalegcontrolel,
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
                          prefixIcon: Icon(
                            Icons.transfer_within_a_station_rounded,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          hintText: "",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                          counterText: "",
                          counterStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.red,
                              fontSize: 8),
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        autofocus: false,
                        maxLength: 100,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ),

                  Visibility(
                    visible: visibleharapancaleg,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Saran Untuk Caleg !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ),



                  FadeInUp(
                    duration: Duration(milliseconds: 1400),
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
                          minimumSize: const Size(110, 50), //////// HERE
                        ),
                        onPressed: () {
                          setState(() {
                            checkEmpty();
                            isLoading = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lanjut',
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
                  FadeInUp(
                    duration: Duration(milliseconds: 1600),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah Punya Akun ?",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            color: textPrimary,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginPage()));
                          },
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                                // prefs.setString(
                                //     "profinsitext", '${data[index].prds!}');
                                // prefs.setString("profinsiDomisilitext",
                                //     '${data[index].prds!}');
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
                                    fontSize: 11,
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
                            'Belum Ada Data',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
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
                                // prefs.setString(
                                //     "kotaDomisilitext", '${data[index].ktds!}');
                                //
                                // prefs.setString(
                                //     "kotatext", '${data[index].ktds!}');
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
                                    fontSize: 11,
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
                            'Belum Ada Data',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
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
                                // prefs.setString(
                                //     "kecamatantext", '${data[index].kcds!}');
                                //
                                // prefs.setString("kecamatanDomisilitext",
                                //     '${data[index].kcds!}');
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
                                    fontSize: 11,
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
                            'Belum Ada Data',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
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
                              // prefs.setString(
                              //     "kelurahantext", '${data[index].klds!}');
                              //
                              // prefs.setString("kelurahanDomisilitext",
                              //     '${data[index].klds!}');
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
                                    fontSize: 11,
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
                            'Belum Ada Data',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
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

  bottomdialogprofinsiDomisili() async {
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
                                // prefs.setString("profinsiDomisilitext",
                                //     '${data[index].prds!}');

                                profinsiDomisilitext = '${data[index].prds!}';
                                validprofinsiDomisili = '${data[index].prds!}';

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
                                    fontSize: 11,
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
                            'Belum Ada Data',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
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

  bottomdialogkotaDomisili() async {
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
                                // prefs.setString(
                                //     "kotaDomisilitext", '${data[index].ktds!}');

                                kotaDomisilitext = '${data[index].ktds!}';
                                validkotaDomisili = '${data[index].ktds!}';
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
                                    fontSize: 11,
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
                            'Belum Ada Data',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
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

  bottomdialogkecamatanDomisili() async {
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
                                // prefs.setString("kecamatanDomisilitext",
                                //     '${data[index].kcds!}');

                                kecamatanDomisilitext = '${data[index].kcds!}';
                                validkecamatanDomisili = '${data[index].kcds!}';
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
                                    fontSize: 11,
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
                            'Belum Ada Data',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
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

  bottomdialogkelurahanDomisili() async {
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
                              // prefs.setString("kelurahanDomisilitext",
                              //     '${data[index].klds!}');

                              kelurahanDomisilitext = '${data[index].klds!}';
                              validkelurahanDomisili = '${data[index].klds!}';
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
                                    fontSize: 11,
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
                            'Belum Ada Data',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
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

  Widget alamatDomisili() {
    return Container(
        margin: const EdgeInsets.only(left: 50.0, right: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    left: 20.0, right: 0.0, top: 5, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      'Provinsi Domisili',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                    Text(
                      '  HARUS DI ISI',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontSize: 8),
                    ),
                  ],
                )),
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
                          border: Border.all(width: 2, color: greenPrimary),
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
                            bottomdialogprofinsiDomisili();
                          },
                          child: Text(profinsiDomisilitext,
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
              visible: visiblepilihprofinsiDomisili,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Pilih Provinsi Domisili !',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    left: 20.0, right: 0.0, top: 5, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      'Kota Domisili',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                    Text(
                      '  HARUS DI ISI',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontSize: 8),
                    ),
                  ],
                )),
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
                          border: Border.all(width: 2, color: greenPrimary),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(children: [
                        Icon(
                          Icons.location_city_outlined,
                          color: greenPrimary,
                        ),
                        TextButton(
                          onPressed: () {
                            if (validprofinsiDomisili.isEmpty) {
                              setState(() {
                                visiblepilihprofinsiDomisili = true;
                              });
                            } else {
                              setState(() {
                                visiblepilihprofinsiDomisili = false;
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                bottomdialogkotaDomisili();
                              });
                            }
                          },
                          child: Text(kotaDomisilitext,
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
              visible: visiblepkotaDomisili,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Pilih Kota Domisili !',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    left: 20.0, right: 0.0, top: 5, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      'Kecamatan Domisili',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                    Text(
                      '  HARUS DI ISI',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontSize: 8),
                    ),
                  ],
                )),
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
                      width: 280,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: greenPrimary),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(children: [
                        Icon(
                          Icons.location_city_outlined,
                          color: greenPrimary,
                        ),
                        TextButton(
                          onPressed: () {
                            if (validkotaDomisili.isEmpty) {
                              setState(() {
                                visiblepkotaDomisili = true;
                              });
                            } else {
                              setState(() {
                                visiblepkotaDomisili = false;
                              });
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              bottomdialogkecamatanDomisili();
                            }
                          },
                          child: Text(kecamatanDomisilitext,
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
              visible: visiblekecamatanDomisili,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Pilih Kecamatan Domisili !',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    left: 20.0, right: 0.0, top: 5, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      'Kelurahan Domisili',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                    Text(
                      '  HARUS DI ISI',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontSize: 8),
                    ),
                  ],
                )),
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
                      width: 280,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: greenPrimary),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(children: [
                        Icon(
                          Icons.location_city_outlined,
                          color: greenPrimary,
                        ),
                        TextButton(
                          onPressed: () {
                            if (validkecamatanDomisili.isEmpty) {
                              setState(() {
                                visiblekecamatanDomisili = true;
                              });
                            } else {
                              setState(() {
                                visiblekecamatanDomisili = false;
                              });
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              bottomdialogkelurahanDomisili();
                            }
                          },
                          child: Text(kelurahanDomisilitext,
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
              visible: visiblekelurahanDomisili,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Pilih Kelurahan Domisili !',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                ),
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                    // FilteringTextInputFormatter.deny(
                    //   RegExp(r'^0+'),
                    // ),

                  ],
                  style: const TextStyle(
                      fontFamily: 'poppins',
                      color: greenPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  controller: rtDomisilicontrolel,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    prefixIcon: Icon(
                      Icons.location_city_outlined,
                      color: greenPrimary,
                    ),
                    fillColor: whitePrimary,
                    counterText: "HARUS DI ISI",
                    counterStyle: TextStyle(
                        fontFamily: 'poppins', color: Colors.red, fontSize: 8),
                    hintText: "RT Domisili",
                    hintStyle: TextStyle(color: greyPrimary),
                    filled: true,
                  ),
                  keyboardType: TextInputType.phone,
                  autofocus: false,
                  maxLength: 3,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            Visibility(
              visible: visibleRTValidDomisili,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Masukkan RT Domisili !',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                ),
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                    // FilteringTextInputFormatter.deny(
                    //   RegExp(r'^0+'),
                    // ),

                  ],
                  style: const TextStyle(
                      fontFamily: 'poppins',
                      color: greenPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  controller: rwDomisilicontrolel,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    prefixIcon: Icon(
                      Icons.location_city_outlined,
                      color: greenPrimary,
                    ),
                    fillColor: whitePrimary,
                    counterText: "HARUS DI ISI",
                    counterStyle: TextStyle(
                        fontFamily: 'poppins', color: Colors.red, fontSize: 8),
                    hintText: "RW Domisili",
                    hintStyle: TextStyle(color: greyPrimary),
                    filled: true,
                  ),
                  keyboardType: TextInputType.phone,
                  autofocus: false,
                  maxLength: 3,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            Visibility(
              visible: visibleRWValidDomisili,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Masukkan RW Domisili !',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                ),
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  style: const TextStyle(
                      fontFamily: 'poppins',
                      color: greenPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  controller: alamatktpDomisilicontrolel,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenPrimary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    prefixIcon: Icon(
                      Icons.location_city_outlined,
                      color: greenPrimary,
                    ),
                    fillColor: whitePrimary,
                    counterText: "HARUS DI ISI",
                    counterStyle: TextStyle(
                        fontFamily: 'poppins', color: Colors.red, fontSize: 8),
                    hintText: "Alamat Domisili",
                    hintStyle: TextStyle(color: greyPrimary),
                    filled: true,
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: false,
                  maxLength: 100,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            Visibility(
              visible: visiblealamatKTPValidDomisili,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Masukkan Alamat Domisili !',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                ),
              ),
            ),
          ],
        ));
  }

  bottomdialogdaerahpemilihan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
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
                            setState(() {
                              prefs.setString("daerahpemilihantext",
                                  '${data[index].dpldpl!}');
                              daerahpemilihantext = '${data[index].dpldpl!}';
                              validdaerahpemilihan = '${data[index].dpldpl!}';
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
                                ' ${data![index].dpldpl!}',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 11,
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
                            'Belum Ada Data',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
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
    if (namacontrolel.text.isEmpty) {
      setState(() {
        visiblenohp9digit = false;
        visiblenamavalid = true;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visibleagamaValid = false;
        visiblenik16Valid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visbletargetpendukungkosong = false;

      });
    }else if (namacontrolel.text.length < 3 ) {
      setState(() {
        visiblenohp9digit = false;
        visiblenamavalid = true;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visiblekawin = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visbletargetpendukungkosong = false;
      });
    } else if (nohpcontrolel.text.isEmpty) {
      setState(() {
        visiblenohp9digit = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visiblekawin = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = true;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visbletargetpendukungkosong = false;

      });
    }else if (nohpcontrolel.text.length < 9 ) {
      setState(() {
        visiblenohp9digit = true;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visiblekawin = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visbletargetpendukungkosong = false;
      });
    } else if (passwordcontrolel.text.isEmpty) {
      setState(() {
        visiblenohp9digit = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = true;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblekawin = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visbletargetpendukungkosong = false;

      });
    }else if (passwordcontrolel.text.length < 6) {
      setState(() {
        visiblenohp9digit = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = true;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblekawin = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visbletargetpendukungkosong = false;

      });
    } else if (radioButtonItem.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekawin = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = true;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
        visbletargetpendukungkosong = false;
      });
    } else if (tanggallahircontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = true;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblekawin = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
        visbletargetpendukungkosong = false;
      });
    } else if (daerahpemilihantext == "Pilih Daerah Pemilihan") {
      setState(() {
        visiblenamavalid = false;

        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = true;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
        visbletargetpendukungkosong = false;
      });
    } else if (validkelurahan.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = true;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
        visbletargetpendukungkosong = false;
      });
    } else if (rtcontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = true;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
        visbletargetpendukungkosong = false;
      });
    } else if (rwcontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = true;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
        visbletargetpendukungkosong = false;
      });
    } else if (alamatktpcontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visibleagamaValid = false;
        visiblenik16Valid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = true;
        visiblenotps = false;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
        visbletargetpendukungkosong = false;
      });
    } else if (notpscontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = true;
        visiblejmlpemilih = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
        visbletargetpendukungkosong = false;
      });
    }else if (statusreferal == "R") {
      setState(() {
        chekempityrelawan();
      });
    }
    else if (jumlahpemilihcontrolel.text.isEmpty) {
      setState(() {
        visiblejmlpemilih = true;
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visbletargetpendukungkosong = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
      });
    } else if (radioButtonAlamat2Item == "Y") {
      setState(() {
        visibleharapancaleg = false;
        visiblenamavalid = false;
        visiblenamavalid = false;
        visiblejmlpemilih = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visbletargetpendukungkosong = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visiblenohp9digit = false;
        isLoading = false;

        ceknohp();
      });
    } else if (validkelurahanDomisili.isEmpty) {
      setState(() {
        visiblealamatKTPValidDomisili = false;
        visibleRWValidDomisili = false;
        visibleRTValidDomisili = false;
        visiblekelurahanDomisili = true;
        visiblejmlpemilih = false;
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visbletargetpendukungkosong = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
      });
    } else if (rtDomisilicontrolel.text.isEmpty) {
      setState(() {
        visiblealamatKTPValidDomisili = false;
        visibleRWValidDomisili = false;
        visibleRTValidDomisili = true;
        visiblekelurahanDomisili = false;
        visiblejmlpemilih = false;
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visbletargetpendukungkosong = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
      });
    } else if (rwDomisilicontrolel.text.isEmpty) {
      setState(() {
        visiblealamatKTPValidDomisili = false;
        visibleRWValidDomisili = true;
        visibleRTValidDomisili = false;
        visiblekelurahanDomisili = false;
        visiblejmlpemilih = false;
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visbletargetpendukungkosong = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
      });
    } else if (alamatktpDomisilicontrolel.text.isEmpty) {
      setState(() {
        visiblealamatKTPValidDomisili = true;
        visibleRWValidDomisili = false;
        visibleRTValidDomisili = false;
        visiblekelurahanDomisili = false;
        visiblejmlpemilih = false;
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visbletargetpendukungkosong = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visibleharapancaleg = false;
        isLoading = false;
        visiblenohp9digit = false;
      });
    } else {
      setState(() {
        visiblealamatKTPValidDomisili = false;
        visibleRWValidDomisili = false;
        visibleRTValidDomisili = false;
        visiblekelurahanDomisili = false;
        visibleharapancaleg = false;
        visiblenamavalid = false;
        visiblenamavalid = false;
        visiblejmlpemilih = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblenikValid = false;
        visiblenik16Valid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = false;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblenotps = false;
        visbletargetpendukungkosong = false;
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        visiblenohp9digit = false;
        isLoading = false;
        ceknohp();
      });
    }

  }
  chekempityrelawan(){
    if (targetpendukungcontrolel.text.isEmpty) {
    setState(() {
    visiblenamavalid = false;
    visiblenamavalid = false;
    visibleEmailValid = false;
    visiblepasswordValid = false;
    visiblenikValid = false;
    visiblenik16Valid = false;
    visibleagamaValid = false;
    visiblekawin = false;
    visiblepekerjaanValid = false;
    visiblepilihprofinsi = false;
    visiblepkota = false;
    visiblekecamatan = false;
    visiblekelurahan = false;
    visibledaerahpemilihan = false;
    visibletempatlahir = false;
    visibletanggallahir = false;
    visibleRTValid = false;
    visibleRWValid = false;
    visiblealamatKTPValid = false;
    visiblenotps = false;
    visiblejmlpemilih = false;
    visibleEmailcek = false;
    visiblenohp = false;
    visiblenohplengkap = false;
    visiblenohcek = false;
    visibleEmailCheck = false;
    visibleGenderValid = false;
    visibleAkunSudahTerdaftar = false;
    visibleharapancaleg = false;
    isLoading = false;
    visiblenohp9digit = false;
    visbletargetpendukungkosong = true;
    });
    }
    else if (jumlahpemilihcontrolel.text.isEmpty) {
    setState(() {
    visiblejmlpemilih = true;
    visiblenamavalid = false;
    visiblenamavalid = false;
    visibleEmailValid = false;
    visiblepasswordValid = false;
    visiblenikValid = false;
    visiblenik16Valid = false;
    visibleagamaValid = false;
    visiblekawin = false;
    visiblepekerjaanValid = false;
    visiblepilihprofinsi = false;
    visiblepkota = false;
    visiblekecamatan = false;
    visiblekelurahan = false;
    visibledaerahpemilihan = false;
    visibletempatlahir = false;
    visibletanggallahir = false;
    visibleRTValid = false;
    visibleRWValid = false;
    visiblealamatKTPValid = false;
    visiblenotps = false;
    visbletargetpendukungkosong = false;
    visibleEmailcek = false;
    visiblenohp = false;
    visiblenohplengkap = false;
    visiblenohcek = false;
    visibleEmailCheck = false;
    visibleGenderValid = false;
    visibleAkunSudahTerdaftar = false;
    visibleharapancaleg = false;
    isLoading = false;
    visiblenohp9digit = false;
    });
    } else if (radioButtonAlamat2Item == "Y") {
    setState(() {
    visibleharapancaleg = false;
    visiblenamavalid = false;
    visiblenamavalid = false;
    visiblejmlpemilih = false;
    visibleEmailValid = false;
    visiblepasswordValid = false;
    visiblenikValid = false;
    visiblenik16Valid = false;
    visibleagamaValid = false;
    visiblekawin = false;
    visiblepekerjaanValid = false;
    visiblepilihprofinsi = false;
    visiblepkota = false;
    visiblekecamatan = false;
    visiblekelurahan = false;
    visibledaerahpemilihan = false;
    visibletempatlahir = false;
    visibletanggallahir = false;
    visibleRTValid = false;
    visibleRWValid = false;
    visiblealamatKTPValid = false;
    visiblenotps = false;
    visbletargetpendukungkosong = false;
    visibleEmailcek = false;
    visiblenohp = false;
    visiblenohplengkap = false;
    visiblenohcek = false;
    visibleEmailCheck = false;
    visibleGenderValid = false;
    visibleAkunSudahTerdaftar = false;
    visiblenohp9digit = false;
    isLoading = false;

    ceknohp();
    });
    } else if (validkelurahanDomisili.isEmpty) {
    setState(() {
    visiblealamatKTPValidDomisili = false;
    visibleRWValidDomisili = false;
    visibleRTValidDomisili = false;
    visiblekelurahanDomisili = true;
    visiblejmlpemilih = false;
    visiblenamavalid = false;
    visiblenamavalid = false;
    visibleEmailValid = false;
    visiblepasswordValid = false;
    visiblenikValid = false;
    visiblenik16Valid = false;
    visibleagamaValid = false;
    visiblekawin = false;
    visiblepekerjaanValid = false;
    visiblepilihprofinsi = false;
    visiblepkota = false;
    visiblekecamatan = false;
    visiblekelurahan = false;
    visibledaerahpemilihan = false;
    visibletempatlahir = false;
    visibletanggallahir = false;
    visibleRTValid = false;
    visibleRWValid = false;
    visiblealamatKTPValid = false;
    visiblenotps = false;
    visbletargetpendukungkosong = false;
    visibleEmailcek = false;
    visiblenohp = false;
    visiblenohplengkap = false;
    visiblenohcek = false;
    visibleEmailCheck = false;
    visibleGenderValid = false;
    visibleAkunSudahTerdaftar = false;
    visibleharapancaleg = false;
    isLoading = false;
    visiblenohp9digit = false;
    });
    } else if (rtDomisilicontrolel.text.isEmpty) {
    setState(() {
    visiblealamatKTPValidDomisili = false;
    visibleRWValidDomisili = false;
    visibleRTValidDomisili = true;
    visiblekelurahanDomisili = false;
    visiblejmlpemilih = false;
    visiblenamavalid = false;
    visiblenamavalid = false;
    visibleEmailValid = false;
    visiblepasswordValid = false;
    visiblenikValid = false;
    visiblenik16Valid = false;
    visibleagamaValid = false;
    visiblekawin = false;
    visiblepekerjaanValid = false;
    visiblepilihprofinsi = false;
    visiblepkota = false;
    visiblekecamatan = false;
    visiblekelurahan = false;
    visibledaerahpemilihan = false;
    visibletempatlahir = false;
    visibletanggallahir = false;
    visibleRTValid = false;
    visibleRWValid = false;
    visiblealamatKTPValid = false;
    visiblenotps = false;
    visbletargetpendukungkosong = false;
    visibleEmailcek = false;
    visiblenohp = false;
    visiblenohplengkap = false;
    visiblenohcek = false;
    visibleEmailCheck = false;
    visibleGenderValid = false;
    visibleAkunSudahTerdaftar = false;
    visibleharapancaleg = false;
    isLoading = false;
    visiblenohp9digit = false;
    });
    } else if (rwDomisilicontrolel.text.isEmpty) {
    setState(() {
    visiblealamatKTPValidDomisili = false;
    visibleRWValidDomisili = true;
    visibleRTValidDomisili = false;
    visiblekelurahanDomisili = false;
    visiblejmlpemilih = false;
    visiblenamavalid = false;
    visiblenamavalid = false;
    visibleEmailValid = false;
    visiblepasswordValid = false;
    visiblenikValid = false;
    visiblenik16Valid = false;
    visibleagamaValid = false;
    visiblekawin = false;
    visiblepekerjaanValid = false;
    visiblepilihprofinsi = false;
    visiblepkota = false;
    visiblekecamatan = false;
    visiblekelurahan = false;
    visibledaerahpemilihan = false;
    visibletempatlahir = false;
    visibletanggallahir = false;
    visibleRTValid = false;
    visibleRWValid = false;
    visiblealamatKTPValid = false;
    visiblenotps = false;
    visbletargetpendukungkosong = false;
    visibleEmailcek = false;
    visiblenohp = false;
    visiblenohplengkap = false;
    visiblenohcek = false;
    visibleEmailCheck = false;
    visibleGenderValid = false;
    visibleAkunSudahTerdaftar = false;
    visibleharapancaleg = false;
    isLoading = false;
    visiblenohp9digit = false;
    });
    } else if (alamatktpDomisilicontrolel.text.isEmpty) {
    setState(() {
    visiblealamatKTPValidDomisili = true;
    visibleRWValidDomisili = false;
    visibleRTValidDomisili = false;
    visiblekelurahanDomisili = false;
    visiblejmlpemilih = false;
    visiblenamavalid = false;
    visiblenamavalid = false;
    visibleEmailValid = false;
    visiblepasswordValid = false;
    visiblenikValid = false;
    visiblenik16Valid = false;
    visibleagamaValid = false;
    visiblekawin = false;
    visiblepekerjaanValid = false;
    visiblepilihprofinsi = false;
    visiblepkota = false;
    visiblekecamatan = false;
    visiblekelurahan = false;
    visibledaerahpemilihan = false;
    visibletempatlahir = false;
    visibletanggallahir = false;
    visibleRTValid = false;
    visibleRWValid = false;
    visiblealamatKTPValid = false;
    visiblenotps = false;
    visbletargetpendukungkosong = false;
    visibleEmailcek = false;
    visiblenohp = false;
    visiblenohplengkap = false;
    visiblenohcek = false;
    visibleEmailCheck = false;
    visibleGenderValid = false;
    visibleAkunSudahTerdaftar = false;
    visibleharapancaleg = false;
    isLoading = false;
    visiblenohp9digit = false;
    });
    } else {
    setState(() {
    visiblealamatKTPValidDomisili = false;
    visibleRWValidDomisili = false;
    visibleRTValidDomisili = false;
    visiblekelurahanDomisili = false;
    visibleharapancaleg = false;
    visiblenamavalid = false;
    visiblenamavalid = false;
    visiblejmlpemilih = false;
    visibleEmailValid = false;
    visiblepasswordValid = false;
    visiblenikValid = false;
    visiblenik16Valid = false;
    visibleagamaValid = false;
    visiblekawin = false;
    visiblepekerjaanValid = false;
    visiblepilihprofinsi = false;
    visiblepkota = false;
    visiblekecamatan = false;
    visiblekelurahan = false;
    visibledaerahpemilihan = false;
    visibletempatlahir = false;
    visibletanggallahir = false;
    visibleRTValid = false;
    visibleRWValid = false;
    visiblealamatKTPValid = false;
    visiblenotps = false;
    visbletargetpendukungkosong = false;
    visibleEmailcek = false;
    visiblenohp = false;
    visiblenohplengkap = false;
    visiblenohcek = false;
    visibleEmailCheck = false;
    visibleGenderValid = false;
    visibleAkunSudahTerdaftar = false;
    visiblenohp9digit = false;
    isLoading = false;
    ceknohp();
    });
    }
  }

  ceknohp() async {
    Map data = {'usrhp': "62" + nohpcontrolel.text};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/ceknohp.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        if (jsonResponse['data'] == null) {
          setState(() async {
            visiblenohcek = false;

            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setString("jumlahpemilih", jumlahpemilihcontrolel.text);
            prefs.setString("alamatsama", radioButtonAlamat2Item);

            prefs.setString("namaregister", namacontrolel.text);
            prefs.setString("gender", radioButtonItem);

            prefs.setString("nohpregister", "62" + nohpcontrolel.text);
            // prefs.setString("kodereferal", kodereveralcontrolel.text);
            prefs.setString("passwordregister", passwordcontrolel.text);
            // prefs.setString("tempatlahirregis", tempatlahircontrolel.text);
            prefs.setString("umur", tanggallahircontrolel.text);

            if (radioButtonAlamat2Item == "Y") {
              setState(() {
                prefs.setString(
                    "kelurahantext", kelurahantext );
                prefs.setString(
                    "kecamatantext", kecamatantext);
                prefs.setString(
                    "kotatext", kotatext );
                prefs.setString(
                    "profinsitext", profinsitext);

                prefs.setString("kelurahanDomisilitext",
                    kelurahantext);
                prefs.setString("kecamatanDomisilitext",
                    kecamatantext);
                prefs.setString(
                    "kotaDomisilitext", kotatext);
                prefs.setString("profinsiDomisilitext",
                    profinsitext);

                prefs.setString("rw1register", rwcontrolel.text);
                prefs.setString("rt1register", rtcontrolel.text);
                prefs.setString("alamatktp1register", alamatktpcontrolel.text);

                prefs.setString("rw2register", rwcontrolel.text);
                prefs.setString("rt2register", rtcontrolel.text);
                prefs.setString("alamatktp2register", alamatktpcontrolel.text);
              });

            } else {
              setState(() {
                prefs.setString(
                    "kelurahantext", kelurahantext );
                prefs.setString(
                    "kecamatantext", kecamatantext);
                prefs.setString(
                    "kotatext", kotatext );
                prefs.setString(
                    "profinsitext", profinsitext);

                prefs.setString("kelurahanDomisilitext",
                    kelurahanDomisilitext);
                prefs.setString("kecamatanDomisilitext",
                    kecamatanDomisilitext);
                prefs.setString(
                    "kotaDomisilitext", kotaDomisilitext);
                prefs.setString("profinsiDomisilitext",
                    profinsiDomisilitext);

                prefs.setString("rw1register", rwcontrolel.text);
                prefs.setString("rt1register", rtcontrolel.text);
                prefs.setString("alamatktp1register", alamatktpcontrolel.text);

                prefs.setString("rw2register", rwDomisilicontrolel.text);
                prefs.setString("rt2register", rtDomisilicontrolel.text);
                prefs.setString(
                    "alamatktp2register", alamatktpDomisilicontrolel.text);
              });

            }

            prefs.setString("notpsgister", notpscontrolel.text);
            prefs.setString("usrvt", "-");
            prefs.setString("usrvt2", "-");
            prefs.setString("usrapc", "-");
            prefs.setString("usrbpd", "-");
            prefs.setString("usrput", "-");
            prefs.setString("usrtrp", "-");

            if (emailcontrolel.text.isNotEmpty) {
              prefs.setString("emailregister", emailcontrolel.text);
            } else {
              prefs.setString("emailregister", "-");
            }
            if (nikcontrolell.text.isNotEmpty) {
              prefs.setString("nikregister", nikcontrolell.text);
            } else {
              prefs.setString("nikregister", "-");
            }
            if (harapancalegcontrolel.text.isNotEmpty) {
              prefs.setString("harapancaleg", harapancalegcontrolel.text);
            } else {
              prefs.setString("harapancaleg", "-");
            }

            if (targetpendukungcontrolel.text.isNotEmpty) {
              prefs.setString("targetpendukung", targetpendukungcontrolel.text);
            } else {
              prefs.setString("targetpendukung", "0");
            }

            if (bidangutamaconterolel.text.isNotEmpty) {
              prefs.setString("bidangutama", bidangutamaconterolel.text);
            } else {
              prefs.setString("bidangutama", "-");
            }
            // if (prefs.getString('fotoktpregister') != "") {
            //   fotoktpregister = prefs.getString('fotoktpregister')!;
            // } else {
            //   fotoktpregister = prefs.getString('fotoktpkosong')!;
            // }
            // if (prefs.getString('fotoregister') != "") {
            //   foto = prefs.getString('fotoregister')!;
            // } else {
            //   foto = prefs.getString('fotouserkosong')!;
            // }
            //
            // registerdatafull();

            // int startIndex = 0;
            // int endIndex = 4;
            // DateTime waktuIni = DateTime.now();
            // String umur =
            //     tanggallahircontrolel.text.substring(startIndex, endIndex);
            // DateTime waktuMasukan = DateTime(int.parse(umur), 10, 28);
            // String umurusr = "${waktuIni.year - waktuMasukan.year}";
            // prefs.setString("umur", umurusr);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>PReviewIamgePage()),
            );

            // await availableCameras().then((value) => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (_) => CameraKTPPage(cameras: value))));
          });
        } else {
          setState(() {
            visiblenohcek = true;
          });
        }
        //  prefs.setString("token", jsonResponse['data']['nohp']);
      }
    }
  }

  void _showOptionsDialogbidangutama(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(),
          content: DropdownButton<String>(
            value: dropdownbidangutamavalue,
            onChanged: (newValue) {
              setState(() {
                dropdownbidangutamavalue = newValue!;
                bidangutamaconterolel.text = dropdownbidangutamavalue;
              });
              Navigator.of(context).pop(); // Close the dialog
            },
            items:
                itemsbidangutama.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }

// registerdatafull() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String nikregister = prefs.getString("nikregister")!;
//   String namaregister = prefs.getString("namaregister")!;
//   String gender = prefs.getString("gender")!;
//   String emailregister = prefs.getString("emailregister")!;
//   String nohpregister = prefs.getString("nohpregister")!;
//   String kodereferal = prefs.getString("kodereferal")!;
//   String passwordregister = prefs.getString("passwordregister")!;
//   // String tempatlahirregis = prefs.getString("tempatlahirregis")!;
//   String tanggallahirregis = prefs.getString("tanggallahirregis")!;
//   // String agamaregister = prefs.getString("agamaregister")!;
//   // String statuskawinregis = prefs.getString("statuskawinregis")!;
//   // String pekerjaanregister = prefs.getString("pekerjaanregister")!;
//   String daerahpemilihan = prefs.getString("daerahpemilihantext")!;
//   String profinsi1register = prefs.getString("profinsitext")!;
//   String kota1register = prefs.getString("kotatext")!;
//   String kecamatan1register = prefs.getString("kecamatantext")!;
//   String kelurahan1register = prefs.getString("kelurahantext")!;
//   String rw1register = prefs.getString("rw1register")!;
//   String rt1register = prefs.getString("rt1register")!;
//   String alamatktp1register = prefs.getString("alamatktp1register")!;
//   String profinsiDomisiliregister =
//   prefs.getString("profinsiDomisilitext")!;
//   String kotaDomisilitext = prefs.getString("kotaDomisilitext")!;
//   String kecamatanDomisilitext = prefs.getString("kecamatanDomisilitext")!;
//   String kelurahanDomisilitext = prefs.getString("kelurahanDomisilitext")!;
//   String rw2register = prefs.getString("rw2register")!;
//   String rt2register = prefs.getString("rt2register")!;
//   String alamatktp2register = prefs.getString("alamatktp2register")!;
//   String umur = prefs.getString("umur")!;
//   String usrvt = prefs.getString("usrvt")!;
//   String usrvt2 = prefs.getString("usrvt2")!;
//   String usrapc = prefs.getString("usrapc")!;
//   String usrbpd = prefs.getString("usrbpd")!;
//   String usrput = prefs.getString("usrput")!;
//   String usrtrp = prefs.getString("usrtrp")!;
//   String notpsgister = prefs.getString("notpsgister")!;
//   // String foto = prefs.getString('fotoregister')!;
//   String statusreferal = prefs.getString('statusreferal')!;
//   String kodecaleg = prefs.getString('kodecaleg')!;
//   String nohprelawanregister = prefs.getString('nohprelawanregister')!;
//   String targetpendukung = prefs.getString('targetpendukung')!;
//   String jumlahpemilih = prefs.getString('jumlahpemilih')!;
//   String harapancaleg = prefs.getString('harapancaleg')!;
//   // String fotoktpregister = prefs.getString('fotoktpregister')!;
//   String alamatsama = prefs.getString('alamatsama')!;
//
//
//
//   DateFormat dateFormat = DateFormat("yyyy-MM-dd");
//   DateFormat timeformat = DateFormat("HH:mm:ss");
//   String createDate = dateFormat.format(DateTime.now());
//   String createtime = timeformat.format(DateTime.now());
//   Map data = {
//     'usrhrc': harapancaleg,
//     'usrstal': alamatsama,
//     'usrfktp': fotoktpregister,
//     'usrjpm': jumlahpemilih,
//     'usrhpr': nohprelawanregister,
//     'usrvt': usrvt,
//     'usrvt2': usrvt2,
//     'usrtpd': targetpendukung,
//     'usrapc': usrapc,
//     'usrbpd': usrbpd,
//     'usrput': usrput,
//     'usrtrp': usrtrp,
//     'umr': umur,
//     'usrsts': statusreferal,
//     'usrkc': kodecaleg,
//     'usrnik': nikregister,
//     'usrnm': namaregister,
//     'usrjk': gender,
//     'usrema': emailregister,
//     'usrhp': nohpregister,
//     'usrkp': kodereferal,
//     'usrpas': passwordregister,
//     'usrtlh': tanggallahirregis,
//     'usrdpl': daerahpemilihan,
//     'usrpr1': profinsi1register,
//     'usrkt1': kota1register,
//     'usrkec1': kecamatan1register,
//     'usrkel1': kelurahan1register,
//     'usrrw1': rw1register,
//     'usrrt1': rt1register,
//     'usralm1': alamatktp1register,
//     'usrpr2': profinsiDomisiliregister,
//     'usrkt2': kotaDomisilitext,
//     'usrkec2': kecamatanDomisilitext,
//     'usrkel2': kelurahanDomisilitext,
//     'usrrw2': rw2register,
//     'usrrt2': rt2register,
//     'usralm2': alamatktp2register,
//     'usrtps': notpsgister,
//     'usrft': foto,
//     'usrdd': createDate,
//     'usrtd': createtime,
//     'usrsta': "A",
//   };
//
//   dynamic jsonResponse;
//   var response = await http.post(
//       Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/register.php"),
//       body: data);
//   if (response.statusCode == 200) {
//     jsonResponse = json.decode(response.body);
//     if (jsonResponse != null) {
//       setState(() {
//         sendEmail();
//         dialogregisterberhasil();
//         isLoading = false;
//       });
//
//
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Daftar gagal, periksa jaringan anda!")));
//     }
//   } else {}
// }
//
// //
// Future sendEmail() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //  String emailregister = prefs.getString('emailregister')!;
//   // String namauser= prefs.getString("namaregister")!;
//   String namaregister = prefs.getString("namaregister")!;
//   // final int min = 1000;
//   // final int max = 9999;
//   // var otpcodee = new Random().nextInt((max - min) + 1) + min;
//   // var otpacak = otpcodee.toString();
//
//   final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//   const serviceId = 'service_ae3hebe';
//   const templateId = 'template_yn06mpd';
//   const userId = 'BDXVKB6k_Bfwu0_YT';
//   final response = await http.post(url,
//       headers: {
//         'Content-Type': 'application/json',
//         'origin': 'http://localhost'
//       }, //This line makes sure it works for all platforms.
//       body: json.encode({
//         'service_id': serviceId,
//         'template_id': templateId,
//         'user_id': userId,
//         'template_params': {
//           'to_name': " ",
//           'from_name': "AyoCaleg",
//           'to_email': "g7.teknologi@gmail.com",
//           'message': "Daftar Baru " + namaregister
//         }
//       }));
//
//   if (response.statusCode == 200) {
//     // setState(() {
//     //   visibleBtnResend = false;
//     //     prefs.setString('otpregis', otpacak);
//     // });
//   }
//   // return response.statusCode;
// }
//
// Future dialogregisterberhasil() {
//   return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Image.asset(
//           'assets/images/otpp.png',
//           height: 100,
//           width: 100,
//         ),
//         content: const Text(
//             "Pendaftaran Berhasil"),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('OK'),
//             onPressed: () {
//               setState(() {
//                 Navigator.pop(context, false);
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) {
//                       return const LoginPage();
//                     }));
//               });
//             },
//           ),
//         ],
//       ));
// }
}
