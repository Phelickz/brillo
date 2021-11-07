import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_context/one_context.dart';

class ForgotPasswordViewModel extends CustomBaseViewModel {
  Future<void> init() async {}

  Future<void> resetPassword(String email) async {
    try {
      setBusy(true);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setBusy(false);
      OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "A link to reset your password has been sent to $email",
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      );
    } on FirebaseException catch (e) {
      setBusy(false);
      OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.red[400],
          content: Text(
            e.message!,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
