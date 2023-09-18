import 'dart:convert';
import 'dart:io';
// import 'package:image_picker_web/image_picker_web.dart';

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ayoleg/berita/pesan.dart';
import 'package:ayoleg/cameraktp/viewimage.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/currenty_format.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PesanDetailpage extends StatefulWidget {
  const PesanDetailpage({Key? key}) : super(key: key);

  @override
  State<PesanDetailpage> createState() => _PesanDetailpageState();
}

class _PesanDetailpageState extends State<PesanDetailpage> {
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
  String nominal = "0";


  // Uint8List ?imageFile;
  ImagePicker picker = ImagePicker();
  var isiberitacontrolel = TextEditingController();
  var judulberitacontrolel = TextEditingController();
  late SharedPreferences sharedPrefs;
  bool isAppbarCollapsing = false;
  bool isLoading = false;
  bool visiblejudulberitaValid = false;
  bool visibleisiberitaValid = false;
  bool visiblenominal = false;
  var ctime;

  @override
  void initState() {
    setState(() {
      // fetchGetpendukung();
      jamagenda = "";
      tanggalagenda = "";
      cekberita();
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        // namaAkun = prefs.getString('namaregister')!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
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
                    onPressed: () {
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
                  child:
                  InkWell(
                    child:
                    Container(
                      margin: EdgeInsets.only(top:20),
                      child:
                        Image.network(
                          foto,
                          // width: 100,
                          height: 350,
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
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("fotoview",foto);
                      prefs.setString("navfoto", "pesan");
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
          child:   Column(
          children: [
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
                  style:
                  const TextStyle(fontSize: 30.0, color: greenPrimary),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('•••••••••'),
                    ],
                  ),
                ),

              ],
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              alignment: Alignment.topLeft,
              child:

              nmuser.isNotEmpty
                  ? Text(
                "Di Tambahkan Oleh : " +nmuser,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'poppins',
                  fontSize: 12,
                  color: Colors.black,
                ),
                overflow: TextOverflow.clip,
              )
                  : DefaultTextStyle(
                style:
                const TextStyle(fontSize: 30.0, color: greenPrimary),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('•••••••••'),
                  ],
                ),
              ),
            ),
                  Visibility(
    visible: visiblenominal,
    child:
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              alignment: Alignment.topLeft,
              child: nominal.isNotEmpty
                  ? Text(
                "Biaya Kegiatan : Rp " +CurrencyFormat.convertToIdr(int.parse(nominal), 0),
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
                  ),
            ])
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  bottom: 10, top: 10, right: 10, left: 20),
              alignment: Alignment.center,
              // height: 30,
              // width: 300,
              decoration: const BoxDecoration(
                // color: whitePrimary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(0)),
              ),
              child: Center(
                child: brtjdl.isNotEmpty
                    ? Text(
                  brtjdl,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 20, bottom: 10, top: 10, right: 10),
                alignment: Alignment.topLeft,
                // height: 30,
                // width: 300,
                decoration: const BoxDecoration(
                  // color: whitePrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0)),
                ),
                child: tanggalagenda.isNotEmpty
                    ? Text(
                  "Waktu Pelaksaan Agenda " + tanggalagenda + " " + jamagenda,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'poppins',
                    fontSize: 12,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.clip,
                )
                    : Text("")
            ),

            Container(
              margin: const EdgeInsets.only(
                  left: 20, bottom: 10, top: 10, right: 10),
              alignment: Alignment.topLeft,
              // height: 30,
              // width: 300,
              decoration: const BoxDecoration(
                // color: whitePrimary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(0)),
              ),
              child: isiberita.isNotEmpty
                  ? Text(
                isiberita,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'poppins',
                  fontSize: 12,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.clip,
              )
                  : DefaultTextStyle(
                style:
                const TextStyle(fontSize: 30.0, color: greenPrimary),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('•••••••••'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }

  cekberita() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idberita = prefs.getString("idberita")!;

    Map data = {'idb': idberita};

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekidberita.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {

          foto = jsonResponse['data']['brtft'];
          isiberita = jsonResponse['data']['brtbrt'];
          tanggal = jsonResponse['data']['brtdp'];
          jam = jsonResponse['data']['brttp'];
          brtjdl = jsonResponse['data']['brtjdl'];
          nmuser = jsonResponse['data']['brtnm'];
          nominal = jsonResponse['data']['brtamt'];

          if(jsonResponse['data']['brtsts'] == "D"){
            setState(() {
              visiblenominal = true;
            });
          }else if(jsonResponse['data']['brtsts'] == "P"){
            setState(() {
              visiblenominal = true;
            });
          }else{
            setState(() {
              visiblenominal = false;
            });
          }

          if (jsonResponse['data']['dtagd'] != null) {
            jamagenda = jsonResponse['data']['tmagd'];
            tanggalagenda = jsonResponse['data']['dtagd'];
          }
        });
      }
    }
  }
}
