import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/icon_container.dart';
import 'package:flutter/material.dart';

class EducationLightCardContent extends StatelessWidget {
  const EducationLightCardContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconContainer(
          icon: Icons.brush,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.camera_alt,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.straighten,
          padding: kPaddingS,
        ),
      ],
    );
  }
}