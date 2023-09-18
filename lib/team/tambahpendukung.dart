// ignore_for_file: unused_local_variable, use_build_context_synchronously
// import 'package:ayoleg/camera.dart';
// import 'package:camera/camera.dart';
import 'package:ayoleg/camera.dart';
import 'package:ayoleg/camera_preview.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';
import 'package:ayoleg/team/camerapendukung.dart';
import 'package:ayoleg/team/pendukung.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/login.dart';
import 'package:ayoleg/otp/otp_page.dart';
import 'package:ayoleg/welcome/privacy_policy_register.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TambahPendukungPage extends StatefulWidget {
  TambahPendukungPage({Key? key}) : super(key: key);
  @override
  _TambahPendukungPageState createState() => _TambahPendukungPageState();
}

class _TambahPendukungPageState extends State<TambahPendukungPage> {
  bool loading = true;

// bool visiblenama = false;
  bool visiblenikValid = false;
  bool visiblenamavalid = false;
  bool visibleEmailValid = false;
  bool visiblepasswordValid = false;
  bool visiblekodereveralValid = false;
  bool visibleagamaValid = false;
  bool visiblekawin = false;
  bool visiblepekerjaanValid = false;
  bool visiblekelurahan = false;
  bool visiblenotps = false;
  bool visiblealamataktifitas = false;
  bool visibleEmailcek = false;
  bool visiblenohp = false;
  bool visiblenohplengkap = false;
  bool visiblenohcek = false;
  bool visibleEmailCheck = false;
  bool visibleGenderValid = false;
  bool visibleAkunSudahTerdaftar = false;
  bool isLoading = false;

  bool visiblepilihprofinsi = false;
  bool visiblepkota = false;
  bool visiblekecamatan = false;
  bool visibledaerahpemilihan = false;
  bool visibletempatlahir = false;
  bool visibletanggallahir = false;
  bool visibleRTValid = false;
  bool visibleRWValid = false;
  bool visiblealamatKTPValid = false;
  bool visiblepilihprofinsiAktifitas = false;
  bool visiblepkotaAktifitas = false;
  bool visiblekecamatanAktifitas = false;
  bool visiblekelurahanAktifitas = false;
  bool visibleRTValidAktifitas = false;
  bool visibleRWValidAktifitas = false;
  bool visiblealamatKTPValidAktifitas = false;

  late Future<List<Datadaerahpemilihan>> futuredaerahpemilihan;
  late Future<List<Datakelurahan>> futurekelurahan;
  late Future<List<Datakecamatan>> futurekecamatan;
  late Future<List<Dataprofinsi>> futureprofinsi;
  late Future<List<Datakota>> futurekota;
  late SharedPreferences sharedPrefs;

  String kodecaleg = "";
  String profinsitext = "";
  String kotatext = "";
  String kecamatantext = "";
  String kelurahantext = "";

  String profinsiaktifitastext = "";
  String kotaaktifitastext = "";
  String kecamatanaktifitastext = "";
  String kelurahanaktifitastext = "";

  String daerahpemilihantext = "";

  String validprofinsi = "";
  String validkota = "";
  String validkelurahan = "";
  String validkecamatan = "";

  String validprofinsiaktifitas = "";
  String validkotaaktifitas = "";
  String validkelurahanaktifitas = "";
  String validkecamatanaktifitas = "";

  String validdaerahpemilihan = "";
  String tanggallahirtext = "";
  String kodereveral = "";
  String Statusreferal = "";

  String resultkdcaleg = "";
  String kodecal = "";


