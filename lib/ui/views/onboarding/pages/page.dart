
import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/cards_stack.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final int number;
  final Widget lightCardChild;
  final Widget darkCardChild;
  final Animation<Offset> lightCardOffsetAnimation;
  final Animation<Offset> darkCardOffsetAnimation;
  final Widget textColumn;

  const OnboardingPage({
    required this.number,
    required this.lightCardChild,
    required this.darkCardChild,
    required this.lightCardOffsetAnimation,
    required this.darkCardOffsetAnimation,
    required this.textColumn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CardsStack(
          pageNumber: number,
          lightCardChild: lightCardChild,
          darkCardChild: darkCardChild,
          lightCardOffsetAnimation: lightCardOffsetAnimation,
          darkCardOffsetAnimation: darkCardOffsetAnimation,
        ),
        SizedBox(height: number % 2 == 1 ? 50.0 : 25.0),
        AnimatedSwitcher(
          duration: kCardAnimationDuration,
          child: textColumn,
        ),
      ],
    );
  }
}