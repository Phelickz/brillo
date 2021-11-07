import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_context/one_context.dart';

class UpdateUsernameViewModel extends CustomBaseViewModel {
  final _routerService = locator<RouterService>();
  Future<void> init() async {}

  Future<void> updateUsername(String username) async {
    try {
      setBusy(true);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"username": username});
      await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
      await FirebaseAuth.instance.currentUser!.reload();
      setBusy(false);
      OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Username updated',
            style: GoogleFonts.dmSans(color: Colors.white),
          ),
        ),
      );
      _routerService.router.pop();
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
