import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/dumb/field.dart';
import 'package:brillo/ui/widgets/dumb/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import './forgot_password_view_model.dart';

class ForgotPasswordView extends StatelessWidget {
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      onModelReady: (ForgotPasswordViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        ForgotPasswordViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          backgroundColor: kWhite,
          appBar: AppBar(
            backgroundColor: kDarkBlue,
            title: Text('Forgot Password'),
          ),
          isBusy: model.isBusy,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  verticalSpaceMedium(context),
                  SignupTextFields(
                    label: "Email",
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!GetUtils.isEmail(value!)) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSpaceMedium(context),
                  CustomButtons.gradientButton(
                    context: context,
                    onTap: () {
                      final form = formKey.currentState;
                      if (form!.validate()) {
                        model.resetPassword(email.text);
                      }
                    },
                    text: 'Submit',
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
