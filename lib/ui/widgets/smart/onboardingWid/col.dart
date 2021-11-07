
import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/res.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextColumn extends StatelessWidget {
  final String title;
  final String text;

  const TextColumn({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            color: kWhite,
            fontWeight: FontWeight.bold,
            fontSize: McGyver.textSize(context, 2.9)
          )
        ),
        const SizedBox(height: kSpaceS),
        Text(
          text,
          textAlign: TextAlign.center,
          style:  GoogleFonts.dmSans(
            color: kWhite,
            fontWeight: FontWeight.normal,
            fontSize: McGyver.textSize(context, 2)
          )
        ),
      ],
    );
  }
}