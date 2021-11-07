import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_context/one_context.dart';

class ChangeEmailViewModel extends CustomBaseViewModel {
  final routerService = locator<RouterService>();

  Future<void> init() async {}

  Future<void> updateEmail(String email) async {
    try {
      setBusy(true);
      //getting password

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      String password = doc['password'];

      //reauthenticating
      UserCredential user = await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(EmailAuthProvider.credential(
              email: FirebaseAuth.instance.currentUser!.email!,
              password: password));

      //changing email
      if (user.user != null) {
        await user.user!.updateEmail(email);
        await user.user!.reload();
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.user!.uid)
            .update({"email": email});
        setBusy(false);
        OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Email updated',
            style: GoogleFonts.dmSans(color: Colors.white),
          ),
        ),
      );
        routerService.router.pop();
      }
      setBusy(false);
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.red[400],
          content: Text(
            e.message!,
            style: GoogleFonts.dmSans(color: Colors.white),
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
            style: GoogleFonts.dmSans(color: Colors.white),
          ),
        ),
      );
    }
  }
}
