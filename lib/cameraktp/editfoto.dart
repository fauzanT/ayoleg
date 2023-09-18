// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';

import 'package:ayoleg/account.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';


class EditFotoPage extends StatefulWidget {
  const EditFotoPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<EditFotoPage> createState() => _EditFotoPageState();
}

class _EditFotoPageState extends State<EditFotoPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  XFile? image;
  // File? image;
  late final bytes;
  String img64foto = "";
  ImagePicker picker = ImagePicker();
  int desiredQuality = 80;
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
                    Expanded(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 30,
                          icon: Icon(
                              _isRearCameraSelected
                                  ? CupertinoIcons.switch_camera
                                  : CupertinoIcons.switch_camera_solid,
                              color: Colors.white),
                          onPressed: () {
                            setState(
                                    () => _isRearCameraSelected = !_isRearCameraSelected);
                            initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                          },
                        )),
                    Expanded(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 30,
                          icon: Icon(
                              Icons.photo_library,
                              color: Colors.white),
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            image = await picker.pickImage(
                                source: ImageSource.gallery);

                            setState(() async {

                              bytes = File(image!.path).readAsBytesSync();
                              img64foto = await compressImageToBase64(image!.path, desiredQuality);

                              // prefs.setString("fotoakun", img64foto);
                              ubahFoto(img64foto);


                            });
                          },
                        )),
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

  ubahFoto(String foto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nohpAkun = prefs.getString('nohpregister')!;
    String fotoregisterubah = prefs.getString('fotoregisterubah')!;


    Map data = {
      'usrhp': nohpAkun,
      'usrft': foto,
    };

    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/updatefoto.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          // prefs.setString('fotoregister',foto);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const AccountPage();
              }));

          deletefoto(fotoregisterubah);
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Ubah Foto Berhasil !")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Ubah Foto Gagal !")));
      }
    } else {}
  }

  deletefoto(String foto) async {
    Map data = {
      'dltft': foto,
    };
    dynamic jsonResponse;
    var response = await http.post(
        Uri.parse("http://aplikasiayocaleg.com/ayocalegapi/postdlt.php"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
      }
    } else {}
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


      img64foto = await compressImageToBase64(picture.path, desiredQuality);

      ubahFoto(img64foto);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("fotoakun", img64foto);


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

  Future<String> compressImageToBase64(String imagePath, int quality) async {
    File file = File(imagePath);
    List<int> imageBytes = await file.readAsBytes();

    List<int> compressedBytes = await FlutterImageCompress.compressWithList(
      bytes,
      minHeight: 500, // Set the minimum height (optional)
      minWidth: 500, // Set the minimum width (optional)
      quality: quality, // Set the desired quality (0-100)
      format: CompressFormat.jpeg, // Set the desired output format
    );

    String base64String = base64Encode(compressedBytes);
    return base64String;
  }
}
