
import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/icon_container.dart';
import 'package:flutter/material.dart';

class WorkLightCardContent extends StatelessWidget {
  const WorkLightCardContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconContainer(
          icon: Icons.event_seat,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.business_center,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.assessment,
          padding: kPaddingS,
        ),
      ],
    );
  }
}