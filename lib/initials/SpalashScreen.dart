// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/initials/login.dart';
import 'package:login/initials/mainScreen.dart';
import 'package:login/manager/sectionManagement.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({super.key});

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  String? username;
  String? password;
  @override
  void initState() {
    super.initState();
    _navigatetonHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  height: MediaQuery.of(context).size.height / 4,
                  child: const Image(image: AssetImage("assets/logo.png")),
                ),
                Text("Staff Application",
                    style: GoogleFonts.shadowsIntoLight(
                        fontSize: 33, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigatetonHome() async {
    await Future.delayed(const Duration(seconds: 6), () async {
      SessionManager preferences = SessionManager();
      String? token = await preferences.getAuthToken();
      if (token != null && token != "") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }
}
