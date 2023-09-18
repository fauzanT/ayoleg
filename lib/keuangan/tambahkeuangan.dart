import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/berita/pesan.dart';
import 'package:ayoleg/cameraktp/camerahome.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/component/navbar/navbarpendukung.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:camera/camera.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class TambahKeuanganpage extends StatefulWidget {
  const TambahKeuanganpage({Key? key}) : super(key: key);

  @override
  State<TambahKeuanganpage> createState() => _TambahKeuanganpageState();
}

class _TambahKeuanganpageState extends State<TambahKeuanganpage> {

  late final pickedImage;
  String base64Image = "";
  String keust = "";
  String fotoktpkosong = "";
  String usrsts = "";
  String fotoimage = "";
  String usrstatus = "";

  ImagePicker picker = ImagePicker();

  late SharedPreferences sharedPrefs;
  bool isAppbarCollapsing = false;
  bool isLoading = false;
  bool visiblejudulberitaValid = false;
  bool visibleisiberitaValid = false;
  String judulpage = "";
  bool visibleimageValid = false;
  var ctime;

  var postingcontrolel = TextEditingController();
  var namatambahcontrolel = TextEditingController();
  var nohptambahcontrolel = TextEditingController();
  var keterangancontrolel = TextEditingController();
  var nominalcontrolel = TextEditingController();

  bool visiblenominalValid = false;
  bool visiblepostingValid = false;
  bool visibledonasi = false;
  bool visiblenohptambahValid = false;
  bool visibleketeranganValid = false;
  bool visiblepengeluaran = false;
  bool visiblenamatambahValid = false;
  bool visibleketerangandonasi = false;
  bool visibleketeranganpengeluaran = false;


  int desiredQuality = 80;

