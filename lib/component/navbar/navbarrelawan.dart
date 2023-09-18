
import 'package:ayoleg/berita/pesan.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/home.dart';
import 'package:ayoleg/home1.dart';
import 'package:ayoleg/keuangan/keuanganrelawan.dart';
import 'package:ayoleg/suara/suara.dart';
import 'package:ayoleg/team/pendukung.dart';
import 'package:ayoleg/team/saksi.dart';
import 'package:bmnav_null_safety/bmnav_null_safety.dart' as bmnav;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomNavRelawanBar extends StatefulWidget {
  const CustomNavRelawanBar({Key? key}) : super(key: key);

  @override
  State<CustomNavRelawanBar> createState() => _CustomNavRelawanBarState();
}

class _CustomNavRelawanBarState extends State<CustomNavRelawanBar> {

  late BuildContext myContext;
  int currentTab = 0;
  List screens = [
    ShowCaseWidget(
        enableAutoScroll: true,
        builder: Builder(builder: (context) {
          // return const HomePage();
          return const MyHome();
        })),
    const Pesanpage(),
    const SuaraPage(),
    const KeuangaRelawannpage(),
  ];
  Widget currentScreen = const HomePage();
  PageController controller = PageController();
  late SharedPreferences sharedPrefs;
  String usrsts = "";

  @override
  void initState() {


    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
      usrsts = prefs.getString('usrsts')!;


    });

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      extendBody: true,
      body: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          controller: controller,
          onPageChanged: (page) {
            setState(() {
              currentTab = page;
            });
          },
          itemBuilder: (context, position) {
            return Center(
              child: screens[currentTab],
            );
          }),
      bottomNavigationBar: BottomAppBar(
        child: bmnav.BottomNav(
          iconStyle: const bmnav.IconStyle(onSelectColor: greenPrimary),
          color: whitePrimary,
          index: currentTab,
          labelStyle: const bmnav.LabelStyle(
            textStyle: TextStyle(fontFamily: 'poppins', color: Colors.grey),
            visible: true,
            onSelectTextStyle:
            TextStyle(fontFamily: 'poppins', color: greenPrimary),
          ),
          onTap: (i) {
            setState(() {
              currentTab = i;
              currentScreen = screens[i];
            });
          },
          items: const [
            bmnav.BottomNavItem(icon: Icons.home, label: 'Beranda'),
            bmnav.BottomNavItem(
                icon: Icons.newspaper_outlined, label: 'Info'),

            // bmnav.BottomNavItem(icon: Icons.expand_more, label: 'Scan'),
            bmnav.BottomNavItem(icon: Icons.speaker_notes_outlined, label: 'Suara'),
            bmnav.BottomNavItem(
                icon: Icons.money_outlined, label: 'Keuangan')
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.only(left: 7, right: 7),
          child: Icon(
            Icons.people_alt_outlined,
            color: Colors.white,
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [greenPrimary, greenPrimary])),
        ),
        onPressed: () {

          if(usrsts=="R") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Pendukungpage()));
          }
          else{
            setState(() async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('fotoimage');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Saksipage()));
            });

          }


        },
      ),
    )

    );
  }
}
