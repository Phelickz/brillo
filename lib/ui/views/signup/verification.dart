import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/res.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/views/login/login.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: McGyver.rsDoubleW(context, 5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpaceMedium(context),
              verticalSpaceMedium(context),
              Logo(color: kBlue, size: 48),
              verticalSpaceSmall(context),
              Text(
                'Yaay! Confirm Your Email',
                style: CustomThemeData.generateStyle(
                    fontSize: McGyver.textSize(context, 2.7),
                    color: kDarkBlue,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpaceSmall(context),
              Text(
                'Please check your email for confirmation mail. Click link in email to verify your account.',
                textAlign: TextAlign.center,
                style: CustomThemeData.generateStyle(
                  fontSize: McGyver.textSize(context, 1.8),
                  color: kBlack,
                ),
              ),
              verticalSpaceMedium(context),
              Image.asset(
                'assets/images/mobile-phone.png',
                height: McGyver.rsDoubleH(context, 30),
              ),
              verticalSpaceSmall(context),
              verticalSpaceSmall(context),
              CustomButtons.gradientButton(
                context: context,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                text: 'Proceed to Login',
              ),
              verticalSpaceSmall(context),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.currentUser!
                      .sendEmailVerification()
                      .then(
                        (value) => {
                          OneContext.instance.showSnackBar(
                            builder: (context) => SnackBar(
                              content: Text(
                                  'A new verification email has been sent.'),
                            ),
                          )
                        },
                      );
                },
                child: Text(
                  "Didn't get a link? Resend.",
                  style: CustomThemeData.generateStyle(
                    fontSize: 18,
                    color: kDarkBlue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
