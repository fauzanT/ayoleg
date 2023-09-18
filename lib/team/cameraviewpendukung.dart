import 'dart:convert';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/login.dart';
import 'package:ayoleg/otp/otpverivikasi.dart';
// import 'package:ayoleg/component/colors/colors.dart';
// import 'package:ayoleg/otp/otpverivikasi.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
// import 'package:emailjs/emailjs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

// class PreviewPage extends StatelessWidget {
//   const PreviewPage({Key? key, required this.picture}) : super(key: key);
class CameraViewPendukungPage extends StatefulWidget {
  // const PreviewPage({Key? key, required XFile picture}) : super(key: key);
  const CameraViewPendukungPage({Key? key}) : super(key: key);

  @override
  State<CameraViewPendukungPage> createState() => _CameraViewPendukungPage();
}

class _CameraViewPendukungPage extends State<CameraViewPendukungPage> {
  late final XFile picture;

  late SharedPreferences sharedPrefs;

  String fotousr = "";
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      fotousr = prefs.getString('fotopendukung')!;
    });
    super.initState();
  }

  bool isLoading = false;
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64.decode(fotousr);
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: greenPrimary,
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          bytes.isEmpty
              ? Container(
            width: 100,
            height: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/images/gambarnon.png",
                  fit: BoxFit.cover,
                )),
          )
              : Image.memory(
            bytes,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),

          // Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          // const SizedBox(height: 24),
          FadeInUp(
            duration: Duration(milliseconds: 1300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    isLoading = true;
                    // sendEmail();
                    registerverifikasi();
                    // signIn();
                    // if (stslog == 'N') {
                    //   isLoading = false;
                    //   pesantroble(stspesan);
                    // } else {
                    //   cektrobLOG();
                    // }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: whitePrimary,
                      ),
                    )
                        : const Text(
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
          // Text(picture.name)
        ]),
      ),
    );
  }

  registerverifikasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String nikregister = prefs.getString("nikregisterpendukung")!;
    String namaregister = prefs.getString("namaregisterpendukung")!;
    String gender = prefs.getString("genderpendukung")!;
    String emailregister = prefs.getString("emailregisterpendukung")!;
    String nohpregister = prefs.getString("nohpregister")!;
    String nohpregisterpendukung = prefs.getString("nohpregisterpendukung")!;
    // String kodereferal = prefs.getString("kodereferal")!;
    // String passwordregister = prefs.getString("passwordregisterpendukung")!;
    String tempatlahirregis = prefs.getString("tempatlahirregis")!;
    String tanggallahirregis = prefs.getString("tanggallahirregis")!;
    String agamaregister = prefs.getString("agamaregister")!;
    String statuskawinregis = prefs.getString("statuskawinregis")!;
    String pekerjaanregister = prefs.getString("pekerjaanregister")!;
    String daerahpemilihan = prefs.getString("daerahpemilihan")!;
    String profinsi1register = prefs.getString("profinsitext")!;
    String kota1register = prefs.getString("kotatext")!;
    String kecamatan1register = prefs.getString("kecamatantext")!;
    String kelurahan1register = prefs.getString("kelurahantext")!;
    String rw1register = prefs.getString("rw1register")!;
    String rt1register = prefs.getString("rt1register")!;
    String alamatktp1register = prefs.getString("alamatktp1register")!;
    String profinsiaktifitasregister =
    prefs.getString("profinsiaktifitastext")!;
    String kotaaktifitastext = prefs.getString("kotaaktifitastext")!;
    String kecamatanaktifitastext = prefs.getString("kecamatanaktifitastext")!;
    String kelurahanaktifitastext = prefs.getString("kelurahanaktifitastext")!;
    String rw2register = prefs.getString("rw2register")!;
    String rt2register = prefs.getString("rt2register")!;
    String alamatktp2register = prefs.getString("alamatktp2register")!;
    String umur = prefs.getString("umur")!;


    String notpsgister = prefs.getString("notpsgister")!;
    String foto = prefs.getString('fotopendukung')!;
    // String statusreferal = prefs.getString('statusreferal')!;
    String kodecaleg = prefs.getString('kodecaleg')!;
    String usrvt = prefs.getString('usrvt')!;
    String usrvt2 = prefs.getString('usrvt2')!;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeformat = DateFormat("HH:mm:ss");
    String createDate = dateFormat.format(DateTime.now());
    String createtime = timeformat.format(DateTime.now());
    Map data = {
      'usrvt': usrvt,
      'usrvt2': usrvt2,
      'usrhpr': nohpregister,
      'umr': umur,
      'usrsts': "P",
      'usrkc': kodecaleg,
      'usrnik': nikregister,
      'usrnm': namaregister,
      'usrjk': gender,
      'usrema': emailregister,
      'usrhp': nohpregisterpendukung,
      'usrkp': "-",
      'usrpas': "-",
      'usrtl': tempatlahirregis,
      'usrtlh': tanggallahirregis,
      'usragm': agamaregister,
      'usrsp': statuskawinregis,
      'usrpkj': pekerjaanregister,
      'usrdpl': daerahpemilihan,
      'usrpr1': profinsi1register,
      'usrkt1': kota1register,
      'usrkec1': kecamatan1register,
      'usrkel1': kelurahan1register,
      'usrrw1': rw1register,
      'usrrt1': rt1register,
      'usralm1': alamatktp1register,
      'usrpr2': profinsiaktifitasregister,
      'usrkt2': kotaaktifitastext,
      'usrkec2': kecamatanaktifitastext,
      'usrkel2': kelurahanaktifitastext,
      'usrrw2': rw2register,
      'usrrt2': rt2register,
      'usralm2': alamatktp2register,
      'usrtps': notpsgister,
      'usrft': foto,
      'usrdd': createDate,
      'usrtd': createtime,
      'usrsta': "N",
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/registerpendukung.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        sendEmail();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return const CustomNavRelawanBar();
            }));
        // dialogregisterberhasil();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Daftar gagal, periksa jaringan anda!")));
      }
    } else {}
  }

  Future sendEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String emailregister = prefs.getString('emailregister')!;
    // String namauser= prefs.getString("namaregister")!;
    String namaregister = prefs.getString("namaregister")!;
    final int min = 1000;
    final int max = 9999;
    var otpcodee = new Random().nextInt((max - min) + 1) + min;
    var otpacak = otpcodee.toString();

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
        context: context,
        builder: (context) => AlertDialog(
          title: Image.asset(
            'assets/images/otpp.png',
            height: 100,
            width: 100,
          ),
          content: const Text(
              "Daftar Berhasil, Data Anda Akan Di Verifikasi 1x24 Jam"),
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
}
