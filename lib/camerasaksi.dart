// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';

import 'package:ayoleg/camera_preview.dart';
import 'package:ayoleg/team/saksi.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
// import 'package:flutter_camera_practice/preview_page.dart';

class CameraSaksiPage extends StatefulWidget {
  const CameraSaksiPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<CameraSaksiPage> createState() => _CameraSaksiPageState();
}

class _CameraSaksiPageState extends State<CameraSaksiPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

    File? image;
      late final bytes;
  String img64foto = "";

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
    final img.Image? capturedImage =
        img.decodeImage(await File(picture.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    await File(picture.path).writeAsBytes(img.encodeJpg(orientedImage));

    bytes = File(picture.path).readAsBytesSync();

       Uint8List image = bytes;
        
    String img64 = base64Encode(image);
    img64foto = img64;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fotoSaksi", img64foto);


      
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Saksipage(
                    
                  ))); 
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
       
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        (_cameraController.value.isInitialized)
            ? CameraPreview(_cameraController)
            : Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator())),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  color: Colors.black),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // Expanded(
                //     child: IconButton(
                //   padding: EdgeInsets.zero,
                //   iconSize: 30,
                //   icon: Icon(
                //       _isRearCameraSelected
                //           ? CupertinoIcons.switch_camera
                //           : CupertinoIcons.switch_camera_solid,
                //       color: Colors.white),
                //   onPressed: () {
                //     setState(
                //         () => _isRearCameraSelected = !_isRearCameraSelected);
                //     initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                //   },
                // )),
                Expanded(
                    child: IconButton(
                  onPressed: takePicture,
                  iconSize: 50,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.circle, color: Colors.white),
                )),
                const Spacer(),
              ]),
            )),
      ]),
    ));
  }
}

// import 'dart:convert';
// import 'package:ayoleg/component/colors/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:image/image.dart' as img;

// class TambahProduct extends StatefulWidget {
//   const TambahProduct({Key? key}) : super(key: key);

//   @override
//   _TambahProductState createState() => _TambahProductState();
// }

// class _TambahProductState extends State<TambahProduct> {

//   var typeproduk;
//   static const _typeproduk = ['Reguler', 'Promo'];
//   var pilihkondisi;
//   static const kondisibarang = ['Baru', 'Bekas'];
//   File? image;
//   late final bytes;
//   String img64foto = "";
//   String nohpregister = "";
//   String namatokosel = "";
//   String logotokosel = "";
//   String idkategori = "";
//   String kategoribg = "";
//   String kondisibrg = "";
//   String hasil = "";
//   String _idcat = "";
//   String _nmcat = "";
//   String _idcatsub = "";
//   String _nmcatsub = "";
//   int tot = 0;
//   String converttot = "";
//   String typeprd = "";
//   var nmprdcontroller = TextEditingController();
//   var katgrprdcontroller = TextEditingController();
//   var desprdcontroller = TextEditingController();
//   var hrgprdcontroller = TextEditingController();
//   var hrgprpprdcontroller = TextEditingController();
//   var prdrmkcontroller = TextEditingController();
//   var prdloccontroller = TextEditingController();
//   var stkprdcontroller = TextEditingController();
//   var brtprdcontroller = TextEditingController();
//   var sizeprdcontroller = TextEditingController();
//   var panjangcontroller = TextEditingController();
//   var lebarcontroller = TextEditingController();
//   var tinggicontroller = TextEditingController();
//   bool fotoprd = false;
//   bool namaprd = false;
//   bool ktgeprd = false;
//   bool deskprd = false;
//   bool hrgprd = false;
//   bool stkprd = false;
//   bool brtprd = false;
//   bool pjgprd = false;
//   bool lbrprd = false;
//   bool tggprd = false;
//   bool conprd = false;
//   bool typprd = false;

//   Future getImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? imagePicked = await _picker.pickImage(
//         source: ImageSource.gallery, maxHeight: 640, maxWidth: 480);
//     image = File(imagePicked!.path);

