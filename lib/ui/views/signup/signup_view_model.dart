import 'package:advance_notification/advance_notification.dart';
import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/views/signup/verification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class SignupViewModel extends CustomBaseViewModel {
  final firebase = FirebaseAuth.instance;
  final RouterService _routerService = locator<RouterService>();
  Future<void> init() async {}

  Future<User?> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      setBusy(true);
      UserCredential user = await firebase.createUserWithEmailAndPassword(
          email: email, password: password);

      if (user.user != null && !user.user!.emailVerified) {
        await user.user!.sendEmailVerification();
        await user.user!.updateDisplayName(user.user!.email!.split('@')[0]);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.user!.uid)
            .set({
          "email": email,
          "password": password,
          "phoneNumber": "",
          "interests": "",
          "uid": user.user!.uid,
          "username": user.user!.email!.split('@')[0]
        });
        setBusy(false);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VerifyEmail(email: email)));
      }
    } on FirebaseAuthException catch (e) {
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
