import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rieltor_ofis/ui/screens/splash_screen/secondmain.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: Future.wait([
                secureStorage.read(key: "name"),
                secureStorage.read(key: "phone"),
              ]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisAlignment: MainAxisAlignment.,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Profil",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Column(
                          children: [
                            SvgPicture.asset("assets/images/UserCircle.svg"),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              snapshot.data![0]!,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "+994 ${snapshot.data![1]!}",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          "",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.sp),
                        ),
                        Text(
                          "",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.sp),
                        ),
                        Text(
                          "",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.sp),
                        ),
                        InkWell(
                          // splashColor: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: () {
                            FlutterSecureStorage().delete(key: 'token');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SplashScreen()));
                          },
                          child: Ink(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(34, 186, 104, 1),
                                borderRadius: BorderRadius.circular(16.r)),
                            child: Text(
                              "Çıxış",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}
