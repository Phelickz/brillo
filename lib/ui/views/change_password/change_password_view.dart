import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/dumb/field.dart';
import 'package:brillo/ui/widgets/dumb/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  final password = TextEditingController();
  final oldPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      viewModelBuilder: () => ChangePasswordViewModel(),
      onModelReady: (ChangePasswordViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        ChangePasswordViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          backgroundColor: kWhite,
          appBar: AppBar(
            backgroundColor: kDarkBlue,
            title: Text(
              'Change Password',
              style: GoogleFonts.dmSans(color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              ),
            ),
          ),
          isBusy: model.isBusy,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  verticalSpaceXSmall(context),
                  verticalSpaceSmall(context),
                  SignupTextFields(
                    label: 'Old Password',
                    controller: oldPassword,
                    password: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return "Password must be up to 8 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSpaceXSmall(context),
                  SignupTextFields(
                    label: 'New Password',
                    password: true,
                    controller: password,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return "Password must be up to 8 characters";
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
                        model.updatePassword(
                            newPassword: password.text,
                            oldPassword: oldPassword.text);
                      }
                    },
                    text: 'Update',
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
