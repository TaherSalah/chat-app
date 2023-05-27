import 'dart:async';

import 'package:chat_app/screens/home.dart';
import 'package:chat_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shard/widget/images_path.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 10),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const     SizedBox(height: 50,),
                Image.asset(
                  ImagesPath.splashGif,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height/3,
                  // width: 500,
                ),
              ],
            ),
            Text(
              'Welcome Back',
              style: GoogleFonts.cairo(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
            ),
            Text(
              'To',
              style: GoogleFonts.cairo(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
            ),
             Text(
              'Friends Chat !',
              style: GoogleFonts.cairo(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
            ),
            const CircularProgressIndicator(),
            const SizedBox(height: 30,),

          ],
        ),
      ),
    );
  }
}