  @override
  void initState() {
    setState(() {

      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        keust = prefs.getString('keust')!;
        fotoktpkosong= prefs.getString('fotoktpkosong')!;
        usrsts = prefs.getString('usrsts')!;
        usrstatus = prefs.getString('status')!;


        if (keust == "D") {
          judulpage = "Donasi";
           visibledonasi = true;
           visibleketerangandonasi = true;
           visibleketeranganpengeluaran = false;
        } else if (keust == "P") {
          judulpage = "Pengeluaran";
           visibledonasi = false;
           namatambahcontrolel.text = "-";
           nohptambahcontrolel.text = "-";
          visibleketerangandonasi = false;
          visibleketeranganpengeluaran = true;

        }
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
    Uint8List byteimage = base64.decode(fotoimage);
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
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('fotoimage');
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    judulpage,
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
              children: [
                SizedBox(
                  height: 20,
                ),
                byteimage.isEmpty
                    ? Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/images/gambarnoncamera.png"),
                )
                    : Image.memory(
                  byteimage,
                  height: 200,
                  width: 200,
                ),
                // _imageBytes == null
                //     ? Container(
                //   width: 200,
                //   height: 200,
                //   child: Image.asset("assets/images/gambarnoncamera.png"),
                // )
                //     : Image.memory(
                //   _imageBytes!,
                //   height: 200,
                //   width: 200,
                // ),
                FadeInUp(
                  duration: Duration(milliseconds: 600),
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.65,
                    child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("fototambah", "donasi");
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
                        child: Text("Masukkan Gambar Bukti")),


                    // Image.file(
                    //   imageFile!,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),


                // FadeInUp(
                //   duration: Duration(milliseconds: 800),
                //   child: Container(
                //     alignment: Alignment.center,
                //     margin:
                //     const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                //     child: TextFormField(
                //       style: const TextStyle(
                //           fontFamily: 'poppins',
                //           color: greenPrimary,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold),
                //       controller: postingcontrolel,
                //       decoration: const InputDecoration(
                //         enabledBorder: OutlineInputBorder(
                //             borderSide:
                //             BorderSide(color: greenPrimary, width: 2),
                //             borderRadius:
                //             BorderRadius.all(Radius.circular(20))),
                //         focusedBorder: OutlineInputBorder(
                //             borderSide:
                //             BorderSide(color: greenPrimary, width: 2),
                //             borderRadius:
                //             BorderRadius.all(Radius.circular(20))),
                //         errorBorder: OutlineInputBorder(
                //             borderSide:
                //             BorderSide(color: greenPrimary, width: 2),
                //             borderRadius:
                //             BorderRadius.all(Radius.circular(20))),
                //         focusedErrorBorder: OutlineInputBorder(
                //             borderSide:
                //             BorderSide(color: greenPrimary, width: 2),
                //             borderRadius:
                //             BorderRadius.all(Radius.circular(20))),
                //         prefixIcon: Icon(
                //           Icons.newspaper,
                //           color: greenPrimary,
                //         ),
                //         fillColor: whitePrimary,
                //         labelText: "Posting Oleh..",
                //         labelStyle: TextStyle(
                //             fontFamily: 'poppins', color: greyPrimary,fontSize: 12 ),
                //         filled: true,
                //       ),
                //       textInputAction: TextInputAction.done,
                //       keyboardType: TextInputType.multiline,
                //       minLines: 1,
                //       //Normal textInputField will be displayed
                //       maxLines: 1000,
                //       //
                //       autofocus: false,
                //       textCapitalization: TextCapitalization.sentences,
                //     ),
                //   ),
                // ),
                // Visibility(
                //   visible: visiblepostingValid,
                //   child: const Padding(
                //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                //     child: Text(
                //       'Masukkan Nama Posting !',
                //       style: TextStyle(
                //           fontFamily: 'poppins',
                //           color: Colors.red,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 13),
                //     ),
                //   ),
                // ),

            Visibility(
              visible: visibledonasi,
              child:Column(children: [
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    alignment: Alignment.center,
                    margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          color: greenPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      controller: namatambahcontrolel,
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
                          Icons.newspaper_outlined,
                          color: greenPrimary,
                        ),
                        fillColor: whitePrimary,
                        labelText: "Donasi Oleh..",
                        labelStyle: TextStyle(
                            fontFamily: 'poppins', color: greyPrimary,fontSize: 12),
                        filled: true,
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 1000,
                      autofocus: false,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
                Visibility(
                  visible: visiblenamatambahValid,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Masukkan Nama Donasi !',
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
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
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
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          color: greenPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      controller: nohptambahcontrolel,
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
                          Icons.newspaper_outlined,
                          color: greenPrimary,
                        ),

                        fillColor: whitePrimary,
                        labelText: "No. HP",
                        labelStyle: TextStyle(
                            fontFamily: 'poppins', color: greyPrimary,fontSize: 12),
                        filled: true,
                      ),
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
                Visibility(
                  visible: visiblenohptambahValid,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Masukkan No. HP !',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),

              ],)

            ),
            Visibility(
              visible: visibleketerangandonasi,
              child:Column(children: [
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    alignment: Alignment.center,
                    margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          color: greenPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      controller: keterangancontrolel,
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
                          Icons.newspaper_outlined,
                          color: greenPrimary,
                        ),

                        fillColor: whitePrimary,
                        labelText: "Keterangan",
                        labelStyle: TextStyle(
                            fontFamily: 'poppins', color: greyPrimary,fontSize: 12),
                        filled: true,
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 1000,
                      autofocus: false,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleketeranganValid,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Masukkan Keterangan !',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),
              ],)
            ),


                Visibility(
                    visible: visibleketeranganpengeluaran,
                    child:Column(children: [
                      FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                          const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          child: TextFormField(
                            style: const TextStyle(
                                fontFamily: 'poppins',
                                color: greenPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            controller: keterangancontrolel,
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
                                Icons.newspaper_outlined,
                                color: greenPrimary,
                              ),

                              counterText: "HARUS DI ISI",
                              counterStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.red,
                                  fontSize: 8),
                              fillColor: whitePrimary,
                              labelText: "Keterangan",
                              labelStyle: TextStyle(
                                  fontFamily: 'poppins', color: greyPrimary,fontSize: 12),
                              filled: true,
                            ),
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 1000,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: visibleketeranganValid,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                          child: Text(
                            'Masukkan Keterangan !',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ],)
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

                      ],
                      controller: nominalcontrolel,
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

                        fillColor: whitePrimary,
                        labelText: "Nominal",
                        labelStyle: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.grey,
                            fontSize: 11),
                        counterText: "HARUS DI ISI",
                        counterStyle: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.red,
                            fontSize: 8),

                        filled: true,
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                    ),
                  ),
                ),

                Visibility(
                  visible: visiblenominalValid,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Masukkan Nominal !',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),

                Visibility(
                  visible: visibleimageValid,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Masukkan Gambar Bukti !',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
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
                        minimumSize: const Size(130, 50), //////// HERE
                      ),
                      onPressed: () {

                        setState(() async {
                          isLoading = true;

                          if(byteimage.isEmpty){
                            checkEmpty(fotoktpkosong);
                          }else{
                            // base64Image = await compressImageToBase64(pickedImage!.path, desiredQuality);

                            checkEmpty(fotoimage);
                          }
                          // if(_imageBytes == null){
                          //   checkEmpty(fotoktpkosong);
                          // }else{
                          //   base64Image = await compressImageToBase64(pickedImage!.path, desiredQuality);
                          //   checkEmpty(base64Image);
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

          )),
    );
  }

  checkEmpty(String fotoberita) {
    if (fotoimage.isEmpty) {
      setState(() {
        visibleimageValid = true;
        visiblenominalValid = false;
        visiblepostingValid = false;
        visiblenohptambahValid = false;
        visibleketeranganValid = false;
        visiblenamatambahValid = false;
        isLoading = false;
      });
    }
      else if (keust == "P") {
   if (keterangancontrolel.text.isEmpty) {
        setState(() {
          visibleimageValid = false;
          visiblenominalValid = false;
          visiblepostingValid = false;
          visiblenohptambahValid = false;
          visibleketeranganValid = true;
          visiblenamatambahValid = false;
          isLoading = false;
        });
      }
   else if (nominalcontrolel.text.isEmpty) {
     setState(() {
       visibleimageValid = false;
       visiblenominalValid = true;
       visiblepostingValid = false;
       visiblenohptambahValid = false;
       visibleketeranganValid = false;
       visiblenamatambahValid = false;
       isLoading = false;
     });
   } else {
     setState(() {
       visibleimageValid = false;
       visiblenominalValid = false;
       visiblepostingValid = false;
       visiblenohptambahValid = false;
       visibleketeranganValid = false;
       visiblenamatambahValid = false;
       isLoading = false;

       tambahberita(fotoberita);

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
   else if (nominalcontrolel.text.isEmpty) {
       setState(() {
         visibleimageValid = false;
         visiblenominalValid = true;
         visiblepostingValid = false;
         visiblenohptambahValid = false;
         visibleketeranganValid = false;
         visiblenamatambahValid = false;
         isLoading = false;
       });
     } else {
       setState(() {
         visibleimageValid = false;
         visiblenominalValid = false;
         visiblepostingValid = false;
         visiblenohptambahValid = false;
         visibleketeranganValid = false;
         visiblenamatambahValid = false;
         isLoading = false;

         tambahberita(fotoberita);

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

  tambahberita(String base64) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    String nohpAkun = prefs.getString('nohpregister')!;
    String namaAkun = prefs.getString('namaregister')!;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeformat = DateFormat("HH:mm:ss");
    String createDate = dateFormat.format(DateTime.now());
    String createtime = timeformat.format(DateTime.now());

    if (namatambahcontrolel.text.isEmpty) {
      setState(() {
        namatambahcontrolel.text = "-";
      });
    }
    if (keterangancontrolel.text.isEmpty) {
      setState(() {
        keterangancontrolel.text = "-";
      });
    }
    if (nohptambahcontrolel.text.isEmpty) {
      setState(() {
        nohptambahcontrolel.text = "-";
      });
    }

    Map data = {
      'keunhp': nohptambahcontrolel.text,
      'keukc': kodecaleg,
      'keuhp': nohpAkun,
      'keudp': createDate,
      'keutp': createtime,
      'keunm': namatambahcontrolel.text,
      'keudsc': keterangancontrolel.text,
      'keuamt': nominalcontrolel.text,
      'keuft': base64,
      'keusts': keust,
      'keunma': namaAkun,
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/postdonasi.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if(jsonResponse["response"]["status"]=="1") {
          setState(() {
            prefs.remove('fotoimage');
            notifyLogin();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Tambah Data Berhasil !")));
            if (usrsts == "A") {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return const CustomNavBar();
                  }));
            } else if (usrsts == "C") {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return const CustomNavBar();
                  }));
            } else if (usrsts == "R") {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return const CustomNavRelawanBar();
                  }));
            }else if (usrsts == "P") {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return const CustomNavPendukungBar();
                  }));
            }else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return const CustomNavRelawanBar();
                  }));
            }
          });

        }else{
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Data Gagal Di Tambahkan!")));
            Navigator.of(context).pop();
          });

        }

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Gagal Di Tambahkan!")));
        Navigator.of(context).pop();
      }
    } else {}
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

  Future<String> notifyLogin() async {
    // prefs.setString('tokencaleg', jsonResponse['data']['tkn']);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokencaleg = prefs.getString('tokencaleg')!;
    String namaAkun = prefs.getString('namaregister')!;
    final body = {
      "to" : tokencaleg,
      "notification" : {
        "body" : judulpage+" "+ namatambahcontrolel.text,
        "title": "Info Keuangan"+namaAkun+" ("+usrstatus+")",
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
}
