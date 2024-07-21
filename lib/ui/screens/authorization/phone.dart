import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/authorization/auth_model.dart';
import 'package:rieltor_ofis/ui/screens/authorization/code.dart';

var _maskFormatter = MaskTextInputFormatter(
    type: MaskAutoCompletionType.lazy,
    mask: '(##)-###-##-##',
    filter: {"#": RegExp(r'[0-9]')});

class Phone extends StatelessWidget {
  const Phone({super.key});

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
            "Daxil ol",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          Column(
            children: [
              Text(
                "Daxil olmaq üçün mobil nömrənizi yazın",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 16.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: provider.phone,
                inputFormatters: [_maskFormatter],
                keyboardType: TextInputType.phone,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  prefixIcon: Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, top: 15.h, bottom: 15.h),
                      child: Text(
                        "+(994) | ",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      )),
                  hintText: '(00)-000-00-00',
                  hoverColor: Colors.green,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(233, 233, 233, 1), width: 1.w)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(233, 233, 233, 1), width: 1.w)),
                  isCollapsed: true,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              InkWell(
                // splashColor: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  if (provider.phone.text.length < 14) {
                    return phoneError(context);
                  } else {
                    provider.postPhone(provider.phone);
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Code()));
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
              SizedBox(height: 10.h),
              Text(
                "Qeydiyyatdan keçərək İsfadəçi razılaşması və Məxfilik siyasətini qəbul etdiyinizi təsdiq edirsiniz.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14.sp),
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

void phoneError(BuildContext context) {
  Flushbar(
    // isDismissible: true,
    // dismissDirection: FlushbarDismissDirection.VERTICAL,
    shouldIconPulse: false,
    icon: Icon(
      Icons.error,
      size: 32,
      color: Colors.white,
    ),
    messageText: Text(
        "Telefon nomresi 9 simvoldan ibaret olmalidir (00)-000-00-00",
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
