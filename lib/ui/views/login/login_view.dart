import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/router/router.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/res.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/views/signup/signup_view.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/dumb/field.dart';
import 'package:brillo/ui/widgets/dumb/skeleton.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './login_view_model.dart';

class LoginView extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (LoginViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        LoginViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          isBusy: model.isBusy,
          // bodyPadding: EdgeInsets.zero,
          // resizeToAvoidBottomInset: false,
          backgroundColor: kWhite,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceMedium(context),
                  verticalSpaceSmall(context),
                  const Logo(
                    color: kBlue,
                    size: 38.0,
                  ),
                  verticalSpaceSmall(context),
                  Text(
                    "Hey there!\nWelcome back!",
                    style: GoogleFonts.dmSans(
                      fontSize: McGyver.textSize(context, 2.7),
                      color: kBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpaceMedium(context),
                  verticalSpaceSmall(context),
                  SignupTextFields(
                    label: 'Email',
                    controller: email,
                    validator: (String? email) {
                      if (!GetUtils.isEmail(email!)) {
                        print(GetUtils.isEmail(email));
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black45,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  verticalSpaceSmall(context),
                  SignupTextFields(
                    label: 'Password',
                    controller: password,
                    password: true,
                    validator: (String? value) {
                      if (value == null || value.length < 8) {
                        return 'Password must be above 8 characters';
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.black45,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  verticalSpaceMedium(context),
                  CustomButtons.gradientButton(
                    context: context,
                    onTap: () {
                      final form = formKey.currentState;

                      if (form!.validate() == true) {
                        model.login(
                          email: email.text,
                          password: password.text,
                          context: context,
                        );
                      }
                    },
                    text: 'Sign In',
                  ),
                  verticalSpaceSmall(context),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        final router = locator<RouterService>();
                        router.router.push(PhoneAuthRoute());
                      },
                      child: Text(
                        'Use phone number instead?',
                        style: GoogleFonts.dmSans(
                          color: kDarkBlue,
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceSmall(context),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: (McGyver.rsDoubleW(context, 80)) / 2,
                          child: Divider(
                            color: Colors.black38,
                            height: 10,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Or',
                        style: CustomThemeData.generateStyle(
                          fontSize: McGyver.textSize(context, 1.8),
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: (McGyver.rsDoubleW(context, 80)) / 2,
                          child: Divider(
                            color: Colors.black38,
                            height: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceSmall(context),
                  CustomButtons.generalButton(
                    context: context,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupView(),
                        ),
                      );
                    },
                    text: 'Sign Up',
                  ),
                  verticalSpaceXSmall(context),
                  verticalSpaceSmall(context),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          final router = locator<RouterService>();
                          router.router.push(ForgotPasswordRoute());
                        },
                        child: Text(
                          'Forgot Password?',
                          style: CustomThemeData.generateStyle(
                            fontSize: 14,
                            color: kDarkBlue,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
