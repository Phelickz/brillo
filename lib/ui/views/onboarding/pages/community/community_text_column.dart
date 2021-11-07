import 'package:brillo/ui/widgets/smart/onboardingWid/col.dart';
import 'package:flutter/material.dart';

class CommunityTextColumn extends StatelessWidget {
  const CommunityTextColumn();

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Community',
      text:
          'Create and connect with a community of people with similar interests.',
    );
  }
}