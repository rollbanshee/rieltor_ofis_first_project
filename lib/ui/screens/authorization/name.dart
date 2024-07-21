import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/bottom_navigation_bar/bottom_navigation_bar.dart';

import 'auth_model.dart';

class Name extends StatelessWidget {
  const Name({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthModel>();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisAlignment: MainAxisAlignment.,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Son addım",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          Column(
            children: [
              TextField(
                controller: provider.name,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  hintText: " Adınızı qeyd edin",
                  hoverColor: Colors.green,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(233, 233, 233, 1), width: 1.w)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(233, 233, 233, 1), width: 1.w)),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              InkWell(
                // splashColor: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  if (provider.name.text.isEmpty) {
                    nameError(context);
                  } else {
                    provider.postName(provider.name.text).then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BottomNavBar())));
                  }
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Text(
                    "Dəvam et",
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
          Text(
            "Daxil ol",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.transparent,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    )));
  }
}

void nameError(BuildContext context) {
  Flushbar(
    // isDismissible: true,
    // dismissDirection: FlushbarDismissDirection.VERTICAL,
    shouldIconPulse: false,
    icon: Icon(
      Icons.error,
      size: 32,
      color: Colors.white,
    ),
    messageText: Text("Ad mecburidir!",
        textAlign: TextAlign.center,
        style: (TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white))),
    backgroundColor: Colors.red,
    borderRadius: BorderRadius.circular(20.r),
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        blurRadius: 8,
      )
    ],
    margin: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 0.h),
    flushbarStyle: FlushbarStyle.FLOATING,
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}
