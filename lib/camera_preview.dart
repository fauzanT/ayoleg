import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/camera.dart';
import 'package:ayoleg/cameraktp/cameraktp.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/login.dart';
import 'package:ayoleg/reveral.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PReviewIamgePage extends StatefulWidget {
  PReviewIamgePage({Key? key}) : super(key: key);

  @override
  _PReviewIamgePageState createState() => _PReviewIamgePageState();
}

class _PReviewIamgePageState extends State<PReviewIamgePage> {
  late final XFile picture;

  late SharedPreferences sharedPrefs;

  String fotoktp = "";
  String fotousr = "";
  String foto = "";
  String fotoktpregister = "";

  String nikregister = "";
  String namaregister = "";
  String gender = "";
  String emailregister = "";
  String nohpregister = "";
  String kodereferal = "";
  String passwordregister = "";
  String daerahpemilihan = "";
  String profinsi1register = "";
  String kota1register = "";
  String kecamatan1register = "";
  String kelurahan1register = "";
  String rw1register ="";
  String rt1register = "";
  String alamatktp1register = "";
  String profinsiDomisiliregister = "";
  String kotaDomisilitext = "";
  String kecamatanDomisilitext ="";
  String kelurahanDomisilitext = "";
  String rw2register = "";
  String rt2register = "";
  String alamatktp2register = "";
  String umur = "";
  String usrvt = "";
  String usrvt2 = "";
  String usrapc = "";
  String usrbpd = "";
  String usrput = "";
  String usrtrp = "";
  String notpsgister = "";
  String statusreferal = "";
  String kodecaleg = "";
  String nohprelawanregister = "";
  String targetpendukung = "";
  String jumlahpemilih = "";
  String harapancaleg = "";
  String alamatsama = "";
  String bidangutama ="";

