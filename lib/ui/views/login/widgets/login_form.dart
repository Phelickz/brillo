import 'package:brillo/app/utils/size.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/dumb/field.dart';
import 'package:flutter/material.dart';

import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/router/router.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:brillo/app/utils/constants.dart';
import 'package:get/get.dart';

import '../login_view_model.dart';
import 'custom_button.dart';
import 'custom_input_field.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
    required this.model,
  }) : super(key: key);
  final LoginViewModel model;
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SignupTextFields(
                label: 'Email',
                controller: email,
                validator: (String? email) {
                  if (GetUtils.isEmail(email!)) {
                    return 'Please enter a valid email address';
                  } else {
                    return '';
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
                validator: (String? value) {
                  if (value == null || value.length < 8) {
                    return 'Password must be above 8 characters';
                  } else {
                    return '';
                  }
                },
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black45,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: space),
              CustomButtons.gradientButton(
                context: context,
                onTap: () {
                  final form = formKey.currentState;
      
                  if (form!.validate()) {
                    model.login(
                      email: email.text,
                      password: password.text,
                      context: context,
                    );
                  }
                },
                text: 'Sign In',
              ),
              SizedBox(height: 2 * space),
              CustomButton(
                color: kWhite,
                textColor: kBlack.withOpacity(0.5),
                text: 'Continue with Google',
                // image: Image(
                //   image: AssetImage(kGoogleLogoPath),
                //   height: 48.0,
                // ),
                onPressed: () {},
              ),
              SizedBox(height: space),
              CustomButton(
                color: kBlack,
                textColor: kWhite,
                text: 'Create a Bubble Account',
                onPressed: () {
                  final RouterService _routerService = locator<RouterService>();
                  _routerService.router.push(SignupRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
