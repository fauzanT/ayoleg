// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';

import 'package:ayoleg/camera_preview.dart';
import 'package:ayoleg/cameraktp/cameraktpview.dart';
import 'package:ayoleg/register.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_image_compress/flutter_image_compress.dart';


class CameraKTPPage extends StatefulWidget {
  const CameraKTPPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<CameraKTPPage> createState() => _CameraKTPPageState();
}

class _CameraKTPPageState extends State<CameraKTPPage> {
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

                            // , imageQuality: 0);


                            setState(() async {

                              // File file = File(image!.path);
                              // Uint8List bytes = file.readAsBytesSync();
                              // img64foto = base64Encode(bytes);
                              bytes = File(image!.path).readAsBytesSync();
                              img64foto = await compressImageToBase64(image!.path, desiredQuality);

                              prefs.setString("fotoktpregister", img64foto);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PReviewIamgePage(

                                      )));

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

      // Uint8List image = bytes;

      // String img64 = base64Encode(image);
      // img64foto = img64;
      //
      //
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("fotoktpregister", img64foto);
      img64foto = await compressImageToBase64(picture.path, desiredQuality);


      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("fotoktpregister", img64foto);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PReviewIamgePage(

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
