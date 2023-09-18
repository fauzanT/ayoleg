import 'dart:convert';
import 'dart:io';
// import 'package:image_picker_web/image_picker_web.dart';

import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/berita/pesan.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/component/navbar/navbar.dart';
import 'package:ayoleg/component/navbar/navbarrelawan.dart';
import 'package:ayoleg/models/model.dart';
import 'package:ayoleg/models/servicesmodel.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

// import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class Tambahagendapage extends StatefulWidget {
  const Tambahagendapage({Key? key}) : super(key: key);

  @override
  State<Tambahagendapage> createState() => _TambahagendapageState();
}

class _TambahagendapageState extends State<Tambahagendapage> {
  // XFile? image;
  // late final bytes;
  late final pickedImage;
  String base64Image = "";
  String brtsts = "";

  // Uint8List ?imageFile;
  // ImagePicker picker = ImagePicker();
  var isiberitacontrolel = TextEditingController();
  var judulberitacontrolel = TextEditingController();
  var tanggalagendacontrolel = TextEditingController();

  late SharedPreferences sharedPrefs;
  bool isAppbarCollapsing = false;
  bool isLoading = false;
  bool visiblejudulberitaValid = false;
  bool visibleisiberitaValid = false;
  bool visibletanggalagenda = false;
  bool visibletimwagenda = false;
  String judulpage = "";
  String timeinput = "";
  String usrstatus = "";
  var ctime;
  int desiredQuality = 80;
  String fotoktpkosong = "";

  @override
  void initState() {
    setState(() {
      // fetchGetpendukung();
      timeinput = "";
      SharedPreferences.getInstance().then((prefs) {
        setState(() => sharedPrefs = prefs);
        brtsts = prefs.getString('brtsts')!;
        fotoktpkosong= prefs.getString('fotoktpkosong')!;
        usrstatus = prefs.getString('status')!;

        if (brtsts == "B") {
          judulpage = "Berita / Pesan";
        } else if (brtsts == "A") {
          judulpage = "Agenda";
        } else if (brtsts == "C") {
          judulpage = "Agenda";
        } else {
          judulpage = "Pesan";
        }
      });
    });

    super.initState();
  }

  String selectedTime="";

  Future<void> displayTimeDialog() async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        selectedTime = time.format(context);
      });
    }
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
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: greenPrimary,
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
                _imageBytes == null
                    ? Container(
                        width: 200,
                        height: 200,
                        child: Image.asset("assets/images/gambarnoncamera.png"),
                      )
                    : Image.memory(
                  _imageBytes!,
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Pilih Gambar'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() async {
                                          _pickImage(ImageSource.gallery);
                                          Navigator.pop(context);
                                          // image = await picker.pickImage(
                                          //     source: ImageSource.gallery);
                                        });
                                      },
                                      child: Text('Album'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() async {
                                          _pickImage(ImageSource.camera);
                                          Navigator.pop(context);
                                          // image = await picker.pickImage(
                                          //     source: ImageSource.camera);
                                        });
                                      },
                                      child: Text('Kamera'),
                                    ),
                                  ],
                                );
                              });
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
                            fontFamily: 'poppins', color: greyPrimary,fontSize: 12),
                        filled: true,
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      //Normal textInputField will be displayed
                      maxLines: 1000,
                      //
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: TextField(
                        style: const TextStyle(
                            fontFamily: 'poppins',

                            fontSize: 16,
                         ),
                        controller: tanggalagendacontrolel,
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
                              Icons.calendar_month,
                              color: greenPrimary,
                            ),
                            labelText: "Pilih Tanggal..",
                        labelStyle: TextStyle(
                            fontFamily: 'poppins', color: greyPrimary,fontSize: 12),
                        ),
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
                              tanggalagendacontrolel.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      )),
                ),
                Visibility(
                  visible: visibletanggalagenda,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Masukkan Tanggal Agenda !',
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
                              Icons.timer,
                              color: greenPrimary,
                            ),
                            TextButton(
                              onPressed: () async {
                                displayTimeDialog();
                              },
                              child:  selectedTime.isNotEmpty
                                  ? Text(
                                '$selectedTime',
                                style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 12,
                                  color: textPrimary,
                                ),
                              )
                                  :        Text(
                                  'Pilih Waktu',
                                style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 12,
                                ),
                              ),


                            ),
                          ]))
                    ],
                  ),
                ),
                Visibility(
                  visible: visibletimwagenda,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: Text(
                      'Masukkan Jam Agenda !',
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
                      maxLines: 1000,
                      //
                      // keyboardType: TextInputType.text,
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
                          if(_imageBytes == null){
                            checkEmpty(fotoktpkosong);
                          }else{
                            base64Image = await compressImageToBase64(pickedImage!.path, desiredQuality);
                            checkEmpty(base64Image);
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
        visibletanggalagenda = false;
        visibletimwagenda = false;
      });

    } else if (tanggalagendacontrolel.text.isEmpty) {
      setState(() {
        visibletanggalagenda = true;
        visibletimwagenda = false;
        visiblejudulberitaValid = false;
        visibleisiberitaValid = false;

        isLoading = false;
      });
    }else if (selectedTime.isEmpty) {
      setState(() {
        visibletanggalagenda = false;
        visibletimwagenda = true;
        visiblejudulberitaValid = false;
        visibleisiberitaValid = false;

        isLoading = false;
      });
    }else if (isiberitacontrolel.text.isEmpty) {
      setState(() {

        visibletanggalagenda = false;
        visibletimwagenda = false;
        visiblejudulberitaValid = false;
        visibleisiberitaValid = true;

        isLoading = false;
      });
    } else {
      setState(() {
        visibletanggalagenda = false;
        visibletimwagenda = false;
        visiblejudulberitaValid = false;
        visibleisiberitaValid = false;

        isLoading = true;

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

        tambahberita(fotoberita);
      });
    }
  }

  tambahberita(String fotoberita) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kodecaleg = prefs.getString('kodecaleg')!;
    String nohpAkun = prefs.getString('nohpregister')!;
    String namaAkun = prefs.getString('namaregister')!;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeformat = DateFormat("HH:mm:ss");
    String createDate = dateFormat.format(DateTime.now());
    String createtime = timeformat.format(DateTime.now());
    Map data = {
      'tmagd': selectedTime,
      'dtagd': tanggalagendacontrolel.text,
      'brtnm': namaAkun,
      'brtsts': brtsts,
      'brtkc': kodecaleg,
      'brthp': nohpAkun,
      'brtdp': createDate,
      'brttp': createtime,
      'brtjdl': judulberitacontrolel.text,
      'brtft': fotoberita,
      'brtbrt': isiberitacontrolel.text,
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/postagenda.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        notifyLogin();
        if (brtsts == "C") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CustomNavRelawanBar();
          }));
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

  Future<String> notifyLogin() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokencaleg = prefs.getString('tokencaleg')!;
    String namaAkun = prefs.getString('namaregister')!;
    final body = {
      "to" : tokencaleg,
      "notification" : {
        "body" : judulberitacontrolel.text,
        "title": "Info "+judulpage+" "+namaAkun+" ("+usrstatus+")",
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
