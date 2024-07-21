// import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_model.dart';

import 'modal_bottom_sheet.dart';

Future<void> Function(BuildContext) dotomodalbottomsheet() {
  return (BuildContext context) async {
    final provider = context.read<FoldersModel>();
    await Flushbar(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 24.w, 15.h),
      mainButton: ElevatedButton(
        onPressed: () async {
          await provider.getFolders();
          await provider.getFoldersByAnnounces(provider.announceId);
          modalbottomsheet(context);
        },
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            Color.fromRGBO(0, 80, 235, 0.1),
          ),
        ),
        child: Text(
          "Dəyişmək",
          style: TextStyle(
            color: Color.fromRGBO(0, 80, 235, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(20.r),
      boxShadows: [
        BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8),
      ],
      backgroundColor: Color.fromRGBO(234, 241, 255, 1),
      margin: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 80.h),
      flushbarStyle: FlushbarStyle.FLOATING,
      messageText: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: "Ümumi ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: "qovluqa əlavə\nolundu",
            style: TextStyle(
              height: 1.5.h,
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          )
        ]),
      ),
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);
  };
}

SnackBar frommodalbottomsheet(BuildContext context) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    // margin: EdgeInsets.all(10),
    // padding: EdgeInsets.only(bottom: 10),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    backgroundColor: Colors.green.shade50,
    duration: Duration(seconds: 3),
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/CheckCircle.svg"),
        SizedBox(
          width: 14.w,
        ),
        Text("Əməliyyat uğurlu oldu!",
            style: (TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(11, 192, 18, 1))))
      ],
    ),
  );

  // Flushbar(
  //   isDismissible: true,
  //   padding: EdgeInsets.symmetric(vertical: 15.h),
  //   messageText: Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SvgPicture.asset("assets/images/CheckCircle.svg"),
  //       SizedBox(
  //         width: 14.w,
  //       ),
  //       Text("Əməliyyat uğurlu oldu!",
  //           style: (TextStyle(
  //               fontSize: 14.sp,
  //               fontWeight: FontWeight.w700,
  //               color: Color.fromRGBO(11, 192, 18, 1))))
  //     ],
  //   ),
  //   backgroundColor: Colors.green.shade50,
  //   borderRadius: BorderRadius.circular(20.r),
  //   boxShadows: [
  //     BoxShadow(
  //       color: Colors.grey.withOpacity(0.5),
  //       blurRadius: 8,
  //     )
  //   ],
  //   margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 90.h),
  //   flushbarStyle: FlushbarStyle.FLOATING,
  //   duration: Duration(seconds: 2),
  //   flushbarPosition: FlushbarPosition.BOTTOM,
  // ).show(context);
}
