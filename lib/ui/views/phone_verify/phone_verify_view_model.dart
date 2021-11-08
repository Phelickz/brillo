import 'package:brillo/app/core/custom_base_view_model.dart';
import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/router/router.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/views/phone_verify/phone_verify_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:otp/otp.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class PhoneVerifyViewModel extends CustomBaseViewModel {
  Future<void> init() async {}

  final RouterService _routerService = locator<RouterService>();

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

  Future<void> sendOTP(
      {String? number,
      required BuildContext context,
      required PhoneVerifyViewModel model}) async {
    try {
      TwilioFlutter? twilioFlutter = await getTwilio();
      if (twilioFlutter != null) {
        String token = OTP.generateTOTPCodeString(
            "JBSWY3DPEHPK3PXP", DateTime.now().millisecond,
            length: 5);
        setBusy(true);
        var value = await twilioFlutter.sendSMS(
            toNumber: number!,
            messageBody: 'Your BrilloConnect verification code is $token');
        print(value);
        setBusy(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EnterOtp(
              model: model,
              phoneNumber: number,
              token: token,
            ),
          ),
        );
      }
    } on Exception catch (e) {
      setBusy(false);
      OneContext.instance.showSnackBar(
        builder: (context) => SnackBar(
          backgroundColor: Colors.red[400],
          content: Text(
            'Something went wrong, try again.',
            style: CustomThemeData.generateStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      );
      print(e);
    }
  }

  Future<void> savePhone({String? phoneNumber}) async {
    try {
      setBusy(true);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"phoneNumber": phoneNumber});
      setBusy(false);
      _routerService.router.push(SportsTypeRoute());
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