  @override
  void initState() {

    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      fotousr = prefs.getString('fotoregister')!;
      fotoktp = prefs.getString('fotoktpregister')!;
       nikregister = prefs.getString("nikregister")!;
       namaregister = prefs.getString("namaregister")!;
       gender = prefs.getString("gender")!;
       emailregister = prefs.getString("emailregister")!;
       nohpregister = prefs.getString("nohpregister")!;
       kodereferal = prefs.getString("kodereferal")!;
       passwordregister = prefs.getString("passwordregister")!;
       daerahpemilihan = prefs.getString("daerahpemilihantext")!;
       profinsi1register = prefs.getString("profinsitext")!;
       kota1register = prefs.getString("kotatext")!;
       kecamatan1register = prefs.getString("kecamatantext")!;
       kelurahan1register = prefs.getString("kelurahantext")!;
       rw1register = prefs.getString("rw1register")!;
       rt1register = prefs.getString("rt1register")!;
       alamatktp1register = prefs.getString("alamatktp1register")!;
       
       profinsiDomisiliregister = prefs.getString("profinsiDomisilitext")!;
       kotaDomisilitext = prefs.getString("kotaDomisilitext")!;
       kecamatanDomisilitext = prefs.getString("kecamatanDomisilitext")!;
       kelurahanDomisilitext = prefs.getString("kelurahanDomisilitext")!;
       rw2register = prefs.getString("rw2register")!;
       rt2register = prefs.getString("rt2register")!;
       alamatktp2register = prefs.getString("alamatktp2register")!;
       umur = prefs.getString("umur")!;
       usrvt = prefs.getString("usrvt")!;
       usrvt2 = prefs.getString("usrvt2")!;
       usrapc = prefs.getString("usrapc")!;
       usrbpd = prefs.getString("usrbpd")!;
       usrput = prefs.getString("usrput")!;
       usrtrp = prefs.getString("usrtrp")!;
       notpsgister = prefs.getString("notpsgister")!;

       statusreferal = prefs.getString('statusreferal')!;
       kodecaleg = prefs.getString('kodecaleg')!;
       nohprelawanregister = prefs.getString('nohprelawanregister')!;
       targetpendukung = prefs.getString('targetpendukung')!;
       jumlahpemilih = prefs.getString('jumlahpemilih')!;
       harapancaleg = prefs.getString('harapancaleg')!;
       alamatsama = prefs.getString('alamatsama')!;
       bidangutama = prefs.getString('bidangutama')!;

      // if (prefs.getString('fotoktpregister') != "") {
      //   fotoktp = prefs.getString('fotoktpregister')!;
      // } else {
      //   fotoktp = "";
      // }
      // if (prefs.getString('fotoregister') != "") {
      //   fotousr = prefs.getString('fotoregister')!;
      // } else {
      //   fotousr = "";
      // }
    });
    super.initState();
  }

  bool isLoading = false;
  bool visible = false;
  Future<void> onBackPressed() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Reveralcodepage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    Uint8List bytesktp = base64.decode(fotoktp);
    Uint8List bytewajah = base64.decode(fotousr);
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
    child:
    Scaffold(
      appBar: AppBar(
        title: const Text('Foto'),
        backgroundColor: greenPrimary,
      ),
      body:  Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.only(
            left: 20.0, right: 0.0, top: 10),
        child:
        Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                  left: 20.0, right: 0.0, top: 10),
              child: Row(
                children: [
                  Text(
                    'Foto KTP',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.red,
                        fontSize: 8),
                  ),
                ],
              )),

          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                  left: 20.0, right: 0.0, top: 10),
              child: bytesktp.isEmpty
                  ? InkWell(
                child: Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      "assets/images/gambarnoncamera.png",
                      fit: BoxFit.cover,
                    )),
                onTap: () async {
                  await availableCameras().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CameraKTPPage(cameras: value))));},
              )
                  : InkWell(
                child: Image.memory(
                  bytesktp,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                onTap: () async {
                  await availableCameras().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CameraKTPPage(cameras: value))));},
              )),

          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                  left: 20.0, right: 0.0, top: 10),
              child: Row(
                children: [
                  Text(
                    'Foto Wajah',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.red,
                        fontSize: 8),
                  ),
                ],
              )),

          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                  left: 20.0, right: 0.0, top: 10),
              child: bytewajah.isEmpty
                  ? InkWell(
                child: Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/gambarnon.png",
                        fit: BoxFit.cover,
                      )),
                ),
                onTap: () async {
                  await availableCameras().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CameraWajah(cameras: value))));},
              )
                  : InkWell(
                child: Image.memory(
                  bytewajah,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                onTap: () async {
                  await availableCameras().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CameraWajah(cameras: value))));},
              )),

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
                    daftarakun();
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
                    isLoading = false;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Daftar',
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
          // Text(picture.name)
        ]),
      ),
    )
    );
  }
  Future daftarakun() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();


    if (prefs.getString('fotoktpregister') != "") {
       fotoktpregister = prefs.getString('fotoktpregister')!;
    } else {
      fotoktpregister = prefs.getString('fotoktpkosong')!;
    }
    if (prefs.getString('fotoregister') != "") {
      foto = prefs.getString('fotoregister')!;
    } else {
      foto = prefs.getString('fotouserkosong')!;
    }

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeformat = DateFormat("HH:mm:ss");
    String createDate = dateFormat.format(DateTime.now());
    String createtime = timeformat.format(DateTime.now());

    Map data = {
      'usrbu': bidangutama,
      'usrhrc': harapancaleg,
      'usrstal': alamatsama,
      'usrfktp': fotoktpregister,
      'usrjpm': jumlahpemilih,
      'usrhpr': nohprelawanregister,
      'usrvt': usrvt,
      'usrvt2': usrvt2,
      'usrtpd': targetpendukung,
      'usrapc': usrapc,
      'usrbpd': usrbpd,
      'usrput': usrput,
      'usrtrp': usrtrp,
      'umr': umur,
      'usrsts': statusreferal,
      'usrkc': kodecaleg,
      'usrnik': nikregister,
      'usrnm': namaregister,
      'usrjk': gender,
      'usrema': emailregister,
      'usrhp': nohpregister,
      'usrkp': kodereferal,
      'usrpas': passwordregister,
      'usrdpl': daerahpemilihan,
      'usrpr1': profinsi1register,
      'usrkt1': kota1register,
      'usrkec1': kecamatan1register,
      'usrkel1': kelurahan1register,
      'usrrw1': rw1register,
      'usrrt1': rt1register,
      'usralm1': alamatktp1register,
      'usrpr2': profinsiDomisiliregister,
      'usrkt2': kotaDomisilitext,
      'usrkec2': kecamatanDomisilitext,
      'usrkel2': kelurahanDomisilitext,
      'usrrw2': rw2register,
      'usrrt2': rt2register,
      'usralm2': alamatktp2register,
      'usrtps': notpsgister,
      'usrft': foto,
      'usrdd': createDate,
      'usrtd': createtime,
      'usrsta': "A",
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/register.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {

        if(jsonResponse["response"]["status"]=="1") {
          setState(() {
            // sendEmail();
            dialogregisterberhasil();
            isLoading = false;
          });

        }else{
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Daftar gagal, Data Tidak Bisa Ada ( ' )")));
          });

        }

      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Daftar gagal, Data Tidak Bisa Ada ( ' )")));
        });
      }
    } else {}
  }

  //
  Future sendEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String emailregister = prefs.getString('emailregister')!;
    // String namauser= prefs.getString("namaregister")!;
    String namaregister = prefs.getString("namaregister")!;
    // final int min = 1000;
    // final int max = 9999;
    // var otpcodee = new Random().nextInt((max - min) + 1) + min;
    // var otpacak = otpcodee.toString();

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_ae3hebe';
    const templateId = 'template_yn06mpd';
    const userId = 'BDXVKB6k_Bfwu0_YT';
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost'
        }, //This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_name': " ",
            'from_name': "AyoCaleg",
            'to_email': "g7.teknologi@gmail.com",
            'message': "Daftar Baru " + namaregister
          }
        }));

    if (response.statusCode == 200) {
      // setState(() {
      //   visibleBtnResend = false;
      //     prefs.setString('otpregis', otpacak);
      // });
    }
    // return response.statusCode;
  }

  Future dialogregisterberhasil() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: Image.asset(
            'assets/images/logocaleg4.jpg',
            height: 100,
            width: 100,
          ),
          content: const Text(
              "Pendaftaran Berhasil !",
              style: TextStyle(
              fontFamily: 'poppins',
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold),),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, false);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));


                });
              },
            ),
          ],
        ));
  }



}
