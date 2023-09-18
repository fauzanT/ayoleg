import 'dart:convert';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/otp/otplupa.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LupaPin extends StatefulWidget {
  const LupaPin({Key? key}) : super(key: key);

  @override
  State<LupaPin> createState() => _LupaPinState();
}

class _LupaPinState extends State<LupaPin> {
  var nohpcontrollel = TextEditingController();

  String otpacak = "";

  bool visiblenohp = false;
  bool visibleerorlogin = false;
  bool _isLoading = false;
  bool visible = false;
  bool visibleTidakValid = false;
  var errorMsg;
  Future<void> onBackPressed() async {
    setState(() {
      Navigator.pushNamedAndRemoveUntil(
          context, '/LoginPage', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        onBackPressed(); // Action to perform on back pressed
        return false;
      },
      child: Stack(
        children: [
          Container(
            color: whitePrimary,
            height: size.height,
            width: size.width,
            // child: Image.asset(
            //   "assets/images/g7.png",
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   alignment: Alignment.bottomCenter,
            // ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: whitePrimary,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: whitePrimary,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              elevation: 0,
              leading: FadeInUp(
                duration: Duration(milliseconds: 400),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/LoginPage');
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: greyPrimary,
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  FadeInUp(
                    duration: Duration(milliseconds: 400),
                    child: Container(
                      width: 150,
                      height: 100,
                      child: Image.asset("assets/images/ayoscan_logo.jpeg"),
                    ),
                  ),
                  Container(
                    width: 50,
                  )
                ],
              ),
            ),
            body: ListView(
              children: [
                FadeInUp(
                  duration: Duration(milliseconds: 600),
                  child: SizedBox(
                    // margin: const EdgeInsets.all(7),
                    height: size.height * 0.20,
                    width: size.height * 0.20,
                    child: ClipRRect(
                      child: Image.asset('assets/images/otp.png'),
                    ),
                  ),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   width: size.width * 0.65,
                //   child: Image.asset('assets/images/otp.png'),
                // ),
                FadeInUp(
                  duration: Duration(milliseconds: 800),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: const [
                        Text(
                          'Silahkan Masukkan Nomor Kamu yang Telah Terdaftar',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: greenPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "No. HP",
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            color: greenPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                FadeInUp(
                  duration: Duration(milliseconds: 1100),
                  child: Container(
                    alignment: Alignment.center,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      controller: nohpcontrollel,
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          color: greenPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                nohpcontrollel.clear();
                                visibleTidakValid = false;
                                visibleerorlogin = false;
                                visiblenohp = false;
                                visible = false;
                              });
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: greenPrimary,
                            )),
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(
                              top: 12.0, left: 10.0, right: 10.0),
                          child: const Text(
                            '+62',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 13,
                                color: greenPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        fillColor: whitePrimary,
                        hintText: "8xxxxxxxxxx",
                        hintStyle: const TextStyle(
                            fontFamily: 'poppins', color: greyPrimary),
                        filled: true,
                      ),
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                    ),
                  ),
                ),
                Visibility(
                  visible: visiblenohp,
                  child: Padding(
                    //ROW 1
                    padding: EdgeInsets.fromLTRB(30, 0, 10, 10),
                    child: Text(
                      'Masukkan No. HP Anda !',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),

                Visibility(
                  visible: visibleerorlogin,
                  child: Padding(
                    //ROW 1
                    padding: EdgeInsets.fromLTRB(30, 0, 10, 10),
                    child: Text(
                      'No. HP Belum Terdaftar !',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleTidakValid,
                  child: Padding(
                    //ROW 1
                    padding: EdgeInsets.fromLTRB(30, 0, 10, 10),
                    child: Text(
                      'No. HP Tidak Valid !',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FadeInUp(
                  duration: Duration(milliseconds: 1300),
                  child: Container(
                    // margin: EdgeInsets.only(top: size.height * 0.03),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: greenPrimary,
                        onPrimary: Colors.white,

                        shadowColor: Colors.blue.shade800,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minimumSize: const Size(150, 40), //////// HERE
                      ),
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                          check();
                        });
                      },
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              margin: EdgeInsets.all(12),
                              child: Text(
                                'Lanjut',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  check() {
    if (nohpcontrollel.text.isEmpty) {
      setState(() {
        _isLoading = false;
        visiblenohp = true;
        _isLoading = false;
        visibleerorlogin = false;
        visibleTidakValid = false;
      });
    } else if (nohpcontrollel.text.length < 9) {
      setState(() {
        _isLoading = false;
        visiblenohp = false;
        _isLoading = false;
        visibleerorlogin = false;
        visibleTidakValid = true;
      });
    } else {
      sendforgot();
    }
  }

  // Future<void> displayingNotification(String title, String desc) async {
  //   var androidDetail = AndroidNotificationDetails(
  //     "id",
  //     "name",
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     showWhen: false,
  //   );
  //   var iosDetail = IOSNotificationDetails();
  //   final allDetail =
  //       NotificationDetails(android: androidDetail, iOS: iosDetail);
  //   await fP.show(0, "Kode OTP : " + title, desc, allDetail,
  //       payload: "first notifications");
  // }

  sendforgot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'nohp': "62" + nohpcontrollel.text,
    };

    var jsonResponse;
    var response = await http.post(Uri.parse("https://ayoscan.id/api/ceknohp"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
//      print(jsonResponse);
      if (jsonResponse != null) {
        if (jsonResponse['dataceknohp'] == null) {
          setState(() {
            _isLoading = false;
            visiblenohp = false;
            visibleerorlogin = true;
            visibleTidakValid = false;
          });
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text("Kode OTP Dikirim Di Email Anda !")));
          prefs.setString("nohpregister", "62" + nohpcontrollel.text);
          prefs.setString(
              "emailregister", jsonResponse['dataceknohp']['usremail']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => OtpForgot()),
              (Route<dynamic> route) => false);

          setState(() {
            // otpGmail();
            sendEmail(jsonResponse['dataceknohp']['usremail']);
            _isLoading = false;
            visiblenohp = false;
            visibleerorlogin = false;
            visibleTidakValid = false;
          });
        }
        //

      } else {
        setState(() {
          _isLoading = false;
          visiblenohp = false;
          visibleerorlogin = true;
          visibleTidakValid = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        visiblenohp = false;
        visibleerorlogin = true;
        visibleTidakValid = false;
      });
    }
  }
Future sendEmail(String email) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();

 final int min = 1000;
    final int max = 9999;
    var otpcodee = new Random().nextInt((max - min) + 1) + min;
    var otpacak = otpcodee.toString();
     prefs.setString('otpregis', otpacak);

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_djte5n9';
  const templateId = 'template_looq5wl';
  const userId = 'e_d1c68qNH_pPlxv5';
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json',
      'origin': 'http://localhost'},//This line makes sure it works for all platforms.
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_name': " ",
          'from_name': "AYOSCAN",
          'to_email': email,
          'message': otpacak
        }
      }));

       if (response.statusCode == 200) {
      Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const OtpForgot();
        }));
       }
  // return response.statusCode;
}
  // otpGmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String emailregister = prefs.getString('emailregister')!;
  //   final int min = 1000;
  //   final int max = 9999;
  //   var otpcodee = new Random().nextInt((max - min) + 1) + min;
  //   var otpacak = otpcodee.toString();
  //   prefs.setString('otpregis', otpacak);

  //   Map data = {
  //     'subject': "OTP Lupa PIN Dari Ayoscan",
  //     'title': "OTP dari Ayocan",
  //     'body': otpacak,
  //     'emailto': emailregister,
  //     'emailPurpouse': 'register'
  //   };
  //   dynamic jsonResponse;
  //   var response = await http
  //       .post(Uri.parse("https://ayoscan.id/api/sendEmail"), body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) {
  //         return const OtpForgot();
  //       }));
  //     } else {
  //       print("Error");
  //     }
  //   }
  // }

  // Future kirimOtpEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final int min = 1000;
  //   final int max = 9999;
  //   var otpcodee = new Random().nextInt((max - min) + 1) + min;
  //   otpacak = otpcodee.toString();
  //   String? nohpAkun = prefs.getString('nohpregister');

  //   prefs.setString("otpcode", otpacak);
  //   Map data = {
  //     'subject': "OTP Lupa PIN Dari Ayoscan",
  //     'title': "OTP Lupa PIN Ayoscan",
  //     'body': otpacak,
  //     'nohp': nohpAkun,
  //     'emailPurpouse': 'forgot',
  //     'forgot_type': 'forgot_otp'
  //   };

  //   dynamic jsonResponse;
  //   var response = await http
  //       .post(Uri.parse("https://ayoscan.id/api/sendEmail"), body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       sendforgot();

  //       // Navigator.pushReplacement(context,
  //       //     MaterialPageRoute(builder: (context) {
  //       //   return CustomNavBar();
  //       // }));
  //     }
  //   } else {
  //     print("Error");
  //   }
  // }

  // Future<String> otpverivikasi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  //   DateFormat timeformat = DateFormat("HH:mm:ss");
  //   String createDate = dateFormat.format(DateTime.now());
  //   String createtime = timeformat.format(DateTime.now());

  //   final int min = 1000;
  //   final int max = 9999;
  //   var otpcodee = new Random().nextInt((max - min) + 1) + min;
  //   var otpacak = otpcodee.toString();

  //   prefs.setString("otpcode", otpacak);

  //   final body = {
  //     'is_Flash': false,
  //     'is_Unicode': false,
  //     'apiKey': "tuNcvoP4EbxseRQHx9MqP1cfLLcBwwNznqJ9qdyzTMI=",
  //     'message': "KODE RAHASIA AYOSCAN: " +
  //         otpacak +
  //         " BERLAKU HINGGA " +
  //         createDate +
  //         " " +
  //         createtime +
  //         " WIB WASPADA PENIPUAN! JANGAN BERIKAN KODE RAHASIA KE SIAPAPUN",
  //     'mobileNumbers': "62" + nohpcontrollel.text,
  //     'clientId': "d3e7fd85-6e6f-4a0c-b9c9-2448b8f769f0",
  //     'senderId': "Ayoscan",
  //   };

  //   HttpClient httpClient = new HttpClient();
  //   HttpClientRequest request = await httpClient
  //       .postUrl(Uri.parse("https://api.tcastsms.net/api/v2/SendSMS?"));
  //   request.headers.set('content-type', 'application/json');
  //   request.add(utf8.encode(json.encode(body)));
  //   HttpClientResponse response = await request.close();
  //   // todo - you should check the response.statusCode
  //   if (response.statusCode == 200) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Code OTP Sedang Dikirim!")));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("failed!")));
  //   }
  //   String reply = await response.transform(utf8.decoder).join();
  //   httpClient.close();
  //   return reply;
  // }
}
