import 'package:ayoleg/account.dart';
import 'package:ayoleg/berita/pesandetail.dart';
import 'package:ayoleg/keuangan/keuangandetail.dart';
import 'package:ayoleg/suara/suaradetail.dart';
import 'package:ayoleg/team/relawan.dart';
import 'package:ayoleg/team/relawanpendukung.dart';
import 'package:ayoleg/team/saksi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ZoomableImage extends StatefulWidget {
  const ZoomableImage({Key? key}) : super(key: key);

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {

  String? imageUrl;
  String fotoview = "";
  String navfoto = "";

  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        fotoview = prefs.getString('fotoview')!;
        navfoto = prefs.getString('navfoto')!;
      });
    });

    super.initState();
  }
  Future<void> onBackPressed() async {
    setState(() {
      if (navfoto == "relawan"){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    RelawanPage()));
      }else   if (navfoto == "relawanpendukung") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    RelawanPendukungPage()));
      }else   if (navfoto == "suara") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  SuaraDetailpage()));
      }else   if (navfoto == "saksi") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  Saksipage()));
      }else   if (navfoto == "pesan") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  PesanDetailpage()));
       }else   if (navfoto == "donasi") {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                KeuanganDetailpage()));
    }
      else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    AccountPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    return WillPopScope(
      onWillPop: () async {
        onBackPressed();
        return false;
      },
      child: Stack(
        children: [
          Container(
            child: PhotoView(
              imageProvider: NetworkImage(fotoview),
              // You can also use AssetImage for local images
              minScale: PhotoViewComputedScale.contained * 0.8,
              // Optional minimum scale value
              maxScale: PhotoViewComputedScale.covered * 2.0,
              // Optional maximum scale value
              initialScale: PhotoViewComputedScale
                  .contained, // Optional initial scale value
            ),
          ),
        ],
      ),
    );
  }
}
