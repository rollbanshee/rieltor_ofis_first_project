import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rieltor_ofis/ui/screens/authorization/phone.dart';

import '../bottom_navigation_bar/bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (await const FlutterSecureStorage().containsKey(key: 'token') == false) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Phone()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(child: SvgPicture.asset("assets/images/emlak_logo.svg")),
    );
  }
}
