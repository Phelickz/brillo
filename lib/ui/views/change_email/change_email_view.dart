import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/dumb/field.dart';
import 'package:brillo/ui/widgets/dumb/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './change_email_view_model.dart';

class ChangeEmailView extends StatelessWidget {
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangeEmailViewModel>.reactive(
      viewModelBuilder: () => ChangeEmailViewModel(),
      onModelReady: (ChangeEmailViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        ChangeEmailViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          backgroundColor: kWhite,
          appBar: AppBar(
            backgroundColor: kDarkBlue,
            title: Text(
              'Change Email',
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
            child: Column(
              children: [
                verticalSpaceXSmall(context),
                verticalSpaceSmall(context),
                SignupTextFields(
                  label: 'Email',
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                ),
                verticalSpaceMedium(context),
                CustomButtons.gradientButton(
                  context: context,
                  onTap: () {
                    model.updateEmail(email.text);
                  },
                  text: 'Update',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
