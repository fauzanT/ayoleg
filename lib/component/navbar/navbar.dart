import 'package:ayoleg/account.dart';
import 'package:ayoleg/berita/pesan.dart';
import 'package:ayoleg/component/colors/colors.dart';
import 'package:ayoleg/home.dart';
import 'package:ayoleg/home1.dart';
import 'package:ayoleg/keuangan/keuangan.dart';
import 'package:ayoleg/statistik/datastatistik.dart';

import 'package:ayoleg/suara/suara.dart';
import 'package:ayoleg/team/team.dart';
import 'package:bmnav_null_safety/bmnav_null_safety.dart' as bmnav;
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late BuildContext myContext;
  int currentTab = 0;
  List screens = [
    ShowCaseWidget(
        enableAutoScroll: true,
        builder: Builder(builder: (context) {
          return const MyHome();
        })),
    const Pesanpage(),
    const Teampage(),
    const StatistikPage(),
    const SuaraPage(),
    const Keuanganpage(),
  ];
  Widget currentScreen = const HomePage();
  PageController controller = PageController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            bmnav.BottomNavItem(icon: Icons.people_alt_outlined, label: 'Team'),
            bmnav.BottomNavItem(
                icon: Icons.data_exploration_rounded, label: 'Data'),
            bmnav.BottomNavItem(
                icon: Icons.speaker_notes_outlined, label: 'Suara'),
            bmnav.BottomNavItem(
                icon: Icons.money_outlined, label: 'Keuangan')
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   child: Container(
      //     width: 60,
      //     height: 60,
      //     padding: EdgeInsets.only(left: 7, right: 7),
      //     child: Image.asset(
      //       'assets/images/qris.png',
      //       color: whitePrimary,
      //     ),
      //     decoration: const BoxDecoration(
      //         shape: BoxShape.circle,
      //         gradient: LinearGradient(colors: [greenPrimary, greenPrimary])),
      //   ),
      //   onPressed: () {

      //     // Navigator.push(
      //     //     context,
      //     //     MaterialPageRoute(
      //     //         builder: (BuildContext context) => NewScanner22()));
      //   },
      // ),
    );
  }
}
