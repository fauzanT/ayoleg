import 'dart:convert';
import 'dart:io';
// import 'package:image_picker_web/image_picker_web.dart';

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
import 'package:pie_chart/pie_chart.dart';

// import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class Tambahnewspage extends StatefulWidget {
  const Tambahnewspage({Key? key}) : super(key: key);

  @override
  State<Tambahnewspage> createState() => _TambahnewspageState();
}

class _TambahnewspageState extends State<Tambahnewspage> {
  // XFile? image;
  // late final bytes;
  late final pickedImage;
  String base64Image = "";
  String brtsts = "";
  String fotoktpkosong = "";
  String usrsts = "";
  String fotoimage = "";
  String usrstatus = "";

  // Uint8List ?imageFile;
  ImagePicker picker = ImagePicker();
  var isiberitacontrolel = TextEditingController();
  var judulberitacontrolel = TextEditingController();
  var nominalcontrolel = TextEditingController();

  late SharedPreferences sharedPrefs;
  bool isAppbarCollapsing = false;
  bool isLoading = false;
  bool visiblejudulberitaValid = false;
  bool visibleisiberitaValid = false;
  String judulpage = "";
  bool visibleimageValid = false;
  bool visiblenominalberita = false;
  var ctime;

  int desiredQuality = 80;

  @override
  void initState() {
    setState(() {
      // fetchGetpendukung();

      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        brtsts = prefs.getString('brtsts')!;
        usrsts = prefs.getString('usrsts')!;
        fotoktpkosong= prefs.getString('fotoktpkosong')!;
        usrstatus = prefs.getString('status')!;


        if (brtsts == "B") {
          judulpage = "Berita";
          visiblenominalberita = false;
        } else if (brtsts == "A") {
          judulpage = "Agenda";
          visiblenominalberita = false;
        }else if (brtsts == "D") {
          judulpage = "Kegiatan Relawan";
          visiblenominalberita = true;
        }else if (brtsts == "C") {
          judulpage = "Pesan";
          visiblenominalberita = false;
        }else if (brtsts == "S") {
          judulpage = "Info Saksi";
          visiblenominalberita = false;
        } else {
          judulpage = "Kegiatan Kampanye";
          visiblenominalberita = true;
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
    // if (pickedImage != null) {
      setState(() {
        _imageBytes = File(pickedImage.path).readAsBytesSync();
      });

    // } else {
    //   print('No image selected.');
    // }
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

                FadeInUp(
                  duration: Duration(milliseconds: 600),
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.65,
                    child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("fototambah", "info");
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
                          //
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
                          // final image = await ImagePickerWeb.getImageAsBytes();
                          //
                          // setState(() {
                          //   imageFile = image!;
                          //   base64Image = base64Encode(imageFile!);
                          // });

                          // setState(() {
                          //   File file = File(image!.path);
                          //   Uint8List bytes = file.readAsBytesSync();
                          //   base64Image = base64Encode(bytes);
                          // });

                          // setState(() {
                          //   //update UI
                          // });
                        },
                        child: Text("Masukkan Gambar")),

                    // Image.file(
                    //   imageFile!,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                FadeInUp(
                  duration: Duration(milliseconds: 800),
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
                      controller: judulberitacontrolel,
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
                          Icons.newspaper,
                          color: greenPrimary,
                        ),
                        fillColor: whitePrimary,
                        hintText: "Judul",
                        hintStyle: TextStyle(
                            fontFamily: 'poppins', color: greyPrimary,fontSize: 12 ),
                        filled: true,
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      //Normal textInputField will be displayed
                      maxLines: 1000000,
                      //
                      // keyboardType: TextInputType.text,
                      autofocus: false,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ),
                Visibility(
                  visible: visiblejudulberitaValid,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Masukkan Judul !',
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
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          color: greenPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      controller: isiberitacontrolel,
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
                        hintText: "Isi",
                        hintStyle: TextStyle(
                            fontFamily: 'poppins', color: greyPrimary,fontSize: 12),
                        filled: true,
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      //Normal textInputField will be displayed
                      maxLines: 1000000,
                      //
                      // keyboardType: TextInputType.text,
                      autofocus: false,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleisiberitaValid,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Masukkan Isi !',
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
                      'Masukkan Gambar !',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),
            Visibility(
              visible: visiblenominalberita,
              child:
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
                        // FilteringTextInputFormatter.deny(
                        //   RegExp(r'^0+'),
                        // ),

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
                        labelText: "Biaya Kegiatan",
                        labelStyle: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.grey,
                            fontSize: 11),


                        filled: true,
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                    ),
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

