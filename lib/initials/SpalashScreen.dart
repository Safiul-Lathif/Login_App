import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/initials/HomePage.dart';
import 'package:login/initials/login.dart';
import 'package:login/manager/sectionManagement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({super.key});

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  @override
  String? username;
  String? password;
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
      SessionManager preferences = new SessionManager();
      String? token = await preferences.getAuthToken();
      //  SharedPreferences preferences = await SharedPreferences.getInstance();
      // String? username = preferences.getString("username");
      // print(token);

      // print(username);
      if (token != null && token != "") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }
}
