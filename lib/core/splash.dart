import 'package:flutter/material.dart';
import 'package:la7azat_zekr_v3/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), (){
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainPage(),),(route) => false,);
    });
    return SafeArea(
      child: Scaffold(
        body: Image.asset(
            fit: BoxFit.fitWidth,
            height: double.infinity,
            width: double.infinity,
            "assets/images/la7azatzekr.jpg"),
      ),
    );
  }
}
