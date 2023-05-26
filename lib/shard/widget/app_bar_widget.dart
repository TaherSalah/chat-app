import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';

Widget defAppBar(){
  return  Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(IconBroken.Chat, size: 35,color: Colors.white,),
      const SizedBox(
        width: 20,
      ),
      Text(
        'Friends Chat',
        style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white),
      )
    ],
  );
}