import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bottom_navigation_bar/bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromRGBO(34, 186, 104, 1),
        child: SvgPicture.asset("assets/images/emlak_logo.svg",
            fit: BoxFit.scaleDown),
      ),
    );
  }
}