//     final img.Image? capturedImage =
//         img.decodeImage(await File(imagePicked.path).readAsBytes());
//     final img.Image orientedImage = img.bakeOrientation(capturedImage!);
//     await File(imagePicked.path).writeAsBytes(img.encodeJpg(orientedImage));

//     bytes = File(imagePicked.path).readAsBytesSync();
//     String img64 = base64Encode(bytes);
//     img64foto = img64;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString("image", img64foto);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: greenPrimary,
//         elevation: 0.0,
//         title: Text(
//           'Tambah Produk',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.only(left: 20, right: 20),
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: 10),
//                 child: Text(
//                   'Tambahkan Foto Produk',
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54),
//                 ),
//               ),
//               image != null
//                   ? Container(
//                       margin: EdgeInsets.only(top: 10, left: 15),
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(width: 2, color: greenPrimary),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Image.file(
//                         image!,
//                         fit: BoxFit.cover,
//                       ))
//                   : Container(
//                       margin: EdgeInsets.only(top: 10, left: 15),
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(width: 2, color: greenPrimary),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: GestureDetector(
//                         onTap: () async {
//                           getImage();
//                         },
//                         child: Icon(
//                           Icons.add,
//                           size: 40,
//                           color: greenPrimary,
//                         ),
//                       ),
//                     ),
//               Visibility(
//                 visible: fotoprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Foto Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 20),
//                 child: Text(
//                   'Tambahkan Info Produk',
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 alignment: Alignment.center,
//                 child: TextField(
//                   controller: nmprdcontroller,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusColor: greenPrimary,
//                     hintText: "Masukan Nama Produk",
//                     hintStyle: TextStyle(color: Colors.black54),
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: 'Nama Produk',
//                     labelStyle: TextStyle(fontSize: 18),
//                     floatingLabelStyle: TextStyle(color: greenPrimary),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                   ),
//                   autofocus: false,
//                   textCapitalization: TextCapitalization.sentences,
//                 ),
//               ),
//               Visibility(
//                 visible: namaprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Nama Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   // futureDataKategoriInput = fetchDataKategoriInput();
//                   // showModalBottomSheet(
//                   //     context: context,
//                   //     builder: (context) {
//                   //       return Container(
//                   //         margin: EdgeInsets.symmetric(horizontal: 10),
//                   //         child: FutureBuilder<List<DataKategoriInput>>(
//                   //           future: futureDataKategoriInput,
//                   //           builder: (context, snapshot) {
//                   //             if (snapshot.hasData) {
//                   //               List<DataKategoriInput>? data = snapshot.data;
//                   //               return ListView.builder(
//                   //                   shrinkWrap: true,
//                   //                   physics: BouncingScrollPhysics(),
//                   //                   scrollDirection: Axis.vertical,
//                   //                   itemCount: snapshot.data!.length,
//                   //                   itemBuilder: (context, index) {
//                   //                     return GestureDetector(
//                   //                       onTap: () async {
//                   //                         _idcat = data![index].idcat;
//                   //                         setState(() {
//                   //                           _nmcat = data[index].nmcat;
//                   //                         });
//                   //                         Navigator.of(context).pop();
//                   //                         subkategori();
//                   //                         futureDataSubKategorilist =
//                   //                             fetchDataSubKategori(_idcat);
//                   //                       },
//                   //                       child: Card(
//                   //                           color: Putih,
//                   //                           shape: RoundedRectangleBorder(
//                   //                             borderRadius: BorderRadius.all(
//                   //                                 Radius.circular(10.0)),
//                   //                           ),
//                   //                           clipBehavior: Clip.antiAlias,
//                   //                           elevation: 5,
//                   //                           child: Container(
//                   //                             padding: EdgeInsets.symmetric(
//                   //                                 vertical: 15, horizontal: 10),
//                   //                             alignment: Alignment.centerLeft,
//                   //                             child: Text(
//                   //                               data![index].nmcat,
//                   //                               style: TextStyle(
//                   //                                   color: Colors.black,
//                   //                                   fontWeight: FontWeight.bold,
//                   //                                   fontSize: 12),
//                   //                             ),
//                   //                           )),
//                   //                     );
//                   //                   });
//                   //             } else if (snapshot.hasError) {
//                   //               return Center(
//                   //                 child: CircularProgressIndicator(),
//                   //               );
//                   //             }
//                   //             return Center(
//                   //               child: CircularProgressIndicator(),
//                   //             );
//                   //           },
//                   //         ),
//                   //       );
//                   //     });
               
               
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   decoration: BoxDecoration(
//                     color: Colors.white10,
//                     border: Border.all(
//                       color: greenPrimary,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _idcatsub.isEmpty
//                           ? Text(
//                               'Pilih Kategori',
//                               style: TextStyle(color: greenPrimary),
//                             )
//                           : Text(_nmcat + "/" + _nmcatsub,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(color: greenPrimary)),
//                       Icon(Icons.arrow_drop_down),
//                     ],
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: ktgeprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Kategori Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 alignment: Alignment.center,
//                 child: TextField(
//                   controller: desprdcontroller,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusColor: greenPrimary,
//                     hintText: "Masukan Deskripsi Produk",
//                     hintStyle: TextStyle(color: Colors.black54),
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: 'Deskripsi Produk',
//                     labelStyle: TextStyle(fontSize: 18),
//                     floatingLabelStyle: TextStyle(color: greenPrimary),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                   ),
//                   autofocus: false,
//                   textCapitalization: TextCapitalization.sentences,
//                 ),
//               ),
//               Visibility(
//                 visible: ktgeprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Kategori Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 alignment: Alignment.center,
//                 child: Material(
//                   borderRadius: BorderRadius.all(Radius.circular(15)),
//                   elevation: 1.0,
//                   shadowColor: Colors.grey,
//                   child: TextField(
//                     controller: hrgprdcontroller,
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: greenPrimary, width: 2),
//                           borderRadius: BorderRadius.all(Radius.circular(15))),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: greenPrimary, width: 2),
//                           borderRadius: BorderRadius.all(Radius.circular(15))),
//                       focusColor: greenPrimary,
//                       hintText: "Masukan Harga Produk",
//                       hintStyle: TextStyle(color: Colors.black54),
//                       filled: true,
//                       fillColor: Colors.white,
//                       labelText: 'Harga Produk',
//                       labelStyle: TextStyle(fontSize: 18),
//                       floatingLabelStyle: TextStyle(color: greenPrimary),
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                     ),
//                     keyboardType: TextInputType.number,
//                     autofocus: false,
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: hrgprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Harga Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 alignment: Alignment.center,
//                 child: TextField(
//                   controller: stkprdcontroller,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusColor: greenPrimary,
//                     hintText: "Masukan Stok Produk",
//                     hintStyle: TextStyle(color: Colors.black54),
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: 'Stok Produk',
//                     labelStyle: TextStyle(fontSize: 18),
//                     floatingLabelStyle: TextStyle(color: greenPrimary),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                   ),
//                   keyboardType: TextInputType.number,
//                   autofocus: false,
//                 ),
//               ),
//               Visibility(
//                 visible: stkprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Stok Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 alignment: Alignment.center,
//                 child: TextField(
//                   controller: brtprdcontroller,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusColor: greenPrimary,
//                     hintText: "Masukan Berat Produk",
//                     hintStyle: TextStyle(color: Colors.black54),
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: 'Berat Produk',
//                     labelStyle: TextStyle(fontSize: 18),
//                     floatingLabelStyle: TextStyle(color: greenPrimary),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                   ),
//                   keyboardType: TextInputType.number,
//                   autofocus: false,
//                 ),
//               ),
//               Visibility(
//                 visible: brtprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Berat Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 alignment: Alignment.center,
//                 child: TextField(
//                   controller: panjangcontroller,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusColor: greenPrimary,
//                     hintText: "Masukan Panjang Produk",
//                     hintStyle: TextStyle(color: Colors.black54),
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: 'Panjang Produk',
//                     labelStyle: TextStyle(fontSize: 18),
//                     floatingLabelStyle: TextStyle(color: greenPrimary),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                   ),
//                   keyboardType: TextInputType.number,
//                   autofocus: false,
//                 ),
//               ),
//               Visibility(
//                 visible: pjgprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Panjang Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 alignment: Alignment.center,
//                 child: TextField(
//                   controller: lebarcontroller,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusColor: greenPrimary,
//                     hintText: "Masukan Lebar Produk",
//                     hintStyle: TextStyle(color: Colors.black54),
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: 'Lebar Produk',
//                     labelStyle: TextStyle(fontSize: 18),
//                     floatingLabelStyle: TextStyle(color: greenPrimary),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                   ),
//                   keyboardType: TextInputType.number,
//                   autofocus: false,
//                 ),
//               ),
//               Visibility(
//                 visible: lbrprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Lebar Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 alignment: Alignment.center,
//                 child: TextField(
//                   onChanged: (hasil) {
//                     int a = int.parse(panjangcontroller.text);
//                     int b = int.parse(lebarcontroller.text);
//                     int c = int.parse(hasil);

//                     tot = a * b * c;
//                     converttot = "$tot";
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(SnackBar(content: Text(converttot)));
//                   },
//                   controller: tinggicontroller,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: greenPrimary, width: 2),
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     focusColor: greenPrimary,
//                     hintText: "Masukan Tinggi Produk",
//                     hintStyle: TextStyle(color: Colors.black54),
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: 'Tinggi Produk',
//                     labelStyle: TextStyle(fontSize: 18),
//                     floatingLabelStyle: TextStyle(color: greenPrimary),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                   ),
//                   keyboardType: TextInputType.number,
//                   autofocus: false,
//                 ),
//               ),
//               Visibility(
//                 visible: tggprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Tinggi Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                     color: greenPrimary,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Ukuran Produk =" + " " + converttot + ' ' + 'cm³',
//                   style: TextStyle(
//                     color: greenPrimary,
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),

