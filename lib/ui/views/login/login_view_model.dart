import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/router/router.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/views/bottomNav/bottom.dart' as bn;
import 'package:brillo/ui/views/signup/verification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class LoginViewModel extends CustomBaseViewModel {
  Future<void> init() async {}
  final RouterService _routerService = locator<RouterService>();

  final firebase = FirebaseAuth.instance;

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      setBusy(true);
      UserCredential user = await firebase.signInWithEmailAndPassword(
          email: email, password: password);

      if (user.user != null) {
        if (!user.user!.emailVerified) {
          setBusy(false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyEmail(email: email),
            ),
          );
        } else {
          DocumentSnapshot document = await FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();

          if (document['interests'].toString().isEmpty) {
            setBusy(false);
            _routerService.router.push(PhoneVerifyRoute());
          } else {
            setBusy(false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => bn.BottomNav(),
              ),
            );
          }

          //Navigate to next page
        }
      }
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.red[300],
          content: Text(
            e.message!,
            style: CustomThemeData.generateStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
      );
    } on FirebaseException catch (e) {
      setBusy(false);
      OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.red[300],
          content: Text(
            e.message!,
            style: CustomThemeData.generateStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
