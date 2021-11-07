import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/dumb/field.dart';
import 'package:brillo/ui/widgets/dumb/skeleton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './update_username_view_model.dart';

class UpdateUsernameView extends StatefulWidget {
  @override
  _UpdateUsernameViewState createState() => _UpdateUsernameViewState();
}

class _UpdateUsernameViewState extends State<UpdateUsernameView> {
  final username = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      username.text = FirebaseAuth.instance.currentUser!.displayName!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateUsernameViewModel>.reactive(
      viewModelBuilder: () => UpdateUsernameViewModel(),
      onModelReady: (UpdateUsernameViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        UpdateUsernameViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          backgroundColor: kWhite,
          appBar: AppBar(
            backgroundColor: kDarkBlue,
            title: Text(
              'Change Username',
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
                verticalSpaceSmall(context),
                verticalSpaceXSmall(context),
                SignupTextFields(
                  label: 'Username',
                  controller: username,
                  keyboardType: TextInputType.text,
                ),
                verticalSpaceMedium(context),
                CustomButtons.gradientButton(
                  context: context,
                  onTap: () {
                    model.updateUsername(username.text);
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