  @override
  void initState() {
    _valuaalamat2 = 1;
    _valupindahpartai = 2;
    _valupindahcaleg = 2;

    profinsitext = "Pilih Provinsi....";
    kotatext = "Pilih Kota....";
    kecamatantext = "Pilih Kecamatan....";
    kelurahantext = "Pilih Kelurahan....";

    profinsiaktifitastext = "Pilih Provinsi Aktifitas....";
    kotaaktifitastext = "Pilih Kota Aktifitas....";
    kecamatanaktifitastext = "Pilih Kecamatan Aktifitas....";
    kelurahanaktifitastext = "Pilih Kelurahan Aktifitas....";

    daerahpemilihantext = "Pilih Daerah Pemilihan....";

    kodecal = "";

    // tanggallahirtext = "Pilih Tanggal Lahir....";
    validprofinsi = "";
    validkota = "";
    validkecamatan = "";
    validkelurahan = "";

    validprofinsiaktifitas = "";
    validkotaaktifitas = "";
    validkecamatanaktifitas = "";
    validkelurahanaktifitas = "";

    validdaerahpemilihan = "";

    futureprofinsi = fetchGetDataprofinsi();


    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);

      kodecaleg = prefs.getString('kodecaleg')!;
      futuredaerahpemilihan = fetchGetDatadaerahpemilihan(kodecaleg);
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
  int? _valupindahcaleg;
  int? _valupindahpartai;



  int? _valuestatusperkawinan;

  var nikcontrolell = TextEditingController();
  var namacontrolel = TextEditingController();
  var emailcontrolel = TextEditingController();
  var passwordcontrolel = TextEditingController();
  var kodereveralcontrolel = TextEditingController();
  var agamacontrolel = TextEditingController();
  var pekerjaancontrolel = TextEditingController();
  var tempatlahircontrolel = TextEditingController();
  var tanggallahircontrolel = TextEditingController();
  var rtcontrolel = TextEditingController();
  var rwcontrolel = TextEditingController();
  var alamatktpcontrolel = TextEditingController();

  var alamatktpaktifitascontrolel = TextEditingController();
  var rwaktifitascontrolel = TextEditingController();
  var rtaktifitascontrolel = TextEditingController();

  var notpscontrolel = TextEditingController();

  String radioButtonAlamat2Item = "Y";


  String radioButtonItem = "";
  String radioButtonagamaItem = "";
  String radioButtonstatusperkawinanItem = "";

  var nohpcontrolel = TextEditingController();
  String stringValue = "";
  bool value = false;

