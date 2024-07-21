import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/authorization/name.dart';
import 'package:rieltor_ofis/ui/screens/authorization/phone.dart';

import 'auth_model.dart';

class Code extends StatelessWidget {
  const Code({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthModel>();
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
            "SMS kod təsdiqləmə",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          Column(
            children: [
              Text(
                "SMS vasitəsilə telefon nömrənizə         göndərilən kodu daxil edin",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 16.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              PinCodeTextField(
                autoDisposeControllers: false,
                appContext: context,
                length: 4,
                controller: provider.code,
                // controller: provider.code,
                keyboardType: TextInputType.phone,
                // animationCurve: Curves.bounceInOut,
                animationType: AnimationType.scale,
                cursorColor: Colors.grey.shade200,
                cursorHeight: 15.h,
                cursorWidth: 2.w,
                // enableActiveFill: true,
                textStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                // enableActiveFill: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldHeight: 50.h,
                  fieldWidth: 50.w,
                  borderRadius: BorderRadius.circular(12.r),
                  inactiveColor: Colors.grey.shade200,
                  activeColor: Colors.green,
                  selectedColor: Colors.grey.shade200,
                ),

                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(
                height: 15.h,
              ),
              InkWell(
                // splashColor: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  provider.postPhoneCode();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Name()));
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Text(
                    "Təsdiqlə",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14.sp),
              ),
              CountDownTimer()
            ],
          ),
          Text(
            "",
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

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 60);
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(minutes: 3));
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Phone()));
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Center(
      child: Column(
        children: [
          Text(
            '$minutes:$seconds',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
