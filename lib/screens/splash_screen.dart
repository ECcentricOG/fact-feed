import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_apk/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              height: MediaQuery.of(context).size.height / 3,
              "assets/9977737.jpg",
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "FACT FEED",
              style: GoogleFonts.anton(
                letterSpacing: 6,
                fontSize: 25,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SpinKitChasingDots(
              color: Colors.deepPurple,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
