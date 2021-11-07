import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/res.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/views/bottomNav/bottom.dart';
import 'package:brillo/ui/views/phone_verify/phone_verify_view.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/dumb/field.dart';
import 'package:brillo/ui/widgets/dumb/skeleton.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/logo.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:stacked/stacked.dart';

import './sports_type_view_model.dart';

class SportsTypeView extends StatelessWidget {
  final interest = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SportsTypeViewModel>.reactive(
      viewModelBuilder: () => SportsTypeViewModel(),
      onModelReady: (SportsTypeViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        SportsTypeViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          isBusy: model.isBusy,
          backgroundColor: kWhite,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium(context),
                Logo(color: kBlue, size: 48),
                verticalSpaceMedium(context),
                Text(
                  "You're almost done! One more Step.",
                  style: CustomThemeData.generateStyle(
                    fontSize: McGyver.textSize(context, 2.9),
                    color: kDarkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceSmall(context),
                Text(
                  'Specify your sports interest - Football, Baseball, IceHockey, etc..',
                  style: CustomThemeData.generateStyle(
                    fontSize: McGyver.textSize(context, 1.9),
                    color: kBlack,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                verticalSpaceMedium(context),
                SignupTextFields(
                  label: 'Interests',
                  controller: interest,
                  keyboardType: TextInputType.text,
                ),
                verticalSpaceMedium(context),
                verticalSpaceMedium(context),
                CustomButtons.gradientButton(
                  context: context,
                  onTap: () {
                    if (interest.text.isNotEmpty) {
                      //save interest
                      model.saveInterest(
                          interest: interest.text, context: context);
                    } else {
                      OneContext.instance.showSnackBar(
                        builder: (context) => SnackBar(
                          backgroundColor: Colors.red[400],
                          content: Text(
                            "Please, specify an interest.",
                            style: CustomThemeData.generateStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => EnterOtp(token: '12345',)));
                  },
                  text: 'Continue',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
