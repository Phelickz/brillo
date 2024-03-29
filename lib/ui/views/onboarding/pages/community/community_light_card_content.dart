import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/icon_container.dart';
import 'package:flutter/material.dart';

class CommunityLightCardContent extends StatelessWidget {
  const CommunityLightCardContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconContainer(
          icon: Icons.person,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.group,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.insert_emoticon,
          padding: kPaddingS,
        ),
      ],
    );
  }
}