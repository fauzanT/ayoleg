// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';
import 'package:ayoleg/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Dataprofinsi>> fetchGetDataprofinsi() async {
  final response = await http
      .get(Uri.parse('http://aplikasiayocaleg.com/ayocalegapi/getprofinsi.php'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Dataprofinsi.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Datakota>> fetchGetDatakota(String profinsi) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getkota.php?ktpr=' + profinsi));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Datakota.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Datakecamatan>> fetchGetDatakecamatan(String kota) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getkecamatan.php?kckt=' + kota));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Datakecamatan.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Datakelurahan>> fetchGetDatakelurahan(String kecamatan) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getkelurahan.php?klkc=' + kecamatan));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Datakelurahan.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Datarelawan>> fetchGetDataRelawan(
    String kodecaleg, String stscaleg) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getrelawan.php?usrkc=' +
          kodecaleg +
          '&usrsts=' +
          stscaleg));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Datarelawan.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Datadaerahpemilihan>> fetchGetDatadaerahpemilihan(
    String dplkc) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getdaerahpemilihan.php?dplkc=' +
          dplkc));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((data) => Datadaerahpemilihan.fromJson(data))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<List<dynamic>> fetchDatadapil(String dplkc) async {
  final response = await http.get(Uri.parse('http://aplikasiayocaleg.com/ayocalegapi/getdaerahpemilihan.php?dplkc=' +
      dplkc));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    final jsonData = json.decode(response.body);
    return jsonData;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load data');
  }
}

Future<List<Datasaksi>> fetchGetDatasaksi(
    String srakc) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getsaksi.php?srakc=' + srakc));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((data) => Datasaksi.fromJson(data))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<List<GetPemenagan>> fetchGetDataPEmenangan() async {
  final response =
      await http.post(Uri.parse('http://ayoscan.id/api/tutor/listCat'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    var result =
        jsonResponse.map((data) => GetPemenagan.fromJson(data)).toList();
    return result;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<GetPendukung>> fetchGetpendukung() async {
  final response =
      await http.post(Uri.parse('http://ayoscan.id/api/tutor/listCat'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    var result =
        jsonResponse.map((data) => GetPendukung.fromJson(data)).toList();
    return result;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Databerita>> fetchGetDataberita(String brtkc, String brtsts) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getberita.php?brtkc=' + brtkc+"&brtsts="+brtsts));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Databerita.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<List<Databeritaagenda>> fetchGetDataberitaagenda(String brtkc, String brtsts) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getberita.php?brtkc=' + brtkc+"&brtsts="+brtsts));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Databeritaagenda.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Datapendukung>> fetchGetDataPendukung(String usrhpr) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getpendukung.php?usrhpr=' + usrhpr));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Datapendukung.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Datapendukungpendukung>> fetchGetDataPendukungPendukung(String usrkp) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getpendukung2.php?usrkp=' + usrkp));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Datapendukungpendukung.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}


Future<List<Datanewdukungan>> fetchGetDataNewDukungan(String usrkc) async {
  final response = await http.get(Uri.parse(
      'http://aplikasiayocaleg.com/ayocalegapi/getnewdukungan.php?usrkc=' + usrkc));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Datanewdukungan.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

int page = 5;
Future<List<Datarelawan>> getData(int pageCount,int limit) async {
  final response = await http.get(Uri.parse(
      "http://aplikasiayocaleg.com/ayocalegapi/getrelawan1.php?_page=$pageCount&_limit=$limit"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    page++;
    return jsonResponse.map((data) => Datarelawan.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}






// Future<List<Datarelawan>> getData(int pageCount) async {
//   String url =
//   Uri.encodeFull("http://aplikasiayocaleg.com/ayocalegapi/getrelawan1.php?page=$pageCount");
//   var response = await http.get(url as Uri, headers: {
//     "Accept": "application/json"
//   }).timeout(const Duration(seconds: 10));
//   if (response.statusCode == 200) {
//     List jsonResponse = json.decode(response.body);
//     page++;
//     return jsonResponse.map((data) => Datarelawan.fromJson(data)).toList();
//   } else {
//     throw Exception('Unexpected error occured!');
//   }