//                 child: FormField<String>(
//                   builder: (FormFieldState<String> state) {
//                     return InputDecorator(
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: greenPrimary,width: 2),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15))),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: greenPrimary,width: 2),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15))),
//                         fillColor: greenPrimary,
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           hint: Text("Pilih Kondisi Barang"),
//                           value: pilihkondisi,
//                           isDense: true,
//                           onChanged: (newValue) async {
//                             setState(() {
//                               pilihkondisi = newValue;
//                             });
//                             print(pilihkondisi);
//                             if (newValue == "Baru") {
//                               setState(() async {
//                                 kondisibrg = "Baru";
//                               });
//                             } else if (newValue == "Bekas") {
//                               setState(() async {
//                                 kondisibrg = "Bekas";
//                               });
//                             }
//                           },
//                           items: kondisibarang.map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Visibility(
//                 visible: conprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Kondisi Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 child: FormField<String>(
//                   builder: (FormFieldState<String> state) {
//                     return InputDecorator(
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: greenPrimary,width: 2),
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(15))),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: greenPrimary,width: 2),
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(15))),
//                         fillColor: whitePrimary,
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           hint: Text("Pilih Tipe Produk"),
//                           value: typeproduk,
//                           isDense: true,
//                           onChanged: (newValue) async {
//                             setState(() {
//                               typeproduk = newValue;
//                             });
//                             print(typeproduk);
//                             if (newValue == "Reguler") {
//                               setState(() async {
//                                 typeprd = "Reguler";
//                               });
//                             } else if (newValue == "Promo") {
//                               setState(() async {
//                                 typeprd = "Promo";
//                               });
//                             }
//                           },
//                           items: _typeproduk.map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Visibility(
//                 visible: typprd,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                   child: Text(
//                     'Tipe Produk Harus Di isi!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: greenPrimary,
//                     onPrimary: Colors.white,
//                     shadowColor: greenPrimary,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0)),
//                     minimumSize: Size(150, 40), //////// HERE
//                   ),
//                   onPressed: () async {
                  
//                   },
//                   child: Text('Upload'),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }


// }
