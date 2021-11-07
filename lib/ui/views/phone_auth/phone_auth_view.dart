import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/router/router.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/res.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/app/utils/theme.dart';
// import 'package:brillo/ui/views/bottomNav/bottom.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:brillo/ui/widgets/dumb/skeleton.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/logo.dart';
import 'package:brillo/ui/widgets/smart/phone/textfield.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:stacked/stacked.dart';

import './phone_auth_view_model.dart';

class PhoneAuthView extends StatefulWidget {
  @override
  _PhoneAuthViewState createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  FocusNode _focusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  String _completeNumber = '';
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhoneAuthViewModel>.reactive(
      viewModelBuilder: () => PhoneAuthViewModel(),
      onModelReady: (PhoneAuthViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        PhoneAuthViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          backgroundColor: kWhite,
          isBusy: model.isBusy,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium(context),
                Logo(color: kBlue, size: 48),
                verticalSpaceMedium(context),
                Text(
                  'Welcome back!',
                  style: CustomThemeData.generateStyle(
                    fontSize: McGyver.textSize(context, 2.9),
                    color: kDarkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceSmall(context),
                Text(
                  'Please enter your phone number',
                  style: CustomThemeData.generateStyle(
                    fontSize: McGyver.textSize(context, 1.9),
                    color: kBlack,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                verticalSpaceSmall(context),
                verticalSpaceSmall(context),
                IntlPhoneField(
                  controller: _phoneController,
                  focusNode: _focusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid phone number";
                    }
                    return null;
                  },
                  showDropdownIcon: false,
                  // initialCountryCode: viewModel.text,
                  onChanged: (phone) {
                    print(phone.completeNumber);
                    setState(() {
                      // _text = phone.number;
                      _completeNumber = phone.completeNumber;
                    });
                    // viewModel.setPhone(phone.toString());
                  },
                  // onChange: (value) {
                  //   setState(() {
                  //     _text = value;
                  //   });
                  // },
                ),
                verticalSpaceMedium(context),
                CustomButtons.gradientButton(
                    context: context,
                    onTap: () {
                      model.phoneAuth(
                          phoneNumber: _completeNumber,
                          context: context,
                          model: model);
                    },
                    text: 'Continue'),
                verticalSpaceSmall(context),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EnterOtp2 extends StatefulWidget {
  const EnterOtp2(
      {Key? key,
      required this.token,
      required this.model,
      required this.phoneNumber})
      : super(key: key);
  final String token;
  final PhoneAuthViewModel model;
  final String phoneNumber;

  @override
  _EnterOtpState createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp2> {
  String otp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceMedium(context),
              Logo(
                color: kBlue,
                size: 48,
              ),
              verticalSpaceMedium(context),
              Text(
                "Verify Your Phone Number",
                style: CustomThemeData.generateStyle(
                  fontSize: McGyver.textSize(context, 2.9),
                  color: kDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpaceSmall(context),
              Text(
                'A verification code has been sent to your mobile phone. Enter the code below to proceed.',
                style: CustomThemeData.generateStyle(
                  fontSize: McGyver.textSize(context, 1.9),
                  color: kBlack,
                ),
              ),
              verticalSpaceMedium(context),
              verticalSpaceSmall(context),
              Align(
                alignment: Alignment.center,
                child: OTPTextField(
                  length: 5,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: McGyver.rsDoubleW(context, 10),
                  fieldStyle: FieldStyle.box,
                  style: TextStyle(fontSize: 17, color: Colors.black),
                  onChanged: (pin) {
                    // viewModel.setPin(pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                    setState(() {
                      otp = pin;
                    });
                    // viewModel.setPin(pin);
                  },
                ),
              ),
              verticalSpaceMedium(context),
              verticalSpaceSmall(context),
              CustomButtons.gradientButton(
                  context: context,
                  onTap: () {
                    final RouterService _routerService =
                        locator<RouterService>();
                    if (otp == widget.token) {
                      _routerService.router.push(BottomNav());
                    } else {
                      OneContext.instance.showSnackBar(
                        builder: (context) => SnackBar(
                          content: Text(
                            'Invalid token',
                            style: CustomThemeData.generateStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red[400],
                        ),
                      );
                    }
                  },
                  text: 'Confirm'),
              verticalSpaceSmall(context),
            ],
          ),
        ),
      ),
    );
  }
}
