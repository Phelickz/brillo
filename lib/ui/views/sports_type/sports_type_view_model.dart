import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/views/bottomNav/bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class SportsTypeViewModel extends CustomBaseViewModel {
  Future<void> init() async {}

  Future<void> saveInterest(
      {required String interest, required BuildContext context}) async {
    try {
      setBusy(true);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"interests": interest});
      setBusy(false);
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNav()));
    } on FirebaseException catch (e) {
      setBusy(false);
      OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.red[400],
          content: Text(
            e.message!,
            style: CustomThemeData.generateStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
