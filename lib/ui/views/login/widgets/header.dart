import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/res.dart';
import 'package:brillo/app/utils/theme.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/logo.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Logo(
            color: kBlue,
            size: 48.0,
          ),
          const SizedBox(height: kSpaceM),
          Text('Welcome to BrilloConnect',
              style: CustomThemeData.generateStyle(
                fontSize: McGyver.textSize(context, 2.9),
                color: Colors.black,
                fontWeight: FontWeight.bold
              )),
          const SizedBox(height: kSpaceS),
          Text(
            'Your number one community for trending sports topics.',
            style: CustomThemeData.generateStyle(
                fontSize: McGyver.textSize(context, 2),
                color: Colors.black,
              ),
          ),
        ],
      ),
    );
  }
}
