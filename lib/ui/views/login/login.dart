import 'package:brillo/app/locator/locator.dart';
import 'package:brillo/app/router/router.gr.dart';
import 'package:brillo/app/services/router_service.dart';
import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/res.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/views/login/login_view_model.dart';
import 'package:brillo/ui/views/login/widgets/custom_button.dart';
import 'package:brillo/ui/views/login/widgets/custom_clippers/blue_top_clipper.dart';
import 'package:brillo/ui/views/login/widgets/custom_clippers/grey_top_clipper.dart';
import 'package:brillo/ui/views/login/widgets/custom_clippers/white_top_clipper.dart';
import 'package:brillo/ui/views/login/widgets/header.dart';
import 'package:brillo/ui/views/login/widgets/login_form.dart';
import 'package:brillo/ui/widgets/dumb/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Login extends StatefulWidget {
  const Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhite,
      body: Stack(
        children: <Widget>[
          // ClipPath(
          //   clipper: const WhiteTopClipper(),
          //   child: Container(color: kGrey),
          // ),
          // ClipPath(
          //   clipper: const GreyTopClipper(),
          //   child: Container(color: kBlue),
          // ),
          // ClipPath(
          //   clipper: const BlueTopClipper(),
          //   child: Container(color: kWhite),
          // ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: kPaddingL,
                horizontal: McGyver.rsDoubleW(context, 5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Header(),
                    verticalSpaceMedium(context),
                    // Spacer(flex: 1,),
                    // verticalSpaceSmall(context),
                    // verticalSpaceMedium(context),
                    // verticalSpaceMedium(context),
                    verticalSpaceSmall(context),
                    
                    WebsafeSvg.asset('assets/images/Hello-cuate.svg',
                        height: McGyver.rsDoubleH(context, 40)),
                    verticalSpaceSmall(context),
                    CustomButtons.gradientButton(
                      context: context,
                      onTap: () {
                        final RouterService _routerService =
                            locator<RouterService>();
                        _routerService.router.push(LoginRoute());
                      },
                      text: 'Sign In',
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
                    CustomButton(
                      color: kBlack,
                      textColor: kWhite,
                      text: 'Create a Brillo Account',
                      onPressed: () {
                        final RouterService _routerService =
                            locator<RouterService>();
                        _routerService.router.push(SignupRoute());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
