import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_screen.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/main_screen.dart';
import 'package:rieltor_ofis/ui/screens/profile/profile.dart';

import '../search/search.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int initialIndex = 0;

  void selectedTab(int index) {
    if (initialIndex == index) return;
    setState(() {
      initialIndex = index;
    });
  }

  List<Widget> widgets = <Widget>[
    // MainScreen(),
    // MainScreen(),
    // MainScreen(),
    MainScreen(),
    MainFoldersScreen(),
    Search(
      selectWidget: true,
    ),
    Profile(),
    // MainScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgets[initialIndex],
      ),
      // body: IndexedStack(
      //   index: initialIndex,
      //   children: [
      //     MainScreen(),
      //     MainScreen(),
      //     MainScreen(),
      //     MainScreen(),
      //     MainScreen(),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          elevation: 0,
          onTap: selectedTab,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              color: Colors.black),
          selectedItemColor: Color.fromRGBO(60, 150, 255, 1),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              color: Colors.black),
          currentIndex: initialIndex,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/House.svg",
                    // color: Color.fromRGBO(51, 51, 51, 1),
                    width: 26.w,
                    height: 26.h,
                  ),
                  SizedBox(
                    height: 5.h,
                  )
                ],
              ),
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/House.svg",
                    color: Color.fromRGBO(60, 150, 255, 1),
                    width: 26.w,
                    height: 26.h,
                  ),
                  SizedBox(
                    height: 5.h,
                  )
                ],
              ),
              label: "Baş Səhifə",
            ),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/HeartStraight.svg",
                      // color: changeColor(1),
                      width: 26.w,
                      height: 26.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
                activeIcon: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/HeartStraight.svg",
                      color: Color.fromRGBO(60, 150, 255, 1),
                      width: 26.w,
                      height: 26.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
                label: "Seçilmişlər"),
            // BottomNavigationBarItem(
            //   label: "",
            //   icon: Padding(
            //     padding: EdgeInsets.only(top: 3.0.h),
            //     child: Container(
            //       child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: SvgPicture.asset(
            //             "assets/images/MapTrifold.svg",
            //             width: 24.w,
            //             height: 24.h,
            //             color: const Color.fromRGBO(255, 255, 255, 1),
            //           )),
            //       width: 44.w,
            //       height: 44.h,
            //       decoration: BoxDecoration(
            //         color: Color.fromRGBO(34, 186, 104, 1),
            //         shape: BoxShape.circle,
            //       ),
            //     ),
            //   ),
            // ),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Union.svg",
                      // color: changeColor(3),
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
                activeIcon: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Union.svg",
                      color: Color.fromRGBO(60, 150, 255, 1),
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
                label: "Axtarış"),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Profile.svg",
                      // color: Color.fromRGBO(51, 51, 51, 1),
                      width: 26.w,
                      height: 26.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
                activeIcon: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Profile.svg",
                      color: Color.fromRGBO(60, 150, 255, 1),
                      width: 26.w,
                      height: 26.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
                label: "Profil"),
          ]),
    );
  }

  // Color changeColor(int index) {
  //   return initialIndex == index
  //       ? Color.fromRGBO(60, 150, 255, 1)
  //       : Color.fromRGBO(51, 51, 51, 1);
  // }
}
