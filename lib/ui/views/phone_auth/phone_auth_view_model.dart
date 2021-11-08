import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:otp/otp.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import 'phone_auth_view.dart';

class PhoneAuthViewModel extends CustomBaseViewModel {
  Future<void> init() async {}

  // TwilioFlutter twilioFlutter = TwilioFlutter(
  //     accountSid:
  //         "AC8d3a5c45e3dcd15fb835f56cfe15c705", // replace *** with Account SID
  //     authToken:
  //         '290a6e732f10c7cc9ca8c142b078ebfd', // replace xxx with Auth Token
  //     twilioNumber:
  //         "MG7753d6803d19d901b973d83b1247ec76" // replace .... with Twilio Number
  //     );

  Future<TwilioFlutter?> getTwilio() async {
    try {
      DocumentSnapshot data = await FirebaseFirestore.instance
          .collection("Twilio")
          .doc("GPXJzMMttaNWgHtBpeuA")
          .get();

      String accountSid = data['accountSid'];
      String authToken = data['authToken'];
      String twilioNumber = data['twilioNumber'];
      return TwilioFlutter(
        accountSid: accountSid,
        authToken: authToken,
        twilioNumber: twilioNumber,
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
      return null;
    }
  }

  Future<void> phoneAuth(
      {required String phoneNumber,
      required BuildContext context,
      required PhoneAuthViewModel model}) async {
    try {
      setBusy(true);

      //sign in with admin
      UserCredential admin =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "admin@admin.com",
        password: "Smallville98",
      );

      if (admin.user != null) {
        var twilioSer = await getTwilio();

        if (twilioSer != null) {
//query database for phone number
          QuerySnapshot query = await FirebaseFirestore.instance
              .collection("Users")
              .where("phoneNumber", isEqualTo: phoneNumber)
              .get();

          if (query.docs.isNotEmpty) {
            //get the data
            Map<String, dynamic> userData =
                query.docs.first.data() as Map<String, dynamic>;

            //sign out admin
            await FirebaseAuth.instance.signOut();

            //sign in user
            UserCredential newUser =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: userData['email'],
              password: userData['password'],
            );

            if (newUser.user != null) {
              //send otp
              String token = OTP.generateTOTPCodeString(
                  "JBSWY3DPEHPK3PXP", DateTime.now().millisecond,
                  length: 5);
              var value = await twilioSer.sendSMS(
                  toNumber: phoneNumber,
                  messageBody:
                      'Your BrilloConnect verification code is $token');
              setBusy(false);

              //navigate
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EnterOtp2(
                    model: model,
                    phoneNumber: phoneNumber,
                    token: token,
                  ),
                ),
              );
            }
          } else {
             //sign out admin
            await FirebaseAuth.instance.signOut();
            setBusy(false);
            OneContext.instance.showSnackBar(
              builder: (context) => SnackBar(
                backgroundColor: Colors.red[300],
                content: Text(
                  'User does not exist',
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
    } catch (e) {
      setBusy(false);
      print(e);
      OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.red[300],
          content: Text(
            "Authentication could not be completed",
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
