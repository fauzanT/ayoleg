import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ayoleg/cameraktp/viewimage.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeuanganDetailpage extends StatefulWidget {
  const KeuanganDetailpage({Key? key}) : super(key: key);

  @override
  State<KeuanganDetailpage> createState() => _KeuanganDetailpageState();
}

class _KeuanganDetailpageState extends State<KeuanganDetailpage> {
  XFile? image;
  late final bytes;
  String base64Image = "";
  String foto = "";
  String isiberita = "";
  String tanggal = "";
  String jam = "";
  String brtjdl = "";
  String nmuser = "";
  String jamagenda = "";
  String tanggalagenda = "";

  String namadonasi = "";
  String nohpdonasi = "";
  String nominal = "";

  var isiberitacontrolel = TextEditingController();
  var judulberitacontrolel = TextEditingController();
  late SharedPreferences sharedPrefs;
  bool isAppbarCollapsing = false;
  bool isLoading = false;
  bool visiblejudulberitaValid = false;
  bool visibleisiberitaValid = false;
  bool visibledonasi = false;
  var ctime;

  @override
  void initState() {
    setState(() {
      cekidkeuangan();
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        // namaAkun = prefs.getString('namaregister')!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
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
                  IconButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      prefs.remove(
                          "idkeuangan");
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Detail',
                    style:
                        TextStyle(fontFamily: 'poppins', color: whitePrimary),
                  ),
                  Container(
                    width: 17,
                  )
                ],
              )),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child:

                ////untuk android
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: foto.isEmpty
                          ? Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator())
                          : Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              alignment: Alignment.center,
                              child: Image.network(
                                foto,
                                // width: 250,
                                height: 350,
                                fit: BoxFit.cover,
                              )),
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("fotoview", foto);
                      prefs.setString("navfoto", "donasi");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ZoomableImage(),
                        ),
                      );
                    },
                  ),
                ),
                detailtext(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }

  Widget detailtext() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            alignment: Alignment.topLeft,
            child: Column(children: [
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 17,
                  ),
                  tanggal.isNotEmpty
                      ? Text(
                          tanggal + " " + jam,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'poppins',
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.clip,
                        )
                      : DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 30.0, color: greenPrimary),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText('•••••••••'),
                            ],
                          ),
                        ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                alignment: Alignment.topLeft,
                child: nmuser.isNotEmpty
                    ? Text(
                        "Di Tambahkan Oleh : " + nmuser,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'poppins',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.clip,
                      )
                    : DefaultTextStyle(
                        style: const TextStyle(
                            fontSize: 30.0, color: greenPrimary),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('•••••••••'),
                          ],
                        ),
                      ),
              ),
              Visibility(
                  visible: visibledonasi,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        alignment: Alignment.topLeft,
                        child: namadonasi.isNotEmpty
                            ? Text(
                                "Donasi Oleh : " + namadonasi,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: 'poppins',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.clip,
                              )
                            : DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: 30.0, color: greenPrimary),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText('•••••••••'),
                                  ],
                                ),
                              ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        alignment: Alignment.topLeft,
                        child: nohpdonasi.isNotEmpty
                            ? Text(
                                "No. HP : " + nohpdonasi,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: 'poppins',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.clip,
                              )
                            : DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: 30.0, color: greenPrimary),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText('•••••••••'),
                                  ],
                                ),
                              ),
                      ),

                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                alignment: Alignment.topLeft,
                child: nominal.isNotEmpty
                    ? Text(
                  "Nominal : Rp " +CurrencyFormat.convertToIdr(int.parse(nominal), 0),
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: 'poppins',
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                  overflow: TextOverflow.clip,
                )
                    : DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 30.0, color: greenPrimary),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('•••••••••'),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 20),
                alignment: Alignment.topLeft,
                child: isiberita.isNotEmpty
                    ? Text(
                  "Keterangan : "+isiberita,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'poppins',
                    fontSize: 12,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold
                  ),
                  overflow: TextOverflow.clip,
                )
                    : DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 30.0, color: greenPrimary),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('•••••••••'),
                    ],
                  ),
                ),
              ),
            ])),
      ],
    );
  }

  cekidkeuangan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idkeuangan = prefs.getString("idkeuangan")!;

    Map data = {'idk': idkeuangan};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse('http://aplikasiayocaleg.com/ayocalegapi/cekiddonasi.php'),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          if (jsonResponse['data']['keusts'] == "D") {
            setState(() {
              visibledonasi = true;
            });
          } else {
            setState(() {
              visibledonasi = false;
            });
          }


          foto = jsonResponse['data']['keuft'];
          isiberita = jsonResponse['data']['keudsc'];
          tanggal = jsonResponse['data']['keudp'];
          jam = jsonResponse['data']['keutp'];
          nmuser = jsonResponse['data']['keunma'];
          namadonasi = jsonResponse['data']['keunm'];
          nominal = jsonResponse['data']['keuamt'];
          nohpdonasi = jsonResponse['data']['keunhp'];



        });
      }
    }
  }
}