            ////untuk web
            // Column(
            //   children: [
            //     SizedBox(
            //       height: 20,
            //     ),
            //     base64Image.isEmpty
            //         ? Container(
            //             width: 200,
            //             height: 200,
            //             child: Image.asset("assets/images/gambarnoncamera.png"),
            //           )
            //         :
            //     Image.memory(
            //       imageFile!,
            //       height: 200,
            //       width: 200,
            //     ),
            //     // Image.file(
            //     //         File(image!.path),
            //     //         height: 200,
            //     //         width: 200,
            //     //       ),
            //     FadeInUp(
            //       duration: Duration(milliseconds: 600),
            //       child: Container(
            //         alignment: Alignment.center,
            //         width: size.width * 0.65,
            //         child: ElevatedButton(
            //             onPressed: () async {
            //               // final image = await ImagePickerWeb.getImageAsBytes();
            //               //
            //               // setState(() {
            //               //   imageFile = image!;
            //               //   base64Image = base64Encode(imageFile!);
            //               // });
            //               image = await picker.pickImage(
            //                   source: ImageSource.gallery);
            //               File file = File(image!.path);
            //               Uint8List bytes = file.readAsBytesSync();
            //               base64Image = base64Encode(bytes);
            //
            //               // setState(() {
            //               //   //update UI
            //               // });
            //             },
            //             child: Text("Masukkan Gambar")),
            //
            //         // Image.file(
            //         //   imageFile!,
            //         //   fit: BoxFit.cover,
            //         // ),
            //       ),
            //     ),
            //
            //     FadeInUp(
            //       duration: Duration(milliseconds: 800),
            //       child: Container(
            //         alignment: Alignment.center,
            //         margin:
            //             const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            //         child: TextFormField(
            //           style: const TextStyle(
            //               fontFamily: 'poppins',
            //               color: greenPrimary,
            //               fontSize: 16,
            //               fontWeight: FontWeight.bold),
            //           controller: judulberitacontrolel,
            //           decoration: const InputDecoration(
            //             enabledBorder: OutlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: greenPrimary, width: 2),
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(20))),
            //             focusedBorder: OutlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: greenPrimary, width: 2),
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(20))),
            //             errorBorder: OutlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: greenPrimary, width: 2),
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(20))),
            //             focusedErrorBorder: OutlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: greenPrimary, width: 2),
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(20))),
            //             prefixIcon: Icon(
            //               Icons.newspaper,
            //               color: greenPrimary,
            //             ),
            //             fillColor: whitePrimary,
            //             hintText: "Judul Berita",
            //             hintStyle: TextStyle(
            //                 fontFamily: 'poppins', color: greyPrimary),
            //             filled: true,
            //           ),
            //           textInputAction: TextInputAction.done,
            //           keyboardType: TextInputType.name,
            //           autofocus: false,
            //           textCapitalization: TextCapitalization.sentences,
            //         ),
            //       ),
            //     ),
            //     Visibility(
            //       visible: visiblejudulberitaValid,
            //       child: const Padding(
            //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
            //         child: Text(
            //           'Masukkan Judul Berita !',
            //           style: TextStyle(
            //               fontFamily: 'poppins',
            //               color: Colors.red,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 13),
            //         ),
            //       ),
            //     ),
            //     FadeInUp(
            //       duration: Duration(milliseconds: 1000),
            //       child: Container(
            //         alignment: Alignment.center,
            //         margin:
            //             const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            //         child: TextFormField(
            //           style: const TextStyle(
            //               fontFamily: 'poppins',
            //               color: greenPrimary,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           controller: isiberitacontrolel,
            //           decoration: const InputDecoration(
            //             enabledBorder: OutlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: greenPrimary, width: 2),
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(20))),
            //             focusedBorder: OutlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: greenPrimary, width: 2),
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(20))),
            //             errorBorder: OutlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: greenPrimary, width: 2),
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(20))),
            //             focusedErrorBorder: OutlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: greenPrimary, width: 2),
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(20))),
            //             prefixIcon: Icon(
            //               Icons.newspaper_outlined,
            //               color: greenPrimary,
            //             ),
            //             fillColor: whitePrimary,
            //             hintText: "Isi Berita",
            //             hintStyle: TextStyle(color: greyPrimary),
            //             filled: true,
            //           ),
            //           keyboardType: TextInputType.text,
            //           autofocus: false,
            //           // validator: (valueMail) {
            //           //   // if (valueMail == null || valueMail.isEmpty) {
            //           //   //   return 'Email Tidak Boleh Kosong';
            //           //   // }
            //           //   // if (!RegExp(r'\S+@\S+\.\S+').hasMatch(valueMail)) {
            //           //   //   return "Masukkan Email yang Valid";
            //           //   // }
            //           //   // return null;
            //           // },
            //           textInputAction: TextInputAction.done,
            //         ),
            //       ),
            //     ),
            //     Visibility(
            //       visible: visibleisiberitaValid,
            //       child: const Padding(
            //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
            //         child: Text(
            //           'Masukkan Isi Berita !',
            //           style: TextStyle(
            //               fontFamily: 'poppins',
            //               color: Colors.red,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 13),
            //         ),
            //       ),
            //     ),
            //     FadeInUp(
            //       duration: Duration(milliseconds: 1400),
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 30, vertical: 10),
            //         child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             primary: greenPrimary,
            //             onPrimary: whitePrimary,
            //             shadowColor: shadowColor,
            //             elevation: 3,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             minimumSize: const Size(130, 50), //////// HERE
            //           ),
            //           onPressed: () {
            //             setState(() {
            //               isLoading = true;
            //               checkEmpty();
            //               // checkEmpty();
            //               // getgalery();
            //             });
            //           },
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'Tambah',
            //                 style: TextStyle(
            //                     fontFamily: 'poppins',
            //                     color: whitePrimary,
            //                     fontSize: 17,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 10,
            //     ),
            //   ],
            // ),
          )),
    );
  }

  checkEmpty(String fotoberita) {
    if (judulberitacontrolel.text.isEmpty) {
      setState(() {
        visiblejudulberitaValid = true;
        visibleisiberitaValid = false;
        isLoading = false;

        visibleimageValid = false;
      });
    } else if (isiberitacontrolel.text.isEmpty) {
      setState(() {
        visiblejudulberitaValid = false;
        visibleisiberitaValid = true;
        isLoading = false;
        visibleimageValid = false;
      });
    }  else {
      setState(() {
        visiblejudulberitaValid = false;
        visibleisiberitaValid = false;
        visibleimageValid = false;
        isLoading = true;

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

    if (nominalcontrolel.text.isEmpty) {
      setState(() {
        nominalcontrolel.text = "0";
      });
    }

    Map data = {
      'brtamt': nominalcontrolel.text,
      'brtnm': namaAkun,
      'brtsts': brtsts,
      'brtkc': kodecaleg,
      'brthp': nohpAkun,
      'brtdp': createDate,
      'brttp': createtime,
      'brtjdl': judulberitacontrolel.text,
      'brtft': base64,
      'brtbrt': isiberitacontrolel.text,
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/postberita.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        prefs.remove('fotoimage');
        notifyLogin();
        if (brtsts == "D") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CustomNavRelawanBar();
          }));
        }else if (brtsts == "S") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const CustomNavRelawanBar();
              }));
        }else if (brtsts == "B") {
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

        }else if (brtsts == "C") {
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

        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CustomNavBar();
          }));
        }

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Tambah Data Berhasil !")));
      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Gagal Di Tambahkan!!")));
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
  // cekdatabrt(String brtjdl) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   Map data = {'brtjdl': brtjdl};
  //
  //   dynamic jsonResponse;
  //   var response = await http.post(
  //       Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/cekimagebrt.php"),
  //       body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       if (jsonResponse['data'] != null) {
  //         setState(() {
  //           notifyLogin(jsonResponse['data']['brtft']);
  //
  //
  //         });
  //       }else{
  //
  //       }
  //
  //     } else {}
  //   }
  // }

  Future<String> notifyLogin() async {
    // prefs.setString('tokencaleg', jsonResponse['data']['tkn']);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokencaleg = prefs.getString('tokencaleg')!;
    String namaAkun = prefs.getString('namaregister')!;
    final body = {
      "to" : tokencaleg,
      "notification" : {
        "body" : judulberitacontrolel.text,
        "title": judulpage+" "+namaAkun+" ("+usrstatus+")",
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