  Future<void> onBackPressed() async {
    setState(() {
      Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return const Pendukungpage();
                  }));
    });
  }

  // late final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    return WillPopScope(
      onWillPop: () async {
        onBackPressed(); // Action to perform on back pressed
        return false;
      },
      child: Stack(
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                            return const Pendukungpage();
                          }));
                      // Navigator.of(context).pop();
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
                    FadeInUp(
                      duration: Duration(milliseconds: 400),
                      child: Container(
                        width: 150,
                        height: 100,
                        child: Image.asset("assets/images/logocaleg.png"),
                      ),
                    ),
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
                  FadeInUp(
                    duration: Duration(milliseconds: 600),
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.65,
                      child: Image.asset('assets/images/Register.png'),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 13,
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
                          hintText: "*Masukkan NIK",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        maxLength: 16,
                        keyboardType: TextInputType.number,
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
                        'Masukkan NIK Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
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
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 13,
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
                          fillColor: whitePrimary,
                          hintText: "*Masukkan NAMA Sesuai KTP",
                          hintStyle: TextStyle(
                              fontFamily: 'poppins', color: greyPrimary),
                          filled: true,
                        ),
                        // validator: (valueName) {
                        //   if (valueName == null || valueName.length < 5) {
                        //     return 'Nama Harus Lebih 5 Karakter';
                        //   }
                        //   return null;
                        // },
                        textInputAction: TextInputAction.done,
                        // onFieldSubmitted: (val) {
                        //   _saveForm();
                        // },
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
                        'Masukkan NAMA Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'Pilih Jenis Kelamin',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 900),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
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
                        'Pilih JENIS KELAMIN Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
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
                          hintText: "Masukkan Alamat EMAIL",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
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
                        'Masukkan EMAIL Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
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
                            fontSize: 13),
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
                            fontSize: 13),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1200),
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
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visiblenohp,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: Text(
                        'Masukkan No. HP Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
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
                            fontSize: 13),
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
                            fontSize: 13),
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
                            fontSize: 13),
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
                        controller: tempatlahircontrolel,
                        textCapitalization: TextCapitalization.sentences,
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
                            Icons.home_filled,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          hintText: "*Tempat Lahir",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibletempatlahir,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan Tempat Lahir Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),

                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: TextField(
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 14,
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
                                Icons.calendar_today,
                                color: greenPrimary,
                              ),
                              labelText: "Pilih Tanggal Lahir"),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary:
                                        greenPrimary, // header background color
                                        onPrimary:
                                        Colors.black, // header text color
                                        onSurface:
                                        Colors.green, // body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                          greenPrimary, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                tanggallahircontrolel.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        )),
                  ),
                  Visibility(
                    visible: visibletanggallahir,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan Tanggal Lahir Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text(
                      'Pilih Agama',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  wigetagama(),

                  Visibility(
                    visible: visibleagamaValid,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Pilih Agama Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text(
                      'Pilih Status Perkawinan',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  wigetstatusperkawinan(),

                  Visibility(
                    visible: visiblekawin,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Pilih Status Perkawinan Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
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
                        controller: pekerjaancontrolel,
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
                            Icons.run_circle_outlined,
                            color: greenPrimary,
                          ),
                          fillColor: whitePrimary,
                          hintText: "Masukkan Pekerjaan",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
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
                    visible: visiblepekerjaanValid,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan Pekerjaan Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'Pilih Daerah Pemilihan',
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
                            width: 280,
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
                                    // kodereveral = kodereveralcontrolel.text;
                                    // int startIndex = 0;
                                    // int endIndex = 4;
                                    //
                                    // resultkdcaleg = kodereveral.substring(
                                    //     startIndex, endIndex);
                                    // kodecal = resultkdcaleg + "0";
                                    // futuredaerahpemilihan =
                                    //     fetchGetDatadaerahpemilihan(kodecal);

                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    bottomdialogdaerahpemilihan();
                                  });
                                },
                                child: Text(daerahpemilihantext,
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
                            fontSize: 13),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'Pilih Provinsi',
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
                    child: const Padding(
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'Pilih Kota',
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
                    child: const Padding(
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'Pilih Kecamatan',
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
                    child: const Padding(
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'Pilih Kelurahan',
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
                    child: const Padding(
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
                          hintText: "Masukkan RT",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
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
                    visible: visibleRTValid,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan RT Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
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
                          hintText: "Masukkan RW",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
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
                    visible: visibleRWValid,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan RW Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
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
                          hintText: "Masukkan Alamat KTP",
                          hintStyle: TextStyle(color: greyPrimary),
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
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
                    visible: visiblealamatKTPValid,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                      child: Text(
                        'Masukkan Alamat KTP Anda !',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Apakah Alamat KTP Anda Sama Dengan Alamat Sekarang ?',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
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

                                    visiblealamataktifitas = false;
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

                                    visiblealamataktifitas = true;
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
                    visible: visiblealamataktifitas,
                    child: alamataktifitas(),
                  ),

                  //alamat 2

                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.center,
                            margin:
                            const EdgeInsets.only(left: 30.0, right: 0.0),
                            child: TextFormField(
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
                                hintText: "No TPS",
                                hintStyle: TextStyle(color: greyPrimary),
                                filled: true,
                              ),
                              keyboardType: TextInputType.number,
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
                                setState(() async {
                                  isLoading = false;
                                  const url = 'https://cekdptonline.kpu.go.id/';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    throw 'Could not launch $url';
                                  }
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
                                        fontSize: 12,
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
                        'Masukan No TPS !',
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
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                      width: 250,
                      child: Text(
                        'Apakah Anda Akan Ada Kemungkinan Pindah Dukungan Caleg ?',
                        style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                  //
                  // FadeInUp(
                  //   duration: Duration(milliseconds: 900),
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 50),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Radio(
                  //               activeColor: greenPrimary,
                  //               value: 1,
                  //               groupValue: _valupindahcaleg,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   radioButtoncalegItem = 'Y';
                  //                   _valupindahcaleg = 1;
                  //
                  //                 });
                  //               },
                  //             ),
                  //             // const Icon(
                  //             //   Icons.male,
                  //             //   color: Colors.blueAccent,
                  //             // ),
                  //             const Text(
                  //               'Ya',
                  //               style: TextStyle(
                  //                   fontFamily: 'poppins',
                  //                   color: greenPrimary,
                  //                   fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         ),
                  //         Row(
                  //           children: [
                  //             Radio(
                  //               activeColor: greenPrimary,
                  //               value: 2,
                  //               groupValue: _valupindahcaleg,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   radioButtoncalegItem = 'T';
                  //                   _valupindahcaleg = 2;
                  //
                  //                 });
                  //               },
                  //             ),
                  //             // const Icon(
                  //             //   Icons.female,
                  //             //   color: Colors.pinkAccent,
                  //             // ),
                  //             const Text(
                  //               'Tidak',
                  //               style: TextStyle(
                  //                   fontFamily: 'poppins',
                  //                   color: greenPrimary,
                  //                   fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //
                  //     alignment: Alignment.topLeft,
                  //     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  //     width: 250,
                  //     child: Text(
                  //       'Apakah Anda Akan Ada Kemungkinan Pindah Dukungan Partai ?',
                  //       style: const TextStyle(
                  //         fontFamily: 'poppins',
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //       ),
                  //     )),
                  //
                  // FadeInUp(
                  //   duration: Duration(milliseconds: 900),
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 50),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Radio(
                  //               activeColor: greenPrimary,
                  //               value: 1,
                  //               groupValue: _valupindahpartai,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   radioButtonpindahpartaiItem = 'Y';
                  //                   _valupindahpartai = 1;
                  //
                  //                 });
                  //               },
                  //             ),
                  //             // const Icon(
                  //             //   Icons.male,
                  //             //   color: Colors.blueAccent,
                  //             // ),
                  //             const Text(
                  //               'Ya',
                  //               style: TextStyle(
                  //                   fontFamily: 'poppins',
                  //                   color: greenPrimary,
                  //                   fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         ),
                  //         Row(
                  //           children: [
                  //             Radio(
                  //               activeColor: greenPrimary,
                  //               value: 2,
                  //               groupValue: _valupindahpartai,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   radioButtonpindahpartaiItem = 'T';
                  //                   _valupindahpartai = 2;
                  //
                  //                 });
                  //               },
                  //             ),
                  //             // const Icon(
                  //             //   Icons.female,
                  //             //   color: Colors.pinkAccent,
                  //             // ),
                  //             const Text(
                  //               'Tidak',
                  //               style: TextStyle(
                  //                   fontFamily: 'poppins',
                  //                   color: greenPrimary,
                  //                   fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  //

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
                          minimumSize: const Size(130, 50), //////// HERE
                        ),
                        onPressed: () {
                          setState(() {
                            checkEmpty();
                            isLoading = true;

                            // kodereveral = kodereveralcontrolel.text;
                            // int startIndex = 0;
                            // int endIndex = 4;
                            //
                            // resultkdcaleg =
                            //     kodereveral.substring(startIndex, endIndex);
                            // kodecal = resultkdcaleg;
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

    final size = MediaQuery
        .of(context)
        .size;
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
                            'Belum Ada Pesan',
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
    final size = MediaQuery
        .of(context)
        .size;
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
                            'Belum Ada Pesan',
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
    final size = MediaQuery
        .of(context)
        .size;
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
                            'Belum Ada Pesan',
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
    final size = MediaQuery
        .of(context)
        .size;
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
                                  "kelurahantext", ' ${data[index].klds!}');
                              prefs.setString("kelurahanaktifitastext",
                                  ' ${data[index].klds!}');
                              kelurahantext = ' ${data[index].klds!}';
                              validkelurahan = ' ${data[index].klds!}';
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
                            'Belum Ada Pesan',
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

  bottomdialogprofinsiaktifitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final size = MediaQuery
        .of(context)
        .size;
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
                                prefs.setString("profinsiaktifitastext",
                                    '${data[index].prds!}');

                                profinsiaktifitastext = '${data[index].prds!}';
                                validprofinsiaktifitas =
                                '${data[index].prds!}';

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
                            'Belum Ada Pesan',
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

  bottomdialogkotaaktifitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery
        .of(context)
        .size;
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
                                    ' ${data[index].ktds!}');
                                kotaaktifitastext = ' ${data[index].ktds!}';
                                validkotaaktifitas = ' ${data[index].ktds!}';
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
                            'Belum Ada Pesan',
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

  bottomdialogkecamatanaktifitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery
        .of(context)
        .size;
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
                                prefs.setString("kecamatanaktifitastext",
                                    '${data[index].kcds!}');
                                kecamatanaktifitastext =
                                '${data[index].kcds!}';
                                validkecamatanaktifitas =
                                '${data[index].kcds!}';
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
                            'Belum Ada Pesan',
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

  bottomdialogkelurahanaktifitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery
        .of(context)
        .size;
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
                              prefs.setString("kelurahanaktifitastext",
                                  '${data[index].klds!}');
                              kelurahanaktifitastext = '${data[index].klds!}';
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
                            'Belum Ada Pesan',
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

  Widget alamataktifitas() {
    return Container(
        margin: const EdgeInsets.only(left: 50.0, right: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                'Pilih Provinsi Aktifitas',
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
                            bottomdialogprofinsiaktifitas();
                          },
                          child: Text(profinsiaktifitastext,
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
              visible: visiblepilihprofinsiAktifitas,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Pilih Provinsi Aktifitas!',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                'Pilih Kota Aktifitas',
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
                          border: Border.all(width: 2, color: greenPrimary),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(children: [
                        Icon(
                          Icons.location_city_outlined,
                          color: greenPrimary,
                        ),
                        TextButton(
                          onPressed: () {
                            if (validprofinsiaktifitas.isEmpty) {
                              setState(() {
                                visiblepilihprofinsiAktifitas = true;
                              });
                            } else {
                              setState(() {
                                visiblepilihprofinsiAktifitas = false;
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                bottomdialogkotaaktifitas();
                              });
                            }
                          },
                          child: Text(kotaaktifitastext,
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
              visible: visiblepkotaAktifitas,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Pilih Kota Aktifitas!',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                'Pilih Kecamatan Aktifitas',
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
                            if (validkotaaktifitas.isEmpty) {
                              setState(() {
                                visiblepkotaAktifitas = true;
                              });
                            } else {
                              setState(() {
                                visiblepkotaAktifitas = false;
                              });
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              bottomdialogkecamatanaktifitas();
                            }
                          },
                          child: Text(kecamatanaktifitastext,
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
              visible: visiblekecamatanAktifitas,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Pilih Kecamatan Aktifitas!',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                'Pilih Kelurahan Aktifitas',
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
                            if (validkecamatanaktifitas.isEmpty) {
                              setState(() {
                                visiblekecamatanAktifitas = true;
                              });
                            } else {
                              setState(() {
                                visiblekecamatanAktifitas = false;
                              });
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              bottomdialogkelurahanaktifitas();
                            }
                          },
                          child: Text(kelurahanaktifitastext,
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
              visible: visiblekelurahanAktifitas,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Pilih Kelurahan Aktifitas!',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
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
                  controller: rtaktifitascontrolel,
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
                    hintText: "Masukkan RT Aktifitas",
                    hintStyle: TextStyle(color: greyPrimary),
                    filled: true,
                  ),
                  keyboardType: TextInputType.text,
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
              visible: visibleRTValidAktifitas,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Masukkan RT Aktifitas Anda !',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
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
                  controller: rwaktifitascontrolel,
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
                    hintText: "Masukkan RW Aktifitas",
                    hintStyle: TextStyle(color: greyPrimary),
                    filled: true,
                  ),
                  keyboardType: TextInputType.text,
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
              visible: visibleRWValidAktifitas,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Masukkan RW Anda Aktifitas!',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
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
                  controller: alamatktpaktifitascontrolel,
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
                    hintText: "Masukkan Alamat KTP Aktifitas",
                    hintStyle: TextStyle(color: greyPrimary),
                    filled: true,
                  ),
                  keyboardType: TextInputType.text,
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
              visible: visiblealamatKTPValidAktifitas,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  'Masukkan Alamat KTP Anda Aktifitas!',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ),
          ],
        ));
  }

  bottomdialogdaerahpemilihan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final size = MediaQuery
        .of(context)
        .size;
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
                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        });
  }

  Widget wigetagama() {
    return Column(
      children: [
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
                      groupValue: _valuagama,
                      onChanged: (value) {
                        setState(() {
                          radioButtonagamaItem = 'Islam';
                          _valuagama = 1;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.male,
                    //   color: Colors.blueAccent,
                    // ),
                    const Text(
                      'Islam',
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
                      groupValue: _valuagama,
                      onChanged: (value) {
                        setState(() {
                          radioButtonagamaItem = 'Kristen';
                          _valuagama = 2;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.female,
                    //   color: Colors.pinkAccent,
                    // ),
                    const Text(
                      'Kristen',
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
                      value: 3,
                      groupValue: _valuagama,
                      onChanged: (value) {
                        setState(() {
                          radioButtonagamaItem = 'Katolik';
                          _valuagama = 3;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.female,
                    //   color: Colors.pinkAccent,
                    // ),
                    const Text(
                      'Katolik',
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
                      value: 4,
                      groupValue: _valuagama,
                      onChanged: (value) {
                        setState(() {
                          radioButtonagamaItem = 'Hindu';
                          _valuagama = 4;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.female,
                    //   color: Colors.pinkAccent,
                    // ),
                    const Text(
                      'Hindu',
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
                      value: 5,
                      groupValue: _valuagama,
                      onChanged: (value) {
                        setState(() {
                          radioButtonagamaItem = 'Budha';
                          _valuagama = 5;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.female,
                    //   color: Colors.pinkAccent,
                    // ),
                    const Text(
                      'Budha',
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
                      value: 6,
                      groupValue: _valuagama,
                      onChanged: (value) {
                        setState(() {
                          radioButtonagamaItem = 'Lainnya';
                          _valuagama = 6;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.female,
                    //   color: Colors.pinkAccent,
                    // ),
                    const Text(
                      'Lainnya',
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
      ],
    );
  }

  Widget wigetstatusperkawinan() {
    return Column(
      children: [
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
                      groupValue: _valuestatusperkawinan,
                      onChanged: (value) {
                        setState(() {
                          radioButtonstatusperkawinanItem = 'Belum Kawin';
                          _valuestatusperkawinan = 1;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.male,
                    //   color: Colors.blueAccent,
                    // ),
                    const Text(
                      'Belum Kawin',
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
                      groupValue: _valuestatusperkawinan,
                      onChanged: (value) {
                        setState(() {
                          radioButtonstatusperkawinanItem = 'Kawin';
                          _valuestatusperkawinan = 2;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.female,
                    //   color: Colors.pinkAccent,
                    // ),
                    const Text(
                      'Kawin',
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
                      value: 3,
                      groupValue: _valuestatusperkawinan,
                      onChanged: (value) {
                        setState(() {
                          radioButtonstatusperkawinanItem = 'Cerai Hidup';
                          _valuestatusperkawinan = 3;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.female,
                    //   color: Colors.pinkAccent,
                    // ),
                    const Text(
                      'Cerai Hidup',
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
                      value: 4,
                      groupValue: _valuestatusperkawinan,
                      onChanged: (value) {
                        setState(() {
                          radioButtonstatusperkawinanItem = 'Cerai Mati';
                          _valuestatusperkawinan = 4;
                        });
                      },
                    ),
                    // const Icon(
                    //   Icons.female,
                    //   color: Colors.pinkAccent,
                    // ),
                    const Text(
                      'Cerai Mati',
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
      ],
    );
  }

  checkEmpty() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (nikcontrolell.text.isEmpty) {
      setState(() {
        visiblenikValid = true;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
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
        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;
        isLoading = false;
      });

    } else if (namacontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = true;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (radioButtonItem.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = true;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (emailcontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = true;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (nohpcontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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

        visibleEmailcek = false;
        visiblenohp = true;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    }
    else if (tempatlahircontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
        visibleagamaValid = false;
        visiblepekerjaanValid = false;
        visiblepilihprofinsi = false;
        visiblepkota = false;
        visiblekecamatan = false;
        visiblekelurahan = false;
        visibledaerahpemilihan = false;
        visibletempatlahir = true;
        visibletanggallahir = false;
        visibleRTValid = false;
        visibleRWValid = false;
        visiblealamatKTPValid = false;
        visiblekawin = false;
        visiblenotps = false;

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (tanggallahircontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (radioButtonagamaItem.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
        visibleagamaValid = true;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (radioButtonstatusperkawinanItem.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
        visibleagamaValid = false;
        visiblekawin = true;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (pekerjaancontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
        visibleagamaValid = false;
        visiblekawin = false;
        visiblepekerjaanValid = true;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (validkelurahan.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (rtcontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (rwcontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (alamatktpcontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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
        visiblealamatKTPValid = true;
        visiblenotps = false;

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else if (notpscontrolel.text.isEmpty) {
      setState(() {
        visiblenamavalid = false;
        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;
      });
    } else {
      setState(() async {
        // prefs.setString("usrvt", radioButtoncalegItem);
        // prefs.setString("usrvt2", radioButtonpindahpartaiItem);
        prefs.setString("nikregisterpendukung", nikcontrolell.text);
        prefs.setString("namaregisterpendukung", namacontrolel.text);
        prefs.setString("genderpendukung", radioButtonItem);
        prefs.setString("emailregisterpendukung", emailcontrolel.text);
        prefs.setString("nohpregisterpendukung", "62" + nohpcontrolel.text);
        // prefs.setString("kodereferal", kodereveralcontrolel.text);
        // prefs.setString("passwordregisterpendukung", passwordcontrolel.text);
        prefs.setString("tempatlahirregis", tempatlahircontrolel.text);
        prefs.setString("tanggallahirregis", tanggallahircontrolel.text);
        prefs.setString("agamaregister", radioButtonagamaItem);
        prefs.setString("statuskawinregis", radioButtonstatusperkawinanItem);
        prefs.setString("pekerjaanregister", pekerjaancontrolel.text);
        prefs.setString("daerahpemilihan", daerahpemilihantext);

        if (radioButtonAlamat2Item == "Y") {
          prefs.setString("rw1register", rwcontrolel.text);
          prefs.setString("rt1register", rtcontrolel.text);
          prefs.setString("alamatktp1register", alamatktpcontrolel.text);

          prefs.setString("rw2register", rwcontrolel.text);
          prefs.setString("rt2register", rtcontrolel.text);
          prefs.setString("alamatktp2register", alamatktpcontrolel.text);
        } else {
          prefs.setString("rw2register", rwaktifitascontrolel.text);
          prefs.setString("rt2register", rtaktifitascontrolel.text);
          prefs.setString(
              "alamatktp2register", alamatktpaktifitascontrolel.text);

          prefs.setString("rw1register", rwcontrolel.text);
          prefs.setString("rt1register", rtcontrolel.text);
          prefs.setString("alamatktp1register", alamatktpcontrolel.text);


        }

        prefs.setString("notpsgister", notpscontrolel.text);

        visiblenamavalid = false;
        visibleEmailValid = false;
        visiblepasswordValid = false;
        visiblekodereveralValid = false;
        visiblenikValid = false;
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
        visiblenotps = false;

        visibleEmailcek = false;
        visiblenohp = false;
        visiblenohplengkap = false;
        visiblenohcek = false;
        visibleEmailCheck = false;
        visibleGenderValid = false;
        visibleAkunSudahTerdaftar = false;

        isLoading = false;


        int startIndex = 0;
        int endIndex = 4;
        DateTime waktuIni = DateTime.now();
        String umur = tanggallahircontrolel.text.substring(
            startIndex, endIndex);
        DateTime waktuMasukan = DateTime(int.parse(umur),10,28);
        String umurusr = "${waktuIni.year - waktuMasukan.year}";
        prefs.setString(
            "umur",umurusr);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const PreviewPage()),
        // );
        await availableCameras().then((value) =>
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) => CameraPendukungPage(cameras: value))));
      });
    }
  }

  // cekkodecaleg(String kdkc) async {
  //   Map data = {'kdkc': kdkc + "0"};
  //
  //   dynamic jsonResponse;
  //   var response = await http.post(
  //       Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekkd.php"),
  //       body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //
  //     if (jsonResponse != null) {
  //       //  prefs.setString("token", jsonResponse['data']['nohp']);
  //
  //       setState(() async {
  //         if (jsonResponse['kodecaleg']['kdad'] == kodereveralcontrolel.text) {
  //           Statusreferal = "A";
  //         } else if (jsonResponse['kodecaleg']['kdrlw'] ==
  //             kodereveralcontrolel.text) {
  //           Statusreferal = "R";
  //         } else {
  //           Statusreferal = "S";
  //         }
  //
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //
  //
  //
  //
  //       });
  //     } else {}
  //   }

  phoneCheck() async {
    String nomor = "62" + nohpcontrolel.text;
    Map data = {
      'nohp': nomor,
    };
    dynamic jsonResponse;
    var response = await http
        .post(Uri.parse("https://ayoscan.id/api/ceknohp"), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse['dataceknohp'] != null) {
          setState(() {
            visiblenohcek = true;
            visibleEmailCheck = false;
            visibleEmailValid = false;
            visiblenohplengkap = false;
            visibleEmailcek = false;
            visiblenohp = false;

            visiblenamavalid = false;
            visibleGenderValid = false;
            visibleAkunSudahTerdaftar = false;
            isLoading = false;
          });
        } else {
          setState(() {
            visibleEmailCheck = false;
            visibleEmailValid = false;
            visiblenohcek = false;
            visiblenohplengkap = false;
            visibleEmailcek = false;
            visiblenohp = false;

            visiblenamavalid = false;
            visibleGenderValid = false;

            visibleAkunSudahTerdaftar = false;
            isLoading = false;

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const MyHomePage(title: 'Meglive')),
            // );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyRegister()),
            );
          });
        }
      }
    } else {
      setState(() {
        visibleEmailCheck = false;
        visibleEmailValid = false;
        visiblenohcek = false;
        visiblenohplengkap = false;
        visibleEmailcek = false;
        visiblenohp = false;

        visiblenamavalid = false;
        visibleGenderValid = false;
        isLoading = false;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => const MyHomePage(title: 'Meglive')),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const PrivacyPolicyRegister()),
        );
      });
    }
  }
  _launchURL() async {
    const url = 'https://cekdptonline.kpu.go.id/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

    // _launchcekdpt() async {
    //   const url = 'https://cekdptonline.kpu.go.id/';
    //   if (await canLaunch(url)) {
    //     await launch(url);
    //   } else {
    //     throw 'Could not launch $url';
    //   }
    // }


